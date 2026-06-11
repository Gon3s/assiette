// Drift DAO files expose infrastructure types, not a user-facing API.
// ignore_for_file: public_member_api_docs
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/meal_tags_table.dart';
import 'package:assiette/data/db/tables/meals_table.dart';
import 'package:assiette/data/db/tables/tags_table.dart';
import 'package:drift/drift.dart';

part 'meals_dao.g.dart';

class MealWithTags {
  const MealWithTags({required this.meal, required this.tags});
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
    final q = select(meals).join([
      leftOuterJoin(mealTags, mealTags.mealId.equalsExp(meals.id)),
      leftOuterJoin(
        tags,
        tags.id.equalsExp(mealTags.tagId) & tags.deletedAt.isNull(),
      ),
    ]);
    q
      ..where(meals.deletedAt.isNull())
      ..where(
        meals.timestamp.isBiggerOrEqualValue(start) &
            meals.timestamp.isSmallerThanValue(end),
      )
      ..orderBy([OrderingTerm.asc(meals.timestamp)]);
    return q.watch().map(_groupRows);
  }

  List<MealWithTags> _groupRows(List<TypedResult> rows) {
    final order = <String>[];
    final mealsById = <String, Meal>{};
    final tagsById = <String, List<Tag>>{};

    for (final row in rows) {
      final meal = row.readTable(meals);
      final tag = row.readTableOrNull(tags);

      if (!mealsById.containsKey(meal.id)) {
        order.add(meal.id);
        mealsById[meal.id] = meal;
      }
      if (tag != null) {
        tagsById.putIfAbsent(meal.id, () => []).add(tag);
      }
    }

    return [
      for (final id in order)
        MealWithTags(meal: mealsById[id]!, tags: tagsById[id] ?? []),
    ];
  }

  Future<void> insertMeal(MealsCompanion entry) => into(meals).insert(entry);

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
