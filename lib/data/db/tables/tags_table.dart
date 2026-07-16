import 'package:drift/drift.dart';

@DataClassName('Tag')
class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get label => text()();
  TextColumn get category => text().nullable()();
  BoolColumn get isSystem =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
