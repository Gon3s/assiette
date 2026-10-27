import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/tag_management/data/tag_management_repository.dart';
import 'package:assiette/features/tag_management/domain/managed_tag.dart';
import 'package:assiette/features/tag_management/domain/tag_merge_preview.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tag_management_repository.g.dart';

abstract class TagManagementRepository {
  Stream<List<ManagedTag>> watchTags();
  Future<void> renameTag(String id, String label);
  Future<void> deleteTag(String id);
  Future<TagMergePreview> previewMerge(String sourceId, String targetId);
  Future<void> mergeTags(String sourceId, String targetId);
}

@riverpod
TagManagementRepository tagManagementRepository(Ref ref) =>
    DriftTagManagementRepository(db: ref.watch(appDatabaseProvider));
