import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/meal_entry/data/meal_entry_repository.dart';
import 'package:assiette/features/meal_entry/domain/meal_draft.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meal_entry_repository.g.dart';

/// Persistence for the meal entry form: tags lookup/creation, the
/// transactional save of a meal with its tag links, and edit/delete.
abstract class MealEntryRepository {
  /// Watches all non-deleted tags, sorted by label.
  Stream<List<TagOption>> watchTags();

  /// Creates a user tag (is_system = false) and returns it.
  Future<TagOption> createTag(String label);

  /// Inserts the meal and its meal_tags links in a single transaction.
  Future<void> saveMeal({
    required DateTime timestamp,
    required MealType mealType,
    required List<String> tagIds,
    String? photoPath,
    String? note,
  });

  /// Loads the meal and its tags for editing, or `null` if it doesn't exist.
  Future<MealDraft?> loadMeal(String id);

  /// Replaces the meal's fields and tag links in a single transaction.
  Future<void> updateMeal({
    required String id,
    required DateTime timestamp,
    required MealType mealType,
    required List<String> tagIds,
    String? photoPath,
    String? note,
  });

  /// Soft-deletes the meal.
  Future<void> deleteMeal(String id);

  /// Undoes [deleteMeal].
  Future<void> undoDeleteMeal(String id);
}

/// Provides the [MealEntryRepository] implementation.
@riverpod
MealEntryRepository mealEntryRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftMealEntryRepository(db: db);
}
