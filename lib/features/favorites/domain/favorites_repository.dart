import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/favorites/data/favorites_repository.dart';
import 'package:assiette/features/favorites/domain/meal_template_option.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_repository.g.dart';

/// Persistence for meal favorites (templates): listing and creation.
abstract class FavoritesRepository {
  /// Watches all non-deleted favorites, sorted by name, with their tags.
  Stream<List<MealTemplateOption>> watchFavorites();

  /// Creates a favorite named [name], copying [tagIds] into template_tags.
  Future<void> createFavorite({
    required String name,
    required List<String> tagIds,
    MealType? defaultMealType,
    String? defaultPhotoPath,
  });

  /// Updates the favorite [id]: name, tags and defaults.
  Future<void> updateFavorite({
    required String id,
    required String name,
    required List<String> tagIds,
    MealType? defaultMealType,
    String? defaultPhotoPath,
  });

  /// Soft-deletes the favorite [id].
  Future<void> deleteFavorite(String id);

  /// Instantiates [template] into a new meal timestamped now, copying its
  /// tags into meal_tags (transaction). Returns the created meal's id, so
  /// it can be undone with [undoLogFavorite].
  Future<String> logFavorite(MealTemplateOption template);

  /// Soft-deletes the meal created by a previous [logFavorite] call.
  Future<void> undoLogFavorite(String mealId);
}

/// Provides the [FavoritesRepository] implementation.
@riverpod
FavoritesRepository favoritesRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftFavoritesRepository(db: db);
}
