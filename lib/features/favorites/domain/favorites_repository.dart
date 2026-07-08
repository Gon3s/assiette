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
}

/// Provides the [FavoritesRepository] implementation.
@riverpod
FavoritesRepository favoritesRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftFavoritesRepository(db: db);
}
