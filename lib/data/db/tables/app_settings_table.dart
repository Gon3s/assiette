// Drift table definitions are infrastructure — no public API docs needed.
// ignore_for_file: public_member_api_docs
import 'package:drift/drift.dart';

@DataClassName('AppSetting')
class AppSettings extends Table {
  IntColumn get id => integer()();
  BoolColumn get onboardingDone =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
