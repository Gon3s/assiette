import 'package:drift/drift.dart';

@DataClassName('EnvironmentSnapshot')
@TableIndex(name: 'idx_env_timestamp', columns: {#timestamp})
class EnvironmentSnapshots extends Table {
  TextColumn get id => text()();
  DateTimeColumn get timestamp => dateTime()();
  RealColumn get pressure => real().nullable()();
  RealColumn get pressureDelta => real().nullable()();
  RealColumn get temperature => real().nullable()();
  RealColumn get humidity => real().nullable()();
  RealColumn get lat => real().nullable()();
  RealColumn get lon => real().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
