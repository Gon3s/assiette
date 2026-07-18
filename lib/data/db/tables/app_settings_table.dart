import 'package:drift/drift.dart';

@DataClassName('AppSetting')
class AppSettings extends Table {
  IntColumn get id => integer()();
  BoolColumn get onboardingDone =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastPressureAlertDate => dateTime().nullable()();

  // Notification preferences (US-16). One row (id 0), flat columns to match
  // this table's existing settings-singleton shape.
  BoolColumn get remindersMealsEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get breakfastHour => integer().withDefault(const Constant(8))();
  IntColumn get breakfastMinute =>
      integer().withDefault(const Constant(30))();
  IntColumn get lunchHour => integer().withDefault(const Constant(12))();
  IntColumn get lunchMinute => integer().withDefault(const Constant(30))();
  IntColumn get dinnerHour => integer().withDefault(const Constant(19))();
  IntColumn get dinnerMinute => integer().withDefault(const Constant(30))();

  BoolColumn get remindersSleepEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get sleepHour => integer().withDefault(const Constant(8))();
  IntColumn get sleepMinute => integer().withDefault(const Constant(0))();

  BoolColumn get remindersWeatherEnabled =>
      boolean().withDefault(const Constant(true))();

  /// Off by default: symptom check-in is more intrusive than the other
  /// reminders, so it's opt-in (US-16 acceptance criteria).
  BoolColumn get remindersSymptomsEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get symptomsHour => integer().withDefault(const Constant(20))();
  IntColumn get symptomsMinute => integer().withDefault(const Constant(0))();

  /// Whether photo-based tag suggestions (US-19, on-device) are enabled.
  BoolColumn get photoTagSuggestionsEnabled =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
