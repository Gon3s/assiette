import 'package:drift/drift.dart';

@DataClassName('MenstrualDay')
class MenstrualDays extends Table {
  TextColumn get localDate => text()();
  TextColumn get bleedingStatus => text()();
  TextColumn get flow => text().nullable()();
  BoolColumn get isPeriodStart =>
      boolean().withDefault(const Constant(false))();
  TextColumn get note => text().withLength(max: 2000).nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {localDate};

  @override
  List<String> get customConstraints => const [
    "CHECK (bleeding_status IN ('none', 'spotting', 'period'))",
    "CHECK (flow IS NULL OR (bleeding_status = 'period' AND flow IN ('light', 'medium', 'heavy')))",
    "CHECK (is_period_start = 0 OR bleeding_status = 'period')",
  ];
}
