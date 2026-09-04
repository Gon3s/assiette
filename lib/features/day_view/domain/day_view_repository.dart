import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/day_view/data/day_view_repository.dart';
import 'package:assiette/features/day_view/domain/active_migraine.dart';
import 'package:assiette/features/day_view/domain/daily_feeling.dart';
import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/domain/timeline_item.dart';
import 'package:assiette/features/day_view/domain/weather_point.dart';
import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'day_view_repository.g.dart';

/// Read/write access to everything the day view screen needs.
abstract class DayViewRepository {
  /// Watches the merged, time-sorted meals and symptoms for [day].
  Stream<List<TimelineItem>> watchTimeline(DateTime day);

  /// Watches non-timed physical feelings and the day's mood.
  Stream<List<DailyFeeling>> watchDailyFeelings(DateTime day);

  /// Watches the single unfinished migraine, if any.
  Stream<ActiveMigraine?> watchActiveMigraine();

  /// Appends an intensity measurement without replacing history.
  Future<void> addMigraineIntensity(String migraineId, int intensity);

  /// Ends an active migraine without recording another intensity.
  Future<void> endMigraine(String migraineId, DateTime endedAt);

  /// Watches the sleep entry logged for the night of [day], if any.
  Stream<SleepSummary?> watchSleepForNight(DateTime day);

  /// Watches the most recent weather/pressure snapshot captured on [day].
  Stream<WeatherSummary?> watchLatestWeather(DateTime day);

  /// Watches the full measured weather series (all snapshots) for [day],
  /// feeding the temperature/pressure evolution charts.
  Stream<List<WeatherPoint>> watchWeatherSeries(DateTime day);

  /// Logs (or updates) the sleep quality for the night of [day].
  Future<void> logSleepQuality(DateTime day, int quality);

  /// Soft-deletes the sleep entry.
  Future<void> deleteSleepEntry(String id);

  /// Undoes [deleteSleepEntry].
  Future<void> undoDeleteSleepEntry(String id);
}

/// Provides the [DayViewRepository] implementation.
@riverpod
DayViewRepository dayViewRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftDayViewRepository(
    mealsDao: db.mealsDao,
    symptomsDao: db.symptomsDao,
    migraineMeasurementsDao: db.migraineIntensityMeasurementsDao,
    medicationIntakesDao: db.medicationIntakesDao,
    sleepEntriesDao: db.sleepEntriesDao,
    environmentDao: db.environmentDao,
  );
}
