import 'dart:async';

import 'package:assiette/data/daos/environment_dao.dart';
import 'package:assiette/data/daos/meals_dao.dart';
import 'package:assiette/data/daos/medication_intakes_dao.dart';
import 'package:assiette/data/daos/sleep_entries_dao.dart';
import 'package:assiette/data/daos/symptoms_dao.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/domain/timeline_item.dart';
import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Drift-backed implementation of [DayViewRepository].
class DriftDayViewRepository implements DayViewRepository {
  /// Creates a [DriftDayViewRepository] backed by the given DAOs.
  DriftDayViewRepository({
    required MealsDao mealsDao,
    required SymptomsDao symptomsDao,
    required MedicationIntakesDao medicationIntakesDao,
    required SleepEntriesDao sleepEntriesDao,
    required EnvironmentDao environmentDao,
  })  : _mealsDao = mealsDao,
        _symptomsDao = symptomsDao,
        _medicationIntakesDao = medicationIntakesDao,
        _sleepEntriesDao = sleepEntriesDao,
        _environmentDao = environmentDao;

  final MealsDao _mealsDao;
  final SymptomsDao _symptomsDao;
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
        .watchByDay(day)
        .map((rows) => rows.map(_symptomToTimelineItem).toList());
    final medications = _medicationIntakesDao
        .watchByDay(day)
        .map((rows) => rows.map(_intakeToTimelineItem).toList());
    return _combineSorted([meals, symptoms, medications]);
  }

  @override
  Stream<SleepSummary?> watchSleepForNight(DateTime day) {
    return _sleepEntriesDao.watchByDate(day).map(
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
    return _environmentDao.watchByDay(day).map(
          (snapshots) =>
              snapshots.isEmpty ? null : _toWeatherSummary(snapshots.last),
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
        intensity: symptom.intensity,
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
