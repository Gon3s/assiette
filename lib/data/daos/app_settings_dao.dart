import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/app_settings_table.dart';
import 'package:drift/drift.dart';

part 'app_settings_dao.g.dart';

@DriftAccessor(tables: [AppSettings])
class AppSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$AppSettingsDaoMixin {
  AppSettingsDao(super.attachedDatabase);

  static const _rowId = 0;

  Stream<bool> watchOnboardingDone() =>
      (select(appSettings)..where((t) => t.id.equals(_rowId)))
          .watchSingleOrNull()
          .map((row) => row?.onboardingDone ?? false);

  Future<void> setOnboardingDone({required bool done}) => into(appSettings)
      .insertOnConflictUpdate(
        AppSettingsCompanion.insert(
          id: const Value(_rowId),
          onboardingDone: Value(done),
        ),
      );

  /// Date (UTC, midnight) of the last pressure-drop alert sent, or `null`
  /// if none has been sent yet. Used to cap alerts to one per day.
  Future<DateTime?> getLastPressureAlertDate() async {
    final row = await (select(
      appSettings,
    )..where((t) => t.id.equals(_rowId))).getSingleOrNull();
    return row?.lastPressureAlertDate;
  }

  Future<void> setLastPressureAlertDate(DateTime date) => into(appSettings)
      .insertOnConflictUpdate(
        AppSettingsCompanion.insert(
          id: const Value(_rowId),
          lastPressureAlertDate: Value(date),
        ),
      );

  /// Whether proactive weather alerts (US-15) are enabled, per the US-16
  /// notification settings. Defaults to `true` when no row exists yet.
  Future<bool> getRemindersWeatherEnabled() async {
    final row = await (select(
      appSettings,
    )..where((t) => t.id.equals(_rowId))).getSingleOrNull();
    return row?.remindersWeatherEnabled ?? true;
  }

  /// Notification preferences row, or `null` if nothing has been saved yet
  /// (callers should fall back to defaults in that case).
  Stream<AppSetting?> watchNotificationSettingsRow() =>
      (select(appSettings)..where((t) => t.id.equals(_rowId)))
          .watchSingleOrNull();

  /// Persists the full set of notification preferences (US-16).
  Future<void> saveNotificationPreferences({
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
  }) => into(appSettings).insertOnConflictUpdate(
    AppSettingsCompanion.insert(
      id: const Value(_rowId),
      remindersMealsEnabled: Value(mealsEnabled),
      breakfastHour: Value(breakfastHour),
      breakfastMinute: Value(breakfastMinute),
      lunchHour: Value(lunchHour),
      lunchMinute: Value(lunchMinute),
      dinnerHour: Value(dinnerHour),
      dinnerMinute: Value(dinnerMinute),
      remindersSleepEnabled: Value(sleepEnabled),
      sleepHour: Value(sleepHour),
      sleepMinute: Value(sleepMinute),
      remindersWeatherEnabled: Value(weatherEnabled),
      remindersSymptomsEnabled: Value(symptomsEnabled),
      symptomsHour: Value(symptomsHour),
      symptomsMinute: Value(symptomsMinute),
    ),
  );

  /// Whether photo-based tag suggestions (US-19) are enabled. Defaults to
  /// `true` when no row exists yet.
  Stream<bool> watchPhotoTagSuggestionsEnabled() =>
      (select(appSettings)..where((t) => t.id.equals(_rowId)))
          .watchSingleOrNull()
          .map((row) => row?.photoTagSuggestionsEnabled ?? true);

  /// One-off read of [watchPhotoTagSuggestionsEnabled], for call sites that
  /// don't need to react to later changes (e.g. right after taking a photo).
  Future<bool> getPhotoTagSuggestionsEnabled() async {
    final row = await (select(
      appSettings,
    )..where((t) => t.id.equals(_rowId))).getSingleOrNull();
    return row?.photoTagSuggestionsEnabled ?? true;
  }

  /// Persists the photo tag suggestions toggle (US-19).
  Future<void> setPhotoTagSuggestionsEnabled({required bool enabled}) =>
      into(appSettings).insertOnConflictUpdate(
        AppSettingsCompanion.insert(
          id: const Value(_rowId),
          photoTagSuggestionsEnabled: Value(enabled),
        ),
      );
}
