import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/meal_entry/domain/meal_draft.dart';
import 'package:assiette/features/meal_entry/domain/meal_entry_repository.dart';
import 'package:assiette/features/meal_entry/domain/meal_photo_service.dart';
import 'package:assiette/features/meal_entry/domain/photo_tag_suggestion_service.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:assiette/features/meal_entry/presentation/meal_entry_state.dart';
import 'package:assiette/features/notifications/data/notifications_service.dart';
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
  /// Triggers a best-effort tag suggestion pass (US-19) unless disabled in
  /// settings.
  Future<void> takePhoto() async {
    final path = await ref.read(mealPhotoServiceProvider).captureFromCamera();
    if (path == null) return;
    state = state.copyWith(
      photoPath: path,
      suggestedTagLabels: const [],
    );

    final repository = ref.read(mealEntryRepositoryProvider);
    final enabled = await repository.photoTagSuggestionsEnabled();
    if (!enabled || state.photoPath != path) return;

    state = state.copyWith(isSuggestingTags: true);
    final labels = await ref
        .read(photoTagSuggestionServiceProvider)
        .suggestLabels(path);
    if (state.photoPath != path) return; // photo changed while awaiting
    final selectedLabels = state.selectedTags
        .map((t) => t.label.toLowerCase())
        .toSet();
    state = state.copyWith(
      isSuggestingTags: false,
      suggestedTagLabels: [
        for (final label in labels)
          if (!selectedLabels.contains(label.toLowerCase())) label,
      ],
    );
  }

  /// Discards the current photo and any pending suggestions.
  void removePhoto() => state = state.copyWith(
    photoPath: null,
    suggestedTagLabels: const [],
    isSuggestingTags: false,
  );

  /// Accepts a suggested [label]: matches it against an existing tag
  /// (case-insensitive) or creates a new one, then adds it to the
  /// selection and clears it from the suggestions.
  Future<void> acceptSuggestedTag(String label) async {
    final existing = ref
        .read(availableTagsProvider)
        .value
        ?.where((t) => t.label.toLowerCase() == label.toLowerCase())
        .firstOrNull;
    if (existing != null) {
      addTag(existing);
    } else {
      await createAndAddTag(label);
    }
    dismissSuggestedTag(label);
  }

  /// Discards a suggested [label] without adding it.
  void dismissSuggestedTag(String label) => state = state.copyWith(
    suggestedTagLabels:
        state.suggestedTagLabels.where((l) => l != label).toList(),
  );

  /// Seeds the form from a previously logged meal for editing.
  void loadForEdit(MealDraft draft) {
    state = MealEntryState(
      id: draft.id,
      mealType: draft.mealType,
      timestamp: draft.timestamp,
      selectedTags: draft.tags,
      note: draft.note ?? '',
      photoPath: draft.photoPath,
    );
  }

  /// Persists the meal (create or update). Returns true on success.
  Future<bool> save() async {
    if (state.isSaving) return false;
    state = state.copyWith(isSaving: true);
    try {
      final repository = ref.read(mealEntryRepositoryProvider);
      final id = state.id;
      if (id == null) {
        await repository.saveMeal(
          timestamp: state.timestamp,
          mealType: state.mealType,
          tagIds: [for (final tag in state.selectedTags) tag.id],
          photoPath: state.photoPath,
          note: state.note,
        );
      } else {
        await repository.updateMeal(
          id: id,
          timestamp: state.timestamp,
          mealType: state.mealType,
          tagIds: [for (final tag in state.selectedTags) tag.id],
          photoPath: state.photoPath,
          note: state.note,
        );
      }
      // Requested here, in the foreground, right after the user's first
      // meal log - the earliest moment the reminders being permitted
      // becomes actually useful to them.
      await LocalNotificationsService().requestPermission();
      return true;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }

  /// Soft-deletes the meal being edited. Returns false when creating (no
  /// id yet) or while another save/delete is in flight.
  Future<bool> delete() async {
    final id = state.id;
    if (id == null || state.isSaving) return false;
    state = state.copyWith(isSaving: true);
    try {
      await ref.read(mealEntryRepositoryProvider).deleteMeal(id);
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
