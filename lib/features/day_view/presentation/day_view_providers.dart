import 'package:assiette/features/day_view/domain/active_migraine.dart';
import 'package:assiette/features/day_view/domain/daily_feeling.dart';
import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/domain/timeline_item.dart';
import 'package:assiette/features/day_view/domain/weather_point.dart';
import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/features/environment_capture/data/locality_resolver.dart';
import 'package:assiette/features/environment_capture/domain/environment_capture_repository.dart';
import 'package:assiette/features/environment_capture/domain/hourly_measure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'day_view_providers.g.dart';

/// The merged, time-sorted timeline (meals + symptoms) for the selected day.
@riverpod
Stream<List<TimelineItem>> dayTimeline(Ref ref) {
  final date = ref.watch(selectedDateProvider);
  return ref.watch(dayViewRepositoryProvider).watchTimeline(date);
}

/// Non-timed physical feelings and mood for the selected day.
@riverpod
Stream<List<DailyFeeling>> dayFeelings(Ref ref) {
  final date = ref.watch(selectedDateProvider);
  return ref.watch(dayViewRepositoryProvider).watchDailyFeelings(date);
}

/// The currently unfinished migraine, independently of the selected day.
@riverpod
Stream<ActiveMigraine?> activeMigraine(Ref ref) =>
    ref.watch(dayViewRepositoryProvider).watchActiveMigraine();

/// The sleep entry for the selected day's night, if logged.
@riverpod
Stream<SleepSummary?> daySleep(Ref ref) {
  final date = ref.watch(selectedDateProvider);
  return ref.watch(dayViewRepositoryProvider).watchSleepForNight(date);
}

/// The latest weather/pressure snapshot captured on the selected day.
@riverpod
Stream<WeatherSummary?> dayWeather(Ref ref) {
  final date = ref.watch(selectedDateProvider);
  return ref.watch(dayViewRepositoryProvider).watchLatestWeather(date);
}

/// The full measured weather series for the selected day (charts).
@riverpod
Stream<List<WeatherPoint>> dayWeatherSeries(Ref ref) {
  final date = ref.watch(selectedDateProvider);
  return ref.watch(dayViewRepositoryProvider).watchWeatherSeries(date);
}

/// Resolves place names from coordinates; kept alive so its per-location
/// memoization survives day changes.
@Riverpod(keepAlive: true)
LocalityResolver localityResolver(Ref ref) => GeocodingLocalityResolver();

/// The place name (city) of the selected day's latest snapshot, or `null`
/// when unknown.
@riverpod
Future<String?> dayLocality(Ref ref) async {
  final weather = await ref.watch(dayWeatherProvider.future);
  final lat = weather?.lat;
  final lon = weather?.lon;
  if (lat == null || lon == null) return null;
  return ref
      .watch(localityResolverProvider)
      .resolveLocality(latitude: lat, longitude: lon);
}

/// Hourly pressure forecast (today + tomorrow) at the selected day's
/// snapshot location; empty when no coordinates are known.
@riverpod
Future<List<HourlyMeasure>> dayPressureForecast(Ref ref) async {
  final weather = await ref.watch(dayWeatherProvider.future);
  final lat = weather?.lat;
  final lon = weather?.lon;
  if (lat == null || lon == null) return const [];
  return ref
      .watch(environmentCaptureRepositoryProvider)
      .pressureForecastSeries(latitude: lat, longitude: lon);
}
