import 'package:drift/drift.dart';

@DataClassName('AppSetting')
class AppSettings extends Table {
  IntColumn get id => integer()();
  BoolColumn get onboardingDone =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastPressureAlertDate => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
