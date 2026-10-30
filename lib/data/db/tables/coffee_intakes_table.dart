import 'package:drift/drift.dart';

@DataClassName('CoffeeIntake')
@TableIndex(name: 'idx_coffee_timestamp', columns: {#timestamp})
class CoffeeIntakes extends Table {
  TextColumn get id => text()();
  DateTimeColumn get timestamp => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
