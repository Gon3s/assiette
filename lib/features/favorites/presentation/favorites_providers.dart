import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/favorites/domain/meal_template_option.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_providers.g.dart';

/// All non-deleted favorites (meal templates), sorted by name.
@riverpod
Stream<List<MealTemplateOption>> favoriteTemplates(Ref ref) =>
    ref.watch(favoritesRepositoryProvider).watchFavorites();
