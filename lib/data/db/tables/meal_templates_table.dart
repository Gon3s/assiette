// Drift table definitions are infrastructure — no public API docs needed.
// ignore_for_file: public_member_api_docs
import 'package:drift/drift.dart';

@DataClassName('MealTemplate')
class MealTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get defaultPhotoPath => text().nullable()();
  TextColumn get defaultMealType => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
