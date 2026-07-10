import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/favorites/domain/meal_template_option.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Drift-backed implementation of [FavoritesRepository].
class DriftFavoritesRepository implements FavoritesRepository {
  /// Creates a [DriftFavoritesRepository].
  DriftFavoritesRepository({required AppDatabase db}) : _db = db;

  final AppDatabase _db;

  static const _uuid = Uuid();

  @override
  Stream<List<MealTemplateOption>> watchFavorites() {
    return _db.templatesDao.watchAllWithTags().map(
      (templates) => [
        for (final entry in templates)
          MealTemplateOption(
            id: entry.template.id,
            name: entry.template.name,
            defaultMealType: _mealTypeFromName(
              entry.template.defaultMealType,
            ),
            defaultPhotoPath: entry.template.defaultPhotoPath,
            tags: [
              for (final tag in entry.tags)
                TagOption(
                  id: tag.id,
                  label: tag.label,
                  isSystem: tag.isSystem,
                ),
            ],
          ),
      ],
    );
  }

  @override
  Future<void> createFavorite({
    required String name,
    required List<String> tagIds,
    MealType? defaultMealType,
    String? defaultPhotoPath,
  }) {
    final now = DateTime.now().toUtc();
    return _db.templatesDao.insertTemplateWithTags(
      MealTemplatesCompanion.insert(
        id: _uuid.v4(),
        name: name,
        defaultMealType: Value(defaultMealType?.name),
        defaultPhotoPath: Value(defaultPhotoPath),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
      tagIds,
    );
  }

  @override
  Future<String> logFavorite(MealTemplateOption template) async {
    final id = _uuid.v4();
    final now = DateTime.now().toUtc();
    await _db.mealsDao.insertMealWithTags(
      MealsCompanion.insert(
        id: id,
        timestamp: now,
        mealType: template.defaultMealType ?? defaultMealTypeFor(now.toLocal()),
        photoPath: Value(template.defaultPhotoPath),
        templateId: Value(template.id),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
      [for (final tag in template.tags) tag.id],
    );
    return id;
  }

  @override
  Future<void> undoLogFavorite(String mealId) =>
      _db.mealsDao.softDeleteMeal(mealId);

  MealType? _mealTypeFromName(String? name) {
    if (name == null) return null;
    for (final type in MealType.values) {
      if (type.name == name) return type;
    }
    return null;
  }
}
