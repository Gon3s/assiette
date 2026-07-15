import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/meal_entry/domain/meal_entry_repository.dart';
import 'package:assiette/features/meal_entry/domain/meal_photo_service.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:assiette/features/meal_entry/presentation/meal_entry_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meal_entry_controller.g.dart';

/// All tags available for selection, sorted by label.
@riverpod
Stream<List<TagOption>> availableTags(Ref ref) =>
    ref.watch(mealEntryRepositoryProvider).watchTags();

/// Holds and mutates the meal entry form, and performs the final save.
@riverpod
class MealEntryController extends _$MealEntryController {
  @override
  MealEntryState build() {
    final now = DateTime.now();
    return MealEntryState(
      mealType: defaultMealTypeFor(now),
      timestamp: now,
      selectedTags: const [],
    );
  }

  /// Changes the meal type.
  void setMealType(MealType type) => state = state.copyWith(mealType: type);

  /// Changes the timestamp (kept local; converted to UTC on save).
  void setTimestamp(DateTime timestamp) =>
      state = state.copyWith(timestamp: timestamp);

  /// Updates the optional note.
  void setNote(String note) => state = state.copyWith(note: note);

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

  /// Persists the meal. Returns true on success.
  Future<bool> save() async {
    if (state.isSaving) return false;
    state = state.copyWith(isSaving: true);
    try {
      await ref
          .read(mealEntryRepositoryProvider)
          .saveMeal(
            timestamp: state.timestamp,
            mealType: state.mealType,
            tagIds: [for (final tag in state.selectedTags) tag.id],
            photoPath: state.photoPath,
            note: state.note,
          );
      return true;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }

  /// Saves the current form as a reusable favorite (MealTemplate) named
  /// [name]. Returns true on success; false for a blank name.
  Future<bool> saveAsFavorite(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty || state.isSaving) return false;
    state = state.copyWith(isSaving: true);
    try {
      await ref
          .read(favoritesRepositoryProvider)
          .createFavorite(
            name: trimmed,
            tagIds: [for (final tag in state.selectedTags) tag.id],
            defaultMealType: state.mealType,
            defaultPhotoPath: state.photoPath,
          );
      return true;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}
