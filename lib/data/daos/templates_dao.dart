// Drift DAO files expose infrastructure types, not a user-facing API.
// ignore_for_file: public_member_api_docs
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/meal_templates_table.dart';
import 'package:assiette/data/db/tables/tags_table.dart';
import 'package:assiette/data/db/tables/template_tags_table.dart';
import 'package:drift/drift.dart';

part 'templates_dao.g.dart';

/// A meal template joined with the (non-deleted) tags attached to it.
class MealTemplateWithTags {
  /// Creates a [MealTemplateWithTags].
  MealTemplateWithTags({required this.template, required this.tags});

  /// The template itself.
  final MealTemplate template;

  /// The tags attached to this template.
  final List<Tag> tags;
}

@DriftAccessor(tables: [MealTemplates, TemplateTags, Tags])
class TemplatesDao extends DatabaseAccessor<AppDatabase>
    with _$TemplatesDaoMixin {
  TemplatesDao(super.attachedDatabase);

  /// Watches all non-deleted templates, sorted by name, with their tags
  /// eagerly loaded.
  Stream<List<MealTemplateWithTags>> watchAllWithTags() {
    final query =
        select(mealTemplates).join([
            leftOuterJoin(
              templateTags,
              templateTags.templateId.equalsExp(mealTemplates.id),
            ),
            leftOuterJoin(
              tags,
              tags.id.equalsExp(templateTags.tagId) & tags.deletedAt.isNull(),
            ),
          ])
          ..where(mealTemplates.deletedAt.isNull())
          ..orderBy([OrderingTerm.asc(mealTemplates.name)]);

    return query.watch().map((rows) {
      final order = <String>[];
      final grouped = <String, MealTemplateWithTags>{};
      for (final row in rows) {
        final template = row.readTable(mealTemplates);
        final tag = row.readTableOrNull(tags);
        final entry = grouped.putIfAbsent(template.id, () {
          order.add(template.id);
          return MealTemplateWithTags(template: template, tags: []);
        });
        if (tag != null) entry.tags.add(tag);
      }
      return [for (final id in order) grouped[id]!];
    });
  }

  /// Inserts the template and its tag links atomically.
  Future<void> insertTemplateWithTags(
    MealTemplatesCompanion entry,
    List<String> tagIds,
  ) => transaction(() async {
    await into(mealTemplates).insert(entry);
    final templateId = entry.id.value;
    for (final tagId in tagIds) {
      await into(templateTags).insert(
        TemplateTagsCompanion.insert(
          templateId: templateId,
          tagId: tagId,
        ),
        mode: InsertMode.insertOrIgnore,
      );
    }
  });
}
