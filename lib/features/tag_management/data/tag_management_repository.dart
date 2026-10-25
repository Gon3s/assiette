import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/tag_management/domain/managed_tag.dart';
import 'package:assiette/features/tag_management/domain/tag_management_repository.dart';

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
}
