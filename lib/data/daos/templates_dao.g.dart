// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'templates_dao.dart';

// ignore_for_file: type=lint
mixin _$TemplatesDaoMixin on DatabaseAccessor<AppDatabase> {
  $MealTemplatesTable get mealTemplates => attachedDatabase.mealTemplates;
  $TemplateTagsTable get templateTags => attachedDatabase.templateTags;
  $TagsTable get tags => attachedDatabase.tags;
  TemplatesDaoManager get managers => TemplatesDaoManager(this);
}

class TemplatesDaoManager {
  final _$TemplatesDaoMixin _db;
  TemplatesDaoManager(this._db);
  $$MealTemplatesTableTableManager get mealTemplates =>
      $$MealTemplatesTableTableManager(_db.attachedDatabase, _db.mealTemplates);
  $$TemplateTagsTableTableManager get templateTags =>
      $$TemplateTagsTableTableManager(_db.attachedDatabase, _db.templateTags);
  $$TagsTableTableManager get tags =>
      $$TagsTableTableManager(_db.attachedDatabase, _db.tags);
}
