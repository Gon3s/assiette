import 'package:assiette/data/daos/environment_dao.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/data/open_meteo_client.dart';
import 'package:assiette/features/environment_capture/domain/air_quality_reading.dart';
import 'package:assiette/features/environment_capture/domain/device_location.dart';
import 'package:assiette/features/environment_capture/domain/environment_capture_policy.dart';
import 'package:assiette/features/environment_capture/domain/environment_capture_repository.dart';
import 'package:assiette/features/environment_capture/domain/hourly_measure.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Drift-backed implementation of [EnvironmentCaptureRepository].
class DriftEnvironmentCaptureRepository
    implements EnvironmentCaptureRepository {
  /// Creates a [DriftEnvironmentCaptureRepository] backed by the given
  /// collaborators.
  DriftEnvironmentCaptureRepository({
    required EnvironmentDao environmentDao,
    required LocationReader locationReader,
    required OpenMeteoClient openMeteoClient,
    DateTime Function()? now,
  }) : _environmentDao = environmentDao,
       _locationReader = locationReader,
       _openMeteoClient = openMeteoClient,
       _now = now ?? DateTime.now;

  final EnvironmentDao _environmentDao;
  final LocationReader _locationReader;
  final OpenMeteoClient _openMeteoClient;
  final DateTime Function() _now;

  static const _uuid = Uuid();

  @override
  Future<bool> captureSnapshot({DeviceLocation? location}) async {
    try {
      final resolvedLocation = location ?? await _locationReader.readPosition();
      if (resolvedLocation == null) return false;

      final now = _now().toUtc();
      final previous = await _environmentDao.getLatest();
      final previousLocation = _locationOf(previous);
      final sameZone =
          previousLocation != null &&
          isSameEnvironmentWeatherZone(previousLocation, resolvedLocation);
      if (sameZone &&
          previous != null &&
          !now.isBefore(previous.timestamp) &&
          now.difference(previous.timestamp) < environmentCaptureInterval) {
        return false;
      }

      final reading = await _openMeteoClient.fetchCurrent(
        latitude: resolvedLocation.latitude,
        longitude: resolvedLocation.longitude,
      );

      // Air quality comes from a separate Open-Meteo host; its failure must
      // not lose the weather snapshot.
      var airQuality = const AirQualityReading();
      try {
        airQuality = await _openMeteoClient.fetchCurrentAirQuality(
          latitude: resolvedLocation.latitude,
          longitude: resolvedLocation.longitude,
        );
      } on Exception {
        // Keep the nulls: the snapshot is still worth storing.
      }

      final pressure = reading.pressure ?? reading.surfacePressure;
      final pressureDelta =
          (sameZone && pressure != null && previous?.pressure != null)
          ? pressure - previous!.pressure!
          : null;

      await _environmentDao.insertSnapshot(
        EnvironmentSnapshotsCompanion.insert(
          id: _uuid.v4(),
          timestamp: now,
          pressure: Value(pressure),
          pressureDelta: Value(pressureDelta),
          temperature: Value(reading.temperature),
          humidity: Value(reading.humidity),
          lat: Value(resolvedLocation.latitude),
          lon: Value(resolvedLocation.longitude),
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
      final now = _now();
      final startOfToday = DateTime(now.year, now.month, now.day);
      final rangeStart = startOfToday.subtract(Duration(days: days));
      final snapshots = await _environmentDao.getRange(
        rangeStart.subtract(environmentBackfillAnchorMaxGap).toUtc(),
        now.toUtc(),
      );
      final daysWithData = {
        for (final snapshot in snapshots)
          if (!snapshot.timestamp.isBefore(rangeStart.toUtc()) &&
              snapshot.timestamp.isBefore(startOfToday.toUtc()))
            _dayOf(snapshot.timestamp.toLocal()),
      };
      final missingDays = {
        for (var i = 1; i <= days; i++)
          startOfToday.subtract(Duration(days: i)),
      }..removeAll(daysWithData);
      if (missingDays.isEmpty) return 0;

      final eligibleDays = <DateTime, DeviceLocation>{};
      for (final day in missingDays) {
        final start = day.toUtc();
        final end = day.add(const Duration(days: 1)).toUtc();
        final before = _lastBefore(snapshots, start);
        final after = _firstAtOrAfter(snapshots, end);
        final beforeLocation = _locationOf(before);
        final afterLocation = _locationOf(after);
        if (before == null ||
            after == null ||
            beforeLocation == null ||
            afterLocation == null ||
            start.difference(before.timestamp) >
                environmentBackfillAnchorMaxGap ||
            after.timestamp.difference(end) > environmentBackfillAnchorMaxGap ||
            !isSameEnvironmentWeatherZone(beforeLocation, afterLocation)) {
          continue;
        }
        eligibleDays[day] = beforeLocation;
      }
      if (eligibleDays.isEmpty) return 0;

      final companions = <EnvironmentSnapshotsCompanion>[];
      final filledDays = <DateTime>{};
      final groups = _groupBackfillDays(eligibleDays);
      for (final group in groups) {
        final history = await _openMeteoClient.fetchHourlyHistory(
          latitude: group.location.latitude,
          longitude: group.location.longitude,
          pastDays: days,
        );
        for (var i = 0; i < history.times.length; i++) {
          final time = history.times[i];
          final day = _dayOf(time);
          if (!group.days.contains(day)) continue;

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
              lat: Value(group.location.latitude),
              lon: Value(group.location.longitude),
              weatherCode: Value(history.weatherCode[i]),
              uvIndex: Value(history.uvIndex[i]),
            ),
          );
        }
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
  }) => _openMeteoClient.fetchPressureForecastSeries(
    latitude: latitude,
    longitude: longitude,
  );

  static DateTime _dayOf(DateTime time) =>
      DateTime(time.year, time.month, time.day);

  static DeviceLocation? _locationOf(EnvironmentSnapshot? snapshot) {
    final lat = snapshot?.lat;
    final lon = snapshot?.lon;
    if (snapshot == null || lat == null || lon == null) return null;
    return DeviceLocation(
      latitude: lat,
      longitude: lon,
      timestamp: snapshot.timestamp,
    );
  }

  static EnvironmentSnapshot? _lastBefore(
    List<EnvironmentSnapshot> snapshots,
    DateTime time,
  ) {
    for (final snapshot in snapshots.reversed) {
      if (snapshot.timestamp.isBefore(time)) return snapshot;
    }
    return null;
  }

  static EnvironmentSnapshot? _firstAtOrAfter(
    List<EnvironmentSnapshot> snapshots,
    DateTime time,
  ) {
    for (final snapshot in snapshots) {
      if (!snapshot.timestamp.isBefore(time)) return snapshot;
    }
    return null;
  }

  static List<_BackfillGroup> _groupBackfillDays(
    Map<DateTime, DeviceLocation> eligibleDays,
  ) {
    final groups = <_BackfillGroup>[];
    for (final entry in eligibleDays.entries) {
      _BackfillGroup? matching;
      for (final group in groups) {
        if (isSameEnvironmentWeatherZone(group.location, entry.value)) {
          matching = group;
          break;
        }
      }
      if (matching == null) {
        groups.add(_BackfillGroup(location: entry.value, days: {entry.key}));
      } else {
        matching.days.add(entry.key);
      }
    }
    return groups;
  }
}

class _BackfillGroup {
  _BackfillGroup({required this.location, required this.days});

  final DeviceLocation location;
  final Set<DateTime> days;
}
