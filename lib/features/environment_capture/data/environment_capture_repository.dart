import 'package:assiette/data/daos/environment_dao.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/data/open_meteo_client.dart';
import 'package:assiette/features/environment_capture/domain/air_quality_reading.dart';
import 'package:assiette/features/environment_capture/domain/environment_capture_repository.dart';
import 'package:assiette/features/environment_capture/domain/hourly_measure.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Drift-backed implementation of [EnvironmentCaptureRepository].
class DriftEnvironmentCaptureRepository implements EnvironmentCaptureRepository {
  /// Creates a [DriftEnvironmentCaptureRepository] backed by the given
  /// collaborators.
  DriftEnvironmentCaptureRepository({
    required EnvironmentDao environmentDao,
    required LocationReader locationReader,
    required OpenMeteoClient openMeteoClient,
  })  : _environmentDao = environmentDao,
        _locationReader = locationReader,
        _openMeteoClient = openMeteoClient;

  final EnvironmentDao _environmentDao;
  final LocationReader _locationReader;
  final OpenMeteoClient _openMeteoClient;

  static const _uuid = Uuid();

  @override
  Future<bool> captureSnapshot() async {
    try {
      final position = await _locationReader.readPosition();
      if (position == null) return false;

      final reading = await _openMeteoClient.fetchCurrent(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      // Air quality comes from a separate Open-Meteo host; its failure must
      // not lose the weather snapshot.
      var airQuality = const AirQualityReading();
      try {
        airQuality = await _openMeteoClient.fetchCurrentAirQuality(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      } on Exception {
        // Keep the nulls: the snapshot is still worth storing.
      }

      final pressure = reading.pressure ?? reading.surfacePressure;
      final previous = await _environmentDao.getLatest();
      final pressureDelta = (pressure != null && previous?.pressure != null)
          ? pressure - previous!.pressure!
          : null;

      await _environmentDao.insertSnapshot(
        EnvironmentSnapshotsCompanion.insert(
          id: _uuid.v4(),
          timestamp: DateTime.now().toUtc(),
          pressure: Value(pressure),
          pressureDelta: Value(pressureDelta),
          temperature: Value(reading.temperature),
          humidity: Value(reading.humidity),
          lat: Value(position.latitude),
          lon: Value(position.longitude),
          weatherCode: Value(reading.weatherCode),
          uvIndex: Value(reading.uvIndex),
          pm25: Value(airQuality.pm25),
          pm10: Value(airQuality.pm10),
          alderPollen: Value(airQuality.alderPollen),
          birchPollen: Value(airQuality.birchPollen),
          grassPollen: Value(airQuality.grassPollen),
          mugwortPollen: Value(airQuality.mugwortPollen),
          olivePollen: Value(airQuality.olivePollen),
          ragweedPollen: Value(airQuality.ragweedPollen),
        ),
      );
      return true;
    } on Exception {
      return false;
    }
  }

  @override
  Future<int> backfillMissingDays({int days = 7}) async {
    try {
      // Prefer the last stored coordinates; the backfill matters exactly
      // when the app hasn't run for a while, and a stale position from a
      // few days ago is still the right place to backfill for.
      final latest = await _environmentDao.getLatest();
      var lat = latest?.lat;
      var lon = latest?.lon;
      if (lat == null || lon == null) {
        final position = await _locationReader.readPosition();
        if (position == null) return 0;
        lat = position.latitude;
        lon = position.longitude;
      }

      final now = DateTime.now();
      final startOfToday = DateTime(now.year, now.month, now.day);
      final rangeStart = startOfToday.subtract(Duration(days: days));
      final existing = await _environmentDao.getRange(
        rangeStart.toUtc(),
        startOfToday.toUtc(),
      );
      final daysWithData = {
        for (final snapshot in existing) _dayOf(snapshot.timestamp.toLocal()),
      };
      final missingDays = {
        for (var i = 1; i <= days; i++)
          startOfToday.subtract(Duration(days: i)),
      }..removeAll(daysWithData);
      if (missingDays.isEmpty) return 0;

      final history = await _openMeteoClient.fetchHourlyHistory(
        latitude: lat,
        longitude: lon,
        pastDays: days,
      );

      final companions = <EnvironmentSnapshotsCompanion>[];
      final filledDays = <DateTime>{};
      for (var i = 0; i < history.times.length; i++) {
        final time = history.times[i];
        final day = _dayOf(time);
        if (!missingDays.contains(day)) continue;

        final pressure = history.pressure[i];
        final previousPressure = i > 0 ? history.pressure[i - 1] : null;
        filledDays.add(day);
        companions.add(
          EnvironmentSnapshotsCompanion.insert(
            id: _uuid.v4(),
            timestamp: time.toUtc(),
            pressure: Value(pressure),
            pressureDelta: Value(
              (pressure != null && previousPressure != null)
                  ? pressure - previousPressure
                  : null,
            ),
            temperature: Value(history.temperature[i]),
            humidity: Value(history.humidity[i]),
            lat: Value(lat),
            lon: Value(lon),
            weatherCode: Value(history.weatherCode[i]),
            uvIndex: Value(history.uvIndex[i]),
          ),
        );
      }
      if (companions.isEmpty) return 0;

      await _environmentDao.insertSnapshots(companions);
      return filledDays.length;
    } on Exception {
      return 0;
    }
  }

  @override
  Future<List<HourlyMeasure>> pressureForecastSeries({
    required double latitude,
    required double longitude,
  }) =>
      _openMeteoClient.fetchPressureForecastSeries(
        latitude: latitude,
        longitude: longitude,
      );

  static DateTime _dayOf(DateTime time) =>
      DateTime(time.year, time.month, time.day);
}
