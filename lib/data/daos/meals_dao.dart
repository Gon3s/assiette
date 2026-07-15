// Drift DAO files expose infrastructure types, not a user-facing API.
// ignore_for_file: public_member_api_docs
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/meal_tags_table.dart';
import 'package:assiette/data/db/tables/meals_table.dart';
import 'package:assiette/data/db/tables/tags_table.dart';
import 'package:drift/drift.dart';

part 'meals_dao.g.dart';

class MealWithTags {
  MealWithTags({required this.meal, required this.tags});
  final Meal meal;
  final List<Tag> tags;
}

@DriftAccessor(tables: [Meals, MealTags, Tags])
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

  Stream<List<MealWithTags>> watchByDayWithTags(DateTime day) {
    final start = DateTime(day.year, day.month, day.day).toUtc();
    final end = start.add(const Duration(days: 1));
    final query = select(meals).join([
      leftOuterJoin(mealTags, mealTags.mealId.equalsExp(meals.id)),
      leftOuterJoin(
        tags,
        tags.id.equalsExp(mealTags.tagId) & tags.deletedAt.isNull(),
      ),
    ])
      ..where(
        meals.deletedAt.isNull() &
            meals.timestamp.isBiggerOrEqualValue(start) &
            meals.timestamp.isSmallerThanValue(end),
      )
      ..orderBy([OrderingTerm.asc(meals.timestamp)]);

    return query.watch().map((rows) {
      final order = <String>[];
      final grouped = <String, MealWithTags>{};
      for (final row in rows) {
        final meal = row.readTable(meals);
        final tag = row.readTableOrNull(tags);
        final entry = grouped.putIfAbsent(meal.id, () {
          order.add(meal.id);
          return MealWithTags(meal: meal, tags: []);
        });
        if (tag != null) entry.tags.add(tag);
      }
      return [for (final id in order) grouped[id]!];
    });
  }

  Future<void> insertMeal(MealsCompanion entry) =>
      into(meals).insert(entry);

  /// Inserts the meal and its tag links atomically.
  Future<void> insertMealWithTags(
    MealsCompanion entry,
    List<String> tagIds,
  ) =>
      transaction(() async {
        await into(meals).insert(entry);
        final mealId = entry.id.value;
        for (final tagId in tagIds) {
          await into(mealTags).insert(
            MealTagsCompanion.insert(mealId: mealId, tagId: tagId),
            mode: InsertMode.insertOrIgnore,
          );
        }
      });

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
