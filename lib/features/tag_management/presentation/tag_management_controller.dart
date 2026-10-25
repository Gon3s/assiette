import 'package:assiette/features/tag_management/domain/managed_tag.dart';
import 'package:assiette/features/tag_management/domain/tag_management_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tag_management_controller.g.dart';

@riverpod
Stream<List<ManagedTag>> managedTags(Ref ref) =>
    ref.watch(tagManagementRepositoryProvider).watchTags();

@riverpod
class TagManagementController extends _$TagManagementController {
  @override
  FutureOr<void> build() {}

  Future<bool> renameTag(String id, String label) async {
    if (state.isLoading) return false;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(tagManagementRepositoryProvider).renameTag(id, label),
    );
    return !state.hasError;
  }

  Future<bool> deleteTag(String id) async {
    if (state.isLoading) return false;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(tagManagementRepositoryProvider).deleteTag(id),
    );
    return !state.hasError;
  }
}
