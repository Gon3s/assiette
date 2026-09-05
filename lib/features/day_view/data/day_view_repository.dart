import 'dart:async';

import 'package:assiette/data/daos/environment_dao.dart';
import 'package:assiette/data/daos/meals_dao.dart';
import 'package:assiette/data/daos/medication_intakes_dao.dart';
import 'package:assiette/data/daos/migraine_intensity_measurements_dao.dart';
import 'package:assiette/data/daos/sleep_entries_dao.dart';
import 'package:assiette/data/daos/symptoms_dao.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/day_view/domain/active_migraine.dart';
import 'package:assiette/features/day_view/domain/daily_feeling.dart';
import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/domain/timeline_item.dart';
import 'package:assiette/features/day_view/domain/weather_point.dart';
import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Drift-backed implementation of [DayViewRepository].
class DriftDayViewRepository implements DayViewRepository {
  /// Creates a [DriftDayViewRepository] backed by the given DAOs.
  DriftDayViewRepository({
    required MealsDao mealsDao,
    required SymptomsDao symptomsDao,
    required MigraineIntensityMeasurementsDao migraineMeasurementsDao,
    required MedicationIntakesDao medicationIntakesDao,
    required SleepEntriesDao sleepEntriesDao,
    required EnvironmentDao environmentDao,
  }) : _mealsDao = mealsDao,
       _symptomsDao = symptomsDao,
       _migraineMeasurementsDao = migraineMeasurementsDao,
       _medicationIntakesDao = medicationIntakesDao,
       _sleepEntriesDao = sleepEntriesDao,
       _environmentDao = environmentDao;

  final MealsDao _mealsDao;
  final SymptomsDao _symptomsDao;
  final MigraineIntensityMeasurementsDao _migraineMeasurementsDao;
  final MedicationIntakesDao _medicationIntakesDao;
  final SleepEntriesDao _sleepEntriesDao;
  final EnvironmentDao _environmentDao;

  static const _uuid = Uuid();

  @override
  Stream<List<TimelineItem>> watchTimeline(DateTime day) {
    final meals = _mealsDao
        .watchByDayWithTags(day)
        .map((rows) => rows.map(_mealToTimelineItem).toList());
    final symptoms = _symptomsDao
        .watchTimelineByDay(day)
        .map((rows) => rows.map(_symptomToTimelineItem).toList());
    final medications = _medicationIntakesDao
        .watchByDay(day)
        .map((rows) => rows.map(_intakeToTimelineItem).toList());
    return _combineSorted([meals, symptoms, medications]);
  }

  @override
  Stream<List<DailyFeeling>> watchDailyFeelings(DateTime day) => _symptomsDao
      .watchDailyNotes(day)
      .map(
        (rows) => [
          for (final row in rows)
            DailyFeeling(
              id: row.id,
              type: row.type,
              text: row.note ?? row.detail ?? '',
              previousIntensity: row.isDailyNote ? null : row.intensity,
            ),
        ],
      );

  @override
  Stream<ActiveMigraine?> watchActiveMigraine() =>
      _symptomsDao.watchActiveMigraine().asyncMap((symptom) async {
        if (symptom == null) return null;
        final measurements = await _migraineMeasurementsDao
            .watchForMigraine(symptom.id)
            .first;
        return ActiveMigraine(
          id: symptom.id,
          startedAt: symptom.startedAt,
          lastIntensity: measurements.isEmpty
              ? symptom.initialIntensity ?? symptom.intensity ?? 1
              : measurements.last.intensity,
        );
      });

  @override
  Future<void> addMigraineIntensity(String migraineId, int intensity) async {
    if (intensity < 0 || intensity > 10) {
      throw ArgumentError.value(intensity, 'intensity', 'must be 0 to 10');
    }
    final now = DateTime.now().toUtc();
    await _migraineMeasurementsDao.insertMeasurement(
      MigraineIntensityMeasurementsCompanion.insert(
        id: _uuid.v4(),
        symptomId: migraineId,
        timestamp: now,
        intensity: intensity,
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
    final symptom = await _symptomsDao.getSymptomById(migraineId);
    final maximum = [
      symptom?.maximumIntensity,
      symptom?.initialIntensity,
      symptom?.intensity,
      intensity,
    ].whereType<int>().reduce((a, b) => a > b ? a : b);
    await _symptomsDao.updateSymptom(
      migraineId,
      SymptomsCompanion(
        maximumIntensity: Value(maximum),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<void> endMigraine(String migraineId, DateTime endedAt) async {
    final symptom = await _symptomsDao.getSymptomById(migraineId);
    final end = endedAt.toUtc();
    if (symptom?.startedAt case final start? when end.isBefore(start)) {
      throw ArgumentError.value(endedAt, 'endedAt', 'must follow start');
    }
    await _symptomsDao.updateSymptom(
      migraineId,
      SymptomsCompanion(
        endedAt: Value(end),
        endTime: Value(end),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  @override
  Stream<SleepSummary?> watchSleepForNight(DateTime day) {
    return _sleepEntriesDao
        .watchByDate(day)
        .map(
          (entry) => entry == null
              ? null
              : SleepSummary(
                  id: entry.id,
                  quality: entry.quality,
                  bedTime: entry.bedTime,
                  wakeTime: entry.wakeTime,
                ),
        );
  }

  @override
  Stream<WeatherSummary?> watchLatestWeather(DateTime day) {
    return _environmentDao
        .watchByDay(day)
        .map(
          (snapshots) =>
              snapshots.isEmpty ? null : _toWeatherSummary(snapshots.last),
        );
  }

  @override
  Stream<List<WeatherPoint>> watchWeatherSeries(DateTime day) {
    return _environmentDao
        .watchByDay(day)
        .map(
          (snapshots) => [
            for (final snapshot in snapshots)
              WeatherPoint(
                timestamp: snapshot.timestamp,
                temperature: snapshot.temperature,
                pressure: snapshot.pressure,
              ),
          ],
        );
  }

  @override
  Future<void> logSleepQuality(DateTime day, int quality) async {
    final nightDate = _nightDateKey(day);
    final existing = await _sleepEntriesDao.watchByDate(day).first;
    final now = DateTime.now().toUtc();
    await _sleepEntriesDao.upsertSleepEntry(
      SleepEntriesCompanion.insert(
        id: existing?.id ?? _uuid.v4(),
        nightDate: nightDate,
        quality: quality,
        createdAt: Value(existing?.createdAt ?? now),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<void> deleteSleepEntry(String id) =>
      _sleepEntriesDao.softDeleteSleepEntry(id);

  @override
  Future<void> undoDeleteSleepEntry(String id) =>
      _sleepEntriesDao.restoreSleepEntry(id);

  /// Mirrors the normalization done by [SleepEntriesDao.watchByDate] so the
  /// inserted row matches the same night when queried back.
  static DateTime _nightDateKey(DateTime date) =>
      DateTime(date.year, date.month, date.day).toUtc();

  static TimelineItem _mealToTimelineItem(MealWithTags row) =>
      TimelineItem.meal(
        id: row.meal.id,
        timestamp: row.meal.timestamp,
        mealType: row.meal.mealType,
        tagLabels: [for (final tag in row.tags) tag.label],
        photoPath: row.meal.photoPath,
      );

  static TimelineItem _symptomToTimelineItem(Symptom symptom) =>
      TimelineItem.symptom(
        id: symptom.id,
        timestamp: symptom.timestamp,
        symptomType: symptom.type,
        intensity: symptom.intensity ?? symptom.initialIntensity ?? 1,
        detail: symptom.detail,
      );

  static TimelineItem _intakeToTimelineItem(MedicationIntake intake) =>
      TimelineItem.medication(
        id: intake.id,
        timestamp: intake.timestamp,
        name: intake.name,
        dose: intake.dose,
      );

  static WeatherSummary _toWeatherSummary(EnvironmentSnapshot snapshot) =>
      WeatherSummary(
        timestamp: snapshot.timestamp,
        pressure: snapshot.pressure,
        pressureDelta: snapshot.pressureDelta,
        temperature: snapshot.temperature,
        humidity: snapshot.humidity,
        lat: snapshot.lat,
        lon: snapshot.lon,
        weatherCode: snapshot.weatherCode,
        uvIndex: snapshot.uvIndex,
        pm25: snapshot.pm25,
        pm10: snapshot.pm10,
        pollenMax: [
          snapshot.alderPollen,
          snapshot.birchPollen,
          snapshot.grassPollen,
          snapshot.mugwortPollen,
          snapshot.olivePollen,
          snapshot.ragweedPollen,
        ].nonNulls.maxOrNull,
      );

  /// Merges reactive lists into a single stream sorted by timestamp,
  /// re-emitting whenever any source emits (once all have emitted once).
  static Stream<List<TimelineItem>> _combineSorted(
    List<Stream<List<TimelineItem>>> sources,
  ) {
    final latest = List<List<TimelineItem>?>.filled(sources.length, null);
    final subs = <StreamSubscription<List<TimelineItem>>>[];
    late final StreamController<List<TimelineItem>> controller;

    void emit() {
      if (latest.any((value) => value == null)) return;
      final merged = [for (final value in latest) ...value!]
        ..sort((x, y) => x.timestamp.compareTo(y.timestamp));
      controller.add(merged);
    }

    controller = StreamController<List<TimelineItem>>.broadcast(
      onListen: () {
        for (var i = 0; i < sources.length; i++) {
          subs.add(
            sources[i].listen(
              (value) {
                latest[i] = value;
                emit();
              },
              onError: controller.addError,
            ),
          );
        }
      },
      onCancel: () async {
        for (final sub in subs) {
          await sub.cancel();
        }
        subs.clear();
      },
    );
    return controller.stream;
  }
}
