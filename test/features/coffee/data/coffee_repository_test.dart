import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/cloud_backup/data/database_snapshot_codec.dart';
import 'package:assiette/features/coffee/data/drift_coffee_repository.dart';
import 'package:assiette/features/coffee/domain/coffee_entry.dart';
import 'package:assiette/features/favorites/data/drift_quick_favorite_repository.dart';
import 'package:assiette/features/favorites/domain/quick_favorite_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftCoffeeRepository repository;
  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftCoffeeRepository(db.coffeeIntakesDao);
  });
  tearDown(() => db.close());

  test(
    'counts each intake in its local day including midnight boundaries',
    () async {
      final day = DateTime(2026, 10, 25);
      await repository.add(DateTime(2026, 10, 24, 23, 59));
      final first = await repository.add(day);
      final second = await repository.add(DateTime(2026, 10, 25, 23, 59));
      await repository.add(DateTime(2026, 10, 26));
      final rows = await repository.watchDay(day).first;
      expect(rows.map((row) => row.id), [first, second]);
      expect(await db.select(db.meals).get(), isEmpty);
    },
  );

  test(
    'correction moves a coffee between days, deletion and undo update totals',
    () async {
      final day = DateTime(2026, 10, 25, 10);
      final next = DateTime(2026, 10, 26, 11);
      final id = await repository.add(day);
      final created =
          (await db.select(db.coffeeIntakes).get()).single.createdAt;
      await repository.update(CoffeeEntry(id: id, timestamp: next));
      expect(await repository.watchDay(day).first, isEmpty);
      expect(
        (await repository.watchDay(next).first).single.timestamp.toUtc(),
        next.toUtc(),
      );
      expect(
        (await db.select(db.coffeeIntakes).get()).single.createdAt,
        created,
      );
      await repository.setDeleted(id, deleted: true);
      expect(await repository.watchDay(next).first, isEmpty);
      await repository.setDeleted(id, deleted: false);
      expect(await repository.watchDay(next).first, hasLength(1));
    },
  );

  test('backup restores coffee history and configured favorite', () async {
    const codec = DatabaseSnapshotCodec();
    final date = DateTime(2026, 10, 25, 10);
    final id = await repository.add(date);
    await repository.setDeleted(id, deleted: true);
    await repository.add(date);
    await DriftQuickFavoriteRepository(db).select(coffeeQuickFavoriteId);
    final snapshot = await codec.export(db);
    final restored = AppDatabase(NativeDatabase.memory());
    addTearDown(restored.close);
    await codec.restore(restored, snapshot, 'photos');
    expect(await restored.select(restored.coffeeIntakes).get(), hasLength(2));
    expect(
      await DriftCoffeeRepository(restored.coffeeIntakesDao)
          .watchDay(date)
          .first,
      hasLength(1),
    );
    expect(
      await DriftQuickFavoriteRepository(restored).watchSelection().first,
      coffeeQuickFavoriteId,
    );
  });

  test(
    'version 6 backup restores without coffee or shortcut preference',
    () async {
      const codec = DatabaseSnapshotCodec();
      final snapshot = await codec.export(db)
        ..['formatVersion'] = 6
        ..remove('coffeeIntakes');
      await repository.add(DateTime(2026, 10, 25));
      await codec.restore(db, snapshot, 'photos');
      expect(await db.select(db.coffeeIntakes).get(), isEmpty);
      expect(
        await DriftQuickFavoriteRepository(db).watchSelection().first,
        coffeeQuickFavoriteId,
      );
    },
  );

  test(
    'configuring a shortcut preserves onboarding and reminder settings',
    () async {
      await db.appSettingsDao.setOnboardingDone(done: true);
      final settings = DriftQuickFavoriteRepository(db);
      expect(await settings.watchSelection().first, coffeeQuickFavoriteId);
      await settings.select(coffeeQuickFavoriteId);
      expect(await db.appSettingsDao.watchOnboardingDone().first, isTrue);
      expect(await db.appSettingsDao.getRemindersWeatherEnabled(), isTrue);
      await settings.select('meal-template');
      expect(await settings.watchSelection().first, 'meal-template');
    },
  );
}
