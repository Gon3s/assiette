import 'package:assiette/features/tag_management/domain/managed_tag.dart';
import 'package:assiette/features/tag_management/domain/tag_management_repository.dart';
import 'package:assiette/features/tag_management/domain/tag_merge_preview.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tag_management_controller.g.dart';

@riverpod
Stream<List<ManagedTag>> managedTags(Ref ref) =>
    ref.watch(tagManagementRepositoryProvider).watchTags();

@riverpod
Future<TagMergePreview> tagMergePreview(
  Ref ref,
  String sourceId,
  String targetId,
) {
  ref.watch(managedTagsProvider);
  return ref
      .watch(tagManagementRepositoryProvider)
      .previewMerge(sourceId, targetId);
}

@riverpod
class TagManagementController extends _$TagManagementController {
  @override
  FutureOr<void> build() {}

  Future<bool> renameTag(String id, String label) async {
    if (state.isLoading) return false;
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(tagManagementRepositoryProvider).renameTag(id, label),
    );
    if (ref.mounted) state = result;
    return !result.hasError;
  }

  Future<bool> deleteTag(String id) async {
    if (state.isLoading) return false;
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(tagManagementRepositoryProvider).deleteTag(id),
    );
    if (ref.mounted) state = result;
    return !result.hasError;
  }

  Future<bool> mergeTags(String sourceId, String targetId) async {
    if (state.isLoading) return false;
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref
          .read(tagManagementRepositoryProvider)
          .mergeTags(sourceId, targetId),
    );
    if (ref.mounted) state = result;
    return !result.hasError;
  }
}
