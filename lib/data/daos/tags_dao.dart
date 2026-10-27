import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/meal_tags_table.dart';
import 'package:assiette/data/db/tables/meal_templates_table.dart';
import 'package:assiette/data/db/tables/meals_table.dart';
import 'package:assiette/data/db/tables/tags_table.dart';
import 'package:assiette/data/db/tables/template_tags_table.dart';
import 'package:assiette/utils/tag_labels.dart';
import 'package:assiette/utils/tag_merge_exception.dart';
import 'package:drift/drift.dart';

part 'tags_dao.g.dart';

class TagWithUsage {
  const TagWithUsage({
    required this.tag,
    required this.dayCount,
    required this.mealCount,
    required this.favoriteCount,
  });

  final Tag tag;
  final int dayCount;
  final int mealCount;
  final int favoriteCount;
}

@DriftAccessor(tables: [Tags, Meals, MealTags, MealTemplates, TemplateTags])
class TagsDao extends DatabaseAccessor<AppDatabase> with _$TagsDaoMixin {
  TagsDao(super.attachedDatabase);

  Stream<List<Tag>> watchAll() {
    return (select(tags)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.label)]))
        .watch();
  }

  Future<void> insertTag(TagsCompanion entry) => into(tags).insert(entry);

  /// Reads raw meal instants so day boundaries follow the device's local zone,
  /// including daylight saving changes, rather than grouping by UTC dates.
  Stream<List<TagWithUsage>> watchWithUsage() =>
      customSelect(
        '''
    SELECT tags.*, meals.timestamp AS meal_timestamp,
      COALESCE(favorites.usage_count, 0) AS favorite_count
    FROM tags
    LEFT JOIN meal_tags ON meal_tags.tag_id = tags.id
    LEFT JOIN meals ON meals.id = meal_tags.meal_id
      AND meals.deleted_at IS NULL
    LEFT JOIN (
      SELECT template_tags.tag_id, COUNT(*) AS usage_count
      FROM template_tags
      INNER JOIN meal_templates ON meal_templates.id = template_tags.template_id
        AND meal_templates.deleted_at IS NULL
      GROUP BY template_tags.tag_id
    ) AS favorites ON favorites.tag_id = tags.id
    WHERE tags.deleted_at IS NULL
    ORDER BY tags.label COLLATE NOCASE
    ''',
        readsFrom: {tags, meals, mealTags, mealTemplates, templateTags},
      ).watch().map((rows) {
        final tagRows = <String, Tag>{};
        final days = <String, Set<DateTime>>{};
        final mealCounts = <String, int>{};
        final favoriteCounts = <String, int>{};
        for (final row in rows) {
          final tag = tags.map(row.data);
          tagRows[tag.id] = tag;
          favoriteCounts[tag.id] = row.read<int>('favorite_count');
          final timestamp = row.readNullable<DateTime>('meal_timestamp');
          if (timestamp == null) continue;
          final local = timestamp.toLocal();
          days
              .putIfAbsent(tag.id, () => {})
              .add(
                DateTime(local.year, local.month, local.day),
              );
          mealCounts.update(tag.id, (count) => count + 1, ifAbsent: () => 1);
        }
        return [
          for (final tag in tagRows.values)
            TagWithUsage(
              tag: tag,
              dayCount: days[tag.id]?.length ?? 0,
              mealCount: mealCounts[tag.id] ?? 0,
              favoriteCount: favoriteCounts[tag.id] ?? 0,
            ),
        ];
      });

  Future<List<String>> activeIds(List<String> ids) async => [
    for (final tag in await (select(
      tags,
    )..where((t) => t.id.isIn(ids) & t.deletedAt.isNull())).get())
      tag.id,
  ];

  Future<Tag> createOrGet({required String id, required String label}) =>
      transaction(() async {
        final normalized = normalizeTagLabel(label);
        if (normalized.isEmpty) {
          throw const TagLabelException(TagLabelError.empty);
        }
        final all = await watchAll().first;
        for (final tag in all) {
          if (_labelKey(tag.label) == _labelKey(normalized)) return tag;
        }
        final now = DateTime.now().toUtc();
        await insertTag(
          TagsCompanion.insert(
            id: id,
            label: normalized,
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
        return (select(tags)..where((t) => t.id.equals(id))).getSingle();
      });

  Future<void> renameTag(String id, String label) => transaction(() async {
    final normalized = normalizeTagLabel(label);
    if (normalized.isEmpty) {
      throw const TagLabelException(TagLabelError.empty);
    }
    final all = await watchAll().first;
    if (!all.any((tag) => tag.id == id)) {
      throw const TagLabelException(TagLabelError.missing);
    }
    if (all.any(
      (tag) => tag.id != id && _labelKey(tag.label) == _labelKey(normalized),
    )) {
      throw const TagLabelException(TagLabelError.duplicate);
    }
    await (update(tags)..where((t) => t.id.equals(id))).write(
      TagsCompanion(
        label: Value(normalized),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  });

  Future<void> softDeleteTag(String id) {
    final now = DateTime.now().toUtc();
    return (update(tags)..where((t) => t.id.equals(id) & t.deletedAt.isNull()))
        .write(TagsCompanion(deletedAt: Value(now), updatedAt: Value(now)));
  }

  Future<List<String>> favoriteNamesForTag(String id) async {
    final query =
        select(mealTemplates).join([
            innerJoin(
              templateTags,
              templateTags.templateId.equalsExp(mealTemplates.id),
            ),
          ])
          ..where(
            templateTags.tagId.equals(id) & mealTemplates.deletedAt.isNull(),
          )
          ..orderBy([
            OrderingTerm.asc(mealTemplates.name),
            OrderingTerm.asc(mealTemplates.id),
          ]);
    return [
      for (final row in await query.get()) row.readTable(mealTemplates).name,
    ];
  }

  Future<void> mergeTags(
    String sourceId,
    String targetId,
  ) => transaction(() async {
    if (sourceId == targetId) {
      throw const TagMergeException(TagMergeError.sameTag);
    }
    final active = await activeIds([sourceId, targetId]);
    if (active.length != 2) {
      throw const TagMergeException(TagMergeError.missing);
    }
    final now = DateTime.now().toUtc();
    // Include deleted parents so restoring an entry preserves the merge.
    await (update(meals)..where(
          (t) => t.id.isInQuery(
            selectOnly(mealTags)
              ..addColumns([mealTags.mealId])
              ..where(mealTags.tagId.equals(sourceId)),
          ),
        ))
        .write(MealsCompanion(updatedAt: Value(now)));
    await (update(mealTemplates)..where(
          (t) => t.id.isInQuery(
            selectOnly(templateTags)
              ..addColumns([templateTags.templateId])
              ..where(templateTags.tagId.equals(sourceId)),
          ),
        ))
        .write(MealTemplatesCompanion(updatedAt: Value(now)));
    await customInsert(
      'INSERT OR IGNORE INTO meal_tags (meal_id, tag_id) '
      'SELECT meal_id, ? FROM meal_tags WHERE tag_id = ?',
      variables: [Variable.withString(targetId), Variable.withString(sourceId)],
      updates: {mealTags},
    );
    await (delete(mealTags)..where((t) => t.tagId.equals(sourceId))).go();
    await customInsert(
      'INSERT OR IGNORE INTO template_tags (template_id, tag_id) '
      'SELECT template_id, ? FROM template_tags WHERE tag_id = ?',
      variables: [Variable.withString(targetId), Variable.withString(sourceId)],
      updates: {templateTags},
    );
    await (delete(templateTags)..where((t) => t.tagId.equals(sourceId))).go();
    await softDeleteTag(sourceId);
    await (update(tags)..where((t) => t.id.equals(targetId))).write(
      TagsCompanion(updatedAt: Value(now)),
    );
  });

  String _labelKey(String label) => normalizeTagLabel(label).toLowerCase();
}
