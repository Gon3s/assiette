// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_dao.dart';

// ignore_for_file: type=lint
mixin _$TagsDaoMixin on DatabaseAccessor<AppDatabase> {
  $TagsTable get tags => attachedDatabase.tags;
  $MealsTable get meals => attachedDatabase.meals;
  $MealTagsTable get mealTags => attachedDatabase.mealTags;
  $MealTemplatesTable get mealTemplates => attachedDatabase.mealTemplates;
  $TemplateTagsTable get templateTags => attachedDatabase.templateTags;
  TagsDaoManager get managers => TagsDaoManager(this);
}

class TagsDaoManager {
  final _$TagsDaoMixin _db;
  TagsDaoManager(this._db);
  $$TagsTableTableManager get tags =>
      $$TagsTableTableManager(_db.attachedDatabase, _db.tags);
  $$MealsTableTableManager get meals =>
      $$MealsTableTableManager(_db.attachedDatabase, _db.meals);
  $$MealTagsTableTableManager get mealTags =>
      $$MealTagsTableTableManager(_db.attachedDatabase, _db.mealTags);
  $$MealTemplatesTableTableManager get mealTemplates =>
      $$MealTemplatesTableTableManager(_db.attachedDatabase, _db.mealTemplates);
  $$TemplateTagsTableTableManager get templateTags =>
      $$TemplateTagsTableTableManager(_db.attachedDatabase, _db.templateTags);
}
