// Drift DAO files expose infrastructure types, not a user-facing API.
// ignore_for_file: public_member_api_docs
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/meal_tags_table.dart';
import 'package:assiette/data/db/tables/meals_table.dart';
import 'package:drift/drift.dart';

part 'meals_dao.g.dart';

@DriftAccessor(tables: [Meals, MealTags])
class MealsDao extends DatabaseAccessor<AppDatabase> with _$MealsDaoMixin {
  MealsDao(super.attachedDatabase);

  Stream<List<Meal>> watchByDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day).toUtc();
    final end = start.add(const Duration(days: 1));
    return (select(meals)
          ..where((t) => t.deletedAt.isNull())
          ..where(
            (t) =>
                t.timestamp.isBiggerOrEqualValue(start) &
                t.timestamp.isSmallerThanValue(end),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .watch();
  }

  Future<void> insertMeal(MealsCompanion entry) =>
      into(meals).insert(entry);

  Future<void> softDeleteMeal(String id) =>
      (update(meals)..where((t) => t.id.equals(id))).write(
        MealsCompanion(deletedAt: Value(DateTime.now().toUtc())),
      );

  Future<void> addTag(MealTagsCompanion entry) =>
      into(mealTags).insert(entry, mode: InsertMode.insertOrIgnore);

  Future<void> removeTag(String mealId, String tagId) =>
      (delete(mealTags)
            ..where(
              (t) => t.mealId.equals(mealId) & t.tagId.equals(tagId),
            ))
          .go();
}
