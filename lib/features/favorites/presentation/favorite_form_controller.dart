import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/favorites/presentation/favorite_form_state.dart';
import 'package:assiette/features/favorites/presentation/favorites_providers.dart';
import 'package:assiette/features/meal_entry/domain/meal_entry_repository.dart';
import 'package:assiette/features/meal_entry/domain/meal_photo_service.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_form_controller.g.dart';

/// Holds and mutates the favorite create/edit form, seeded from the
/// existing favorite when [templateId] is not null, and performs the
/// final save (create or update).
@riverpod
class FavoriteFormController extends _$FavoriteFormController {
  @override
  FavoriteFormState build(String? templateId) {
    if (templateId == null) {
      return const FavoriteFormState();
    }
    final favorites = ref.read(favoriteTemplatesProvider).value ?? const [];
    for (final favorite in favorites) {
      if (favorite.id != templateId) continue;
      return FavoriteFormState(
        id: favorite.id,
        name: favorite.name,
        mealType: favorite.defaultMealType,
        selectedTags: favorite.tags,
        photoPath: favorite.defaultPhotoPath,
      );
    }
    return FavoriteFormState(id: templateId);
  }

  /// Changes the favorite's name.
  void setName(String name) => state = state.copyWith(name: name);

  /// Changes the default meal type (null means "no default").
  void setMealType(MealType? type) => state = state.copyWith(mealType: type);

  /// Adds [tag] to the selection (no duplicates).
  void addTag(TagOption tag) {
    if (state.selectedTags.any((t) => t.id == tag.id)) return;
    state = state.copyWith(selectedTags: [...state.selectedTags, tag]);
  }

  /// Removes [tag] from the selection.
  void removeTag(TagOption tag) => state = state.copyWith(
    selectedTags: state.selectedTags.where((t) => t.id != tag.id).toList(),
  );

  /// Creates a user tag with [label] and adds it to the selection.
  Future<void> createAndAddTag(String label) async {
    final trimmed = label.trim();
    if (trimmed.isEmpty) return;
    final tag = await ref.read(mealEntryRepositoryProvider).createTag(trimmed);
    addTag(tag);
  }

  /// Opens the camera and stores the shot; no-op if the user cancels.
  Future<void> takePhoto() async {
    final path = await ref.read(mealPhotoServiceProvider).captureFromCamera();
    if (path != null) {
      state = state.copyWith(photoPath: path);
    }
  }

  /// Discards the current photo.
  void removePhoto() => state = state.copyWith(photoPath: null);

  /// Persists the favorite (create or update). Returns false for a blank
  /// name.
  Future<bool> save() async {
    final trimmed = state.name.trim();
    if (trimmed.isEmpty || state.isSaving) return false;
    state = state.copyWith(isSaving: true);
    try {
      final repository = ref.read(favoritesRepositoryProvider);
      final tagIds = [for (final tag in state.selectedTags) tag.id];
      if (state.id == null) {
        await repository.createFavorite(
          name: trimmed,
          tagIds: tagIds,
          defaultMealType: state.mealType,
          defaultPhotoPath: state.photoPath,
        );
      } else {
        await repository.updateFavorite(
          id: state.id!,
          name: trimmed,
          tagIds: tagIds,
          defaultMealType: state.mealType,
          defaultPhotoPath: state.photoPath,
        );
      }
      return true;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}
