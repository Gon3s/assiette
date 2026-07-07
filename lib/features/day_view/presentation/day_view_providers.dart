import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/domain/timeline_item.dart';
import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'day_view_providers.g.dart';

/// The merged, time-sorted timeline (meals + symptoms) for the selected day.
@riverpod
Stream<List<TimelineItem>> dayTimeline(Ref ref) {
  final date = ref.watch(selectedDateProvider);
  return ref.watch(dayViewRepositoryProvider).watchTimeline(date);
}

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
