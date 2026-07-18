import 'package:assiette/features/notifications/data/notifications_service.dart';
import 'package:assiette/features/notifications/domain/notification_preferences.dart';
import 'package:assiette/features/notifications/domain/notification_preferences_repository.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_settings_controller.g.dart';

/// Draft state and persistence for the notification settings screen
/// (US-16): edits are local until [save] persists them and reschedules the
/// corresponding notifications.
@riverpod
class NotificationSettingsController extends _$NotificationSettingsController {
  @override
  Future<NotificationPreferences> build() => ref
      .watch(notificationPreferencesRepositoryProvider)
      .watchPreferences()
      .first;

  /// Toggles the meal reminders channel.
  void setMealsEnabled({required bool enabled}) =>
      _update((p) => p.copyWith(mealsEnabled: enabled));

  /// Sets the breakfast reminder time.
  void setBreakfastTime({required int hour, required int minute}) => _update(
    (p) => p.copyWith(breakfastHour: hour, breakfastMinute: minute),
  );

  /// Sets the lunch reminder time.
  void setLunchTime({required int hour, required int minute}) =>
      _update((p) => p.copyWith(lunchHour: hour, lunchMinute: minute));

  /// Sets the dinner reminder time.
  void setDinnerTime({required int hour, required int minute}) =>
      _update((p) => p.copyWith(dinnerHour: hour, dinnerMinute: minute));

  /// Toggles the sleep check-in channel.
  void setSleepEnabled({required bool enabled}) =>
      _update((p) => p.copyWith(sleepEnabled: enabled));

  /// Sets the sleep check-in reminder time.
  void setSleepTime({required int hour, required int minute}) =>
      _update((p) => p.copyWith(sleepHour: hour, sleepMinute: minute));

  /// Toggles proactive weather/pressure alerts (US-15). Event-driven, so
  /// there's no time of day to configure.
  void setWeatherEnabled({required bool enabled}) =>
      _update((p) => p.copyWith(weatherEnabled: enabled));

  /// Toggles the symptom check-in channel. Off by default.
  void setSymptomsEnabled({required bool enabled}) =>
      _update((p) => p.copyWith(symptomsEnabled: enabled));

  /// Sets the symptom check-in reminder time.
  void setSymptomsTime({required int hour, required int minute}) => _update(
    (p) => p.copyWith(symptomsHour: hour, symptomsMinute: minute),
  );

  void _update(
    NotificationPreferences Function(NotificationPreferences) update,
  ) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(update(current));
  }

  /// Persists the current draft and reschedules (or cancels) notifications
  /// to match. Returns `true` on success.
  Future<bool> save(AppStrings strings) async {
    final current = state.value;
    if (current == null) return false;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(notificationPreferencesRepositoryProvider)
          .savePreferences(current);
      await ref
          .read(notificationsServiceProvider)
          .scheduleDailyReminders(strings, current);
      return current;
    });
    return !state.hasError;
  }
}
