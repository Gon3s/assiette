import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences.freezed.dart';

/// Per-channel notification settings (US-16): enable/disable and the time
/// of day each reminder fires. The weather channel has no time of its own
/// since it's event-driven (fires on a predicted pressure drop, US-15).
@freezed
abstract class NotificationPreferences with _$NotificationPreferences {
  const factory NotificationPreferences({
    required bool mealsEnabled,
    required int breakfastHour,
    required int breakfastMinute,
    required int lunchHour,
    required int lunchMinute,
    required int dinnerHour,
    required int dinnerMinute,
    required bool sleepEnabled,
    required int sleepHour,
    required int sleepMinute,
    required bool weatherEnabled,
    required bool symptomsEnabled,
    required int symptomsHour,
    required int symptomsMinute,
  }) = _NotificationPreferences;

  /// Defaults matching the hardcoded schedule this feature replaces:
  /// meals at 8:30/12:30/19:30, sleep at 8:00, weather on, symptoms off.
  factory NotificationPreferences.defaults() => const NotificationPreferences(
    mealsEnabled: true,
    breakfastHour: 8,
    breakfastMinute: 30,
    lunchHour: 12,
    lunchMinute: 30,
    dinnerHour: 19,
    dinnerMinute: 30,
    sleepEnabled: true,
    sleepHour: 8,
    sleepMinute: 0,
    weatherEnabled: true,
    symptomsEnabled: false,
    symptomsHour: 20,
    symptomsMinute: 0,
  );
}
