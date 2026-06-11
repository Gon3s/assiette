// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals_dao.dart';

// ignore_for_file: type=lint
mixin _$MealsDaoMixin on DatabaseAccessor<AppDatabase> {
  $MealsTable get meals => attachedDatabase.meals;
  $MealTagsTable get mealTags => attachedDatabase.mealTags;
  MealsDaoManager get managers => MealsDaoManager(this);
}

class MealsDaoManager {
  final _$MealsDaoMixin _db;
  MealsDaoManager(this._db);
  $$MealsTableTableManager get meals =>
      $$MealsTableTableManager(_db.attachedDatabase, _db.meals);
  $$MealTagsTableTableManager get mealTags =>
      $$MealTagsTableTableManager(_db.attachedDatabase, _db.mealTags);
}
