import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/favorites/data/drift_quick_favorite_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quick_favorite_repository.g.dart';

const coffeeQuickFavoriteId = '@coffee';

abstract class QuickFavoriteRepository {
  Stream<String?> watchSelection();
  Future<void> select(String id);
}

@riverpod
QuickFavoriteRepository quickFavoriteRepository(Ref ref) =>
    DriftQuickFavoriteRepository(ref.watch(appDatabaseProvider));

@riverpod
Stream<String?> quickFavoriteSelection(Ref ref) =>
    ref.watch(quickFavoriteRepositoryProvider).watchSelection();
