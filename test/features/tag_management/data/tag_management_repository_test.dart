@Timeout(Duration(seconds: 10))
library;

import 'dart:async';
import 'dart:io';

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/favorites/data/favorites_repository.dart';
import 'package:assiette/features/meal_entry/data/meal_entry_repository.dart';
import 'package:assiette/features/tag_management/data/tag_management_repository.dart';
import 'package:assiette/features/tag_management/domain/managed_tag.dart';
import 'package:assiette/utils/tag_labels.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftTagManagementRepository repository;
  late DriftMealEntryRepository meals;
  late DriftFavoritesRepository favorites;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftTagManagementRepository(db: db);
    meals = DriftMealEntryRepository(db: db);
    favorites = DriftFavoritesRepository(db: db);
  });

  tearDown(() => db.close());

  Future<ManagedTag> usage(String id) async =>
      (await repository.watchTags().first).singleWhere((tag) => tag.id == id);

  Future<void> addMeal(String id, String tagId, DateTime timestamp) =>
      db.mealsDao.insertMealWithTags(
        MealsCompanion.insert(
          id: id,
          timestamp: timestamp.toUtc(),
          mealType: MealType.lunch,
        ),
        [tagId],
      );

  test('counts distinct local dates and excludes deleted meals', () async {
    final tag = await meals.createTag('test food');
    final morning = DateTime(2026, 10, 25, 0, 15);
    final evening = DateTime(2026, 10, 25, 23, 45);
    await addMeal('morning', tag.id, morning);
    await addMeal('evening', tag.id, evening);
    await addMeal('next-day', tag.id, DateTime(2026, 10, 26, 0, 15));
    await addMeal('deleted', tag.id, DateTime(2026, 10, 27, 12));
    await db.mealsDao.softDeleteMeal('deleted');
    await favorites.createFavorite(name: 'Breakfast', tagIds: [tag.id]);

    final result = await usage(tag.id);
    expect(result.dayCount, 2);
    expect(result.mealCount, 3);
    expect(result.favoriteCount, 1);
  });

  test('a favorite without meals counts as zero days', () async {
    final tag = await meals.createTag('favorite only');
    await favorites.createFavorite(name: 'Snack', tagIds: [tag.id]);
    final result = await usage(tag.id);
    expect(result.dayCount, 0);
    expect(result.mealCount, 0);
    expect(result.favoriteCount, 1);
    final favorite = (await favorites.watchFavorites().first).single;
    await favorites.deleteFavorite(favorite.id);
    expect((await usage(tag.id)).favoriteCount, 0);
  });

  test('usage stream refreshes for meal deletion and undo', () async {
    final tag = await meals.createTag('tracked');
    await addMeal('meal', tag.id, DateTime(2026, 10, 25, 12));
    final updates = StreamIterator(repository.watchTags());
    addTearDown(updates.cancel);
    await updates.moveNext();
    expect(updates.current.singleWhere((t) => t.id == tag.id).dayCount, 1);

    await db.mealsDao.softDeleteMeal('meal');
    await updates.moveNext();
    expect(updates.current.singleWhere((t) => t.id == tag.id).dayCount, 0);

    await db.mealsDao.restoreMeal('meal');
    await updates.moveNext();
    expect(updates.current.singleWhere((t) => t.id == tag.id).dayCount, 1);
  });

  test(
    'rename normalizes whitespace and preserves system provenance',
    () async {
      final original = (await db.tagsDao.watchAll().first).first;
      await repository.renameTag(original.id, '  Petit\t déjeuner  ');
      final renamed = await usage(original.id);
      expect(renamed.label, 'Petit déjeuner');
      expect(renamed.isSystem, isTrue);
      expect(renamed.category, original.category);
      final stored = await (db.select(
        db.tags,
      )..where((t) => t.id.equals(original.id))).getSingle();
      expect(stored.createdAt, original.createdAt);
      expect(stored.updatedAt.isBefore(original.updatedAt), isFalse);
    },
  );

  test(
    'rename rejects blank labels, normalized duplicates and missing tags',
    () async {
      final first = await meals.createTag('petit déjeuner');
      final second = await meals.createTag('autre');
      await expectLater(
        repository.renameTag(second.id, ' PETIT  DÉJEUNER '),
        throwsA(
          isA<TagLabelException>().having(
            (error) => error.reason,
            'reason',
            TagLabelError.duplicate,
          ),
        ),
      );
      await expectLater(
        repository.renameTag(second.id, ' \t '),
        throwsA(
          isA<TagLabelException>().having(
            (error) => error.reason,
            'reason',
            TagLabelError.empty,
          ),
        ),
      );
      await expectLater(
        repository.renameTag('missing', 'new label'),
        throwsA(
          isA<TagLabelException>().having(
            (error) => error.reason,
            'reason',
            TagLabelError.missing,
          ),
        ),
      );
      expect((await usage(second.id)).label, 'autre');
      await repository.renameTag(first.id, 'PETIT DÉJEUNER');
      expect((await usage(first.id)).label, 'PETIT DÉJEUNER');
    },
  );

  test(
    'creation reuses normalized active labels without reviving deleted tags',
    () async {
      final first = await meals.createTag('  nouveau  tag ');
      final same = await meals.createTag(' NOUVEAU\ttag ');
      expect(same.id, first.id);
      expect(same.label, 'nouveau tag');
      await repository.deleteTag(first.id);
      final recreated = await meals.createTag('nouveau tag');
      expect(recreated.id, isNot(first.id));
      final old = await (db.select(
        db.tags,
      )..where((t) => t.id.equals(first.id))).getSingle();
      expect(old.deletedAt, isNotNull);
    },
  );

  test(
    'renamed and deleted tags remain in history and export queries',
    () async {
      final tag = await meals.createTag('historical');
      final day = DateTime(2026, 10, 25, 12);
      await addMeal('meal', tag.id, day);
      await favorites.createFavorite(name: 'Saved meal', tagIds: [tag.id]);
      await repository.renameTag(tag.id, 'Corrected');
      expect(
        (await favorites.watchFavorites().first).single.tags.single.label,
        'Corrected',
      );
      expect((await meals.loadMeal('meal'))!.tags.single.label, 'Corrected');
      await repository.deleteTag(tag.id);

      expect(
        (await meals.watchTags().first).any((t) => t.id == tag.id),
        isFalse,
      );
      expect(
        (await repository.watchTags().first).any((t) => t.id == tag.id),
        isFalse,
      );
      final history = await db.mealsDao.watchByDayWithTags(day).first;
      expect(history.single.tags.single.label, 'Corrected');
      final exported = await db.mealsDao.getRangeWithTags(
        DateTime(2026, 10, 25).toUtc(),
        DateTime(2026, 10, 26).toUtc(),
      );
      expect(exported.single.tags.single.label, 'Corrected');
      final favorite = (await favorites.watchFavorites().first).single;
      expect(favorite.tags.single.label, 'Corrected');
      expect(await db.select(db.mealTags).get(), hasLength(1));
      expect(await db.select(db.templateTags).get(), hasLength(1));

      final newMealId = await favorites.logFavorite(favorite);
      expect((await meals.loadMeal(newMealId))!.tags, isEmpty);
      await meals.saveMeal(
        timestamp: day,
        mealType: MealType.lunch,
        tagIds: [tag.id],
      );
      await favorites.createFavorite(name: 'New favorite', tagIds: [tag.id]);
      final newFavorite = (await favorites.watchFavorites().first).singleWhere(
        (f) => f.name == 'New favorite',
      );
      expect(newFavorite.tags, isEmpty);

      await meals.updateMeal(
        id: 'meal',
        timestamp: day,
        mealType: MealType.dinner,
        tagIds: [tag.id],
      );
      expect((await meals.loadMeal('meal'))!.tags.single.id, tag.id);
    },
  );

  test(
    'system tags stay renamed or deleted after reopening the database',
    () async {
      final directory = await Directory.systemTemp.createTemp('assiette-tags-');
      final file = File('${directory.path}/test.sqlite');
      await db.close();
      var persistent = AppDatabase(NativeDatabase(file));
      try {
        final system = await persistent.tagsDao.watchAll().first;
        await persistent.tagsDao.renameTag(system[0].id, 'Renamed system tag');
        await persistent.tagsDao.softDeleteTag(system[1].id);
        await persistent.close();
        persistent = AppDatabase(NativeDatabase(file));
        final active = await persistent.tagsDao.watchAll().first;
        expect(active, hasLength(system.length - 1));
        expect(active.any((t) => t.id == system[1].id), isFalse);
        expect(
          active.singleWhere((t) => t.id == system[0].id).label,
          'Renamed system tag',
        );
        expect(
          active.singleWhere((t) => t.id == system[0].id).isSystem,
          isTrue,
        );
      } finally {
        await persistent.close();
        await directory.delete(recursive: true);
      }
    },
  );
}
