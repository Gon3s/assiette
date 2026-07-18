import 'package:assiette/data/daos/app_settings_dao.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/notifications/domain/notification_preferences.dart';
import 'package:assiette/features/notifications/domain/notification_preferences_repository.dart';

/// Drift-backed implementation of [NotificationPreferencesRepository].
class DriftNotificationPreferencesRepository
    implements NotificationPreferencesRepository {
  /// Creates a [DriftNotificationPreferencesRepository] backed by [appSettingsDao].
  DriftNotificationPreferencesRepository({required AppSettingsDao appSettingsDao})
    : _appSettingsDao = appSettingsDao;

  final AppSettingsDao _appSettingsDao;

  @override
  Stream<NotificationPreferences> watchPreferences() =>
      _appSettingsDao.watchNotificationSettingsRow().map(_toPreferences);

  @override
  Future<void> savePreferences(NotificationPreferences preferences) =>
      _appSettingsDao.saveNotificationPreferences(
        mealsEnabled: preferences.mealsEnabled,
        breakfastHour: preferences.breakfastHour,
        breakfastMinute: preferences.breakfastMinute,
        lunchHour: preferences.lunchHour,
        lunchMinute: preferences.lunchMinute,
        dinnerHour: preferences.dinnerHour,
        dinnerMinute: preferences.dinnerMinute,
        sleepEnabled: preferences.sleepEnabled,
        sleepHour: preferences.sleepHour,
        sleepMinute: preferences.sleepMinute,
        weatherEnabled: preferences.weatherEnabled,
        symptomsEnabled: preferences.symptomsEnabled,
        symptomsHour: preferences.symptomsHour,
        symptomsMinute: preferences.symptomsMinute,
      );

  NotificationPreferences _toPreferences(AppSetting? row) {
    if (row == null) return NotificationPreferences.defaults();
    return NotificationPreferences(
      mealsEnabled: row.remindersMealsEnabled,
      breakfastHour: row.breakfastHour,
      breakfastMinute: row.breakfastMinute,
      lunchHour: row.lunchHour,
      lunchMinute: row.lunchMinute,
      dinnerHour: row.dinnerHour,
      dinnerMinute: row.dinnerMinute,
      sleepEnabled: row.remindersSleepEnabled,
      sleepHour: row.sleepHour,
      sleepMinute: row.sleepMinute,
      weatherEnabled: row.remindersWeatherEnabled,
      symptomsEnabled: row.remindersSymptomsEnabled,
      symptomsHour: row.symptomsHour,
      symptomsMinute: row.symptomsMinute,
    );
  }
}
