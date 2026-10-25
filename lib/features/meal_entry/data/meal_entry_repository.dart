import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/meal_entry/domain/meal_draft.dart';
import 'package:assiette/features/meal_entry/domain/meal_entry_repository.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Drift-backed implementation of [MealEntryRepository].
class DriftMealEntryRepository implements MealEntryRepository {
  /// Creates a [DriftMealEntryRepository].
  DriftMealEntryRepository({required this._db});

  final AppDatabase _db;

  static const _uuid = Uuid();

  @override
  Stream<List<TagOption>> watchTags() {
    return _db.tagsDao.watchAll().map(
      (tags) => [
        for (final tag in tags)
          TagOption(id: tag.id, label: tag.label, isSystem: tag.isSystem),
      ],
    );
  }

  @override
  Future<TagOption> createTag(String label) async {
    final tag = await _db.tagsDao.createOrGet(id: _uuid.v4(), label: label);
    return TagOption(id: tag.id, label: tag.label, isSystem: tag.isSystem);
  }

  @override
  Future<void> saveMeal({
    required DateTime timestamp,
    required MealType mealType,
    required List<String> tagIds,
    String? photoPath,
    String? note,
  }) async {
    final now = DateTime.now().toUtc();
    return _db.mealsDao.insertMealWithTags(
      MealsCompanion.insert(
        id: _uuid.v4(),
        timestamp: timestamp.toUtc(),
        mealType: mealType,
        photoPath: Value(photoPath),
        note: Value((note?.isEmpty ?? true) ? null : note),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
      await _db.tagsDao.activeIds(tagIds),
    );
  }

  @override
  Future<MealDraft?> loadMeal(String id) async {
    final result = await _db.mealsDao.getMealWithTagsById(id);
    if (result == null) return null;
    return MealDraft(
      id: result.meal.id,
      timestamp: result.meal.timestamp,
      mealType: result.meal.mealType,
      tags: [
        for (final tag in result.tags)
          TagOption(id: tag.id, label: tag.label, isSystem: tag.isSystem),
      ],
      photoPath: result.meal.photoPath,
      note: result.meal.note,
    );
  }

  @override
  Future<void> updateMeal({
    required String id,
    required DateTime timestamp,
    required MealType mealType,
    required List<String> tagIds,
    String? note,
  }) {
    return _db.mealsDao.updateMealWithTags(
      id,
      MealsCompanion(
        timestamp: Value(timestamp.toUtc()),
        mealType: Value(mealType),
        note: Value((note?.isEmpty ?? true) ? null : note),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
      tagIds,
    );
  }

  @override
  Future<void> deleteMeal(String id) => _db.mealsDao.softDeleteMeal(id);

  @override
  Future<void> undoDeleteMeal(String id) => _db.mealsDao.restoreMeal(id);
}
