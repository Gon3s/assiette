import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/favorites/domain/quick_favorite_repository.dart';
import 'package:drift/drift.dart';

class DriftQuickFavoriteRepository implements QuickFavoriteRepository {
  DriftQuickFavoriteRepository(this._db);
  final AppDatabase _db;

  @override
  Stream<String?> watchSelection() => _db.appSettingsDao
      .watchNotificationSettingsRow()
      .map((row) => row?.quickFavoriteId ?? coffeeQuickFavoriteId);

  @override
  Future<void> select(String id) => _db
      .into(_db.appSettings)
      .insertOnConflictUpdate(
        AppSettingsCompanion.insert(
          id: const Value(0),
          quickFavoriteId: Value(id),
        ),
      );
}
