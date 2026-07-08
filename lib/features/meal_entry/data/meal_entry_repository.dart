import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/meal_entry/domain/meal_entry_repository.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Drift-backed implementation of [MealEntryRepository].
class DriftMealEntryRepository implements MealEntryRepository {
  /// Creates a [DriftMealEntryRepository].
  DriftMealEntryRepository({required AppDatabase db}) : _db = db;

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
    final id = _uuid.v4();
    final now = DateTime.now().toUtc();
    await _db.tagsDao.insertTag(
      TagsCompanion.insert(
        id: id,
        label: label,
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
    return TagOption(id: id, label: label, isSystem: false);
  }

  @override
  Future<void> saveMeal({
    required DateTime timestamp,
    required MealType mealType,
    required List<String> tagIds,
    String? photoPath,
    String? note,
  }) {
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
      tagIds,
    );
  }
}
