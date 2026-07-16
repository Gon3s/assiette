import 'package:drift/drift.dart';

@DataClassName('MealTag')
class MealTags extends Table {
  TextColumn get mealId => text()();
  TextColumn get tagId => text()();

  @override
  Set<Column<Object>> get primaryKey => {mealId, tagId};
}
