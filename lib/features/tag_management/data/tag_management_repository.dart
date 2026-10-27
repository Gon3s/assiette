import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/tag_management/domain/managed_tag.dart';
import 'package:assiette/features/tag_management/domain/tag_management_repository.dart';
import 'package:assiette/features/tag_management/domain/tag_merge_preview.dart';
import 'package:assiette/utils/tag_merge_exception.dart';

class DriftTagManagementRepository implements TagManagementRepository {
  DriftTagManagementRepository({required this.db});

  final AppDatabase db;

  @override
  Stream<List<ManagedTag>> watchTags() => db.tagsDao.watchWithUsage().map(
    (rows) => [
      for (final row in rows)
        ManagedTag(
          id: row.tag.id,
          label: row.tag.label,
          category: row.tag.category,
          isSystem: row.tag.isSystem,
          dayCount: row.dayCount,
          mealCount: row.mealCount,
          favoriteCount: row.favoriteCount,
        ),
    ],
  );

  @override
  Future<void> renameTag(String id, String label) =>
      db.tagsDao.renameTag(id, label);

  @override
  Future<void> deleteTag(String id) => db.tagsDao.softDeleteTag(id);

  @override
  Future<TagMergePreview> previewMerge(String sourceId, String targetId) =>
      db.transaction(() async {
        if (sourceId == targetId) {
          throw const TagMergeException(TagMergeError.sameTag);
        }
        final tags = await watchTags().first;
        final source = tags.where((tag) => tag.id == sourceId).firstOrNull;
        final target = tags.where((tag) => tag.id == targetId).firstOrNull;
        if (source == null || target == null) {
          throw const TagMergeException(TagMergeError.missing);
        }
        return TagMergePreview(
          source: source,
          target: target,
          favoriteNames: await db.tagsDao.favoriteNamesForTag(sourceId),
        );
      });

  @override
  Future<void> mergeTags(String sourceId, String targetId) =>
      db.tagsDao.mergeTags(sourceId, targetId);
}
