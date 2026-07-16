import 'package:drift/drift.dart';

@DataClassName('SleepEntry')
class SleepEntries extends Table {
  TextColumn get id => text()();
  DateTimeColumn get nightDate => dateTime()();
  IntColumn get quality => integer()();
  DateTimeColumn get bedTime => dateTime().nullable()();
  DateTimeColumn get wakeTime => dateTime().nullable()();
  TextColumn get source =>
      text().withDefault(const Constant('manual'))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {nightDate},
      ];
}
