import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:drift/drift.dart';

@DataClassName('Meal')
@TableIndex(name: 'idx_meals_timestamp', columns: {#timestamp})
class Meals extends Table {
  TextColumn get id => text()();
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get mealType => intEnum<MealType>()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get templateId => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
