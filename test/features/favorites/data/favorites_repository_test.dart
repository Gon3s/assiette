@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/favorites/data/favorites_repository.dart';
import 'package:assiette/features/favorites/domain/meal_template_option.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftFavoritesRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftFavoritesRepository(db: db);
  });

  tearDown(() => db.close());

  group('watchFavorites', () {
    test('starts empty', () async {
      final favorites = await repository.watchFavorites().first;
      expect(favorites, isEmpty);
    });
  });

  group('createFavorite', () {
    test('inserts the template and its tag links in one transaction', () async {
      final tags = await db.tagsDao.watchAll().first;
      final tagId = tags.first.id;

      await repository.createFavorite(
        name: 'Salade César',
        tagIds: [tagId],
        defaultMealType: MealType.lunch,
        defaultPhotoPath: '/photos/salad.jpg',
      );

      final favorites = await repository.watchFavorites().first;
      final favorite = favorites.single;
      expect(favorite.name, 'Salade César');
      expect(favorite.defaultMealType, MealType.lunch);
      expect(favorite.defaultPhotoPath, '/photos/salad.jpg');
      expect(favorite.tags.single.id, tagId);
    });

    test('saves without tags or photo', () async {
      await repository.createFavorite(name: 'Café', tagIds: []);

      final favorites = await repository.watchFavorites().first;
      final favorite = favorites.single;
      expect(favorite.defaultMealType, isNull);
      expect(favorite.defaultPhotoPath, isNull);
      expect(favorite.tags, isEmpty);
    });
  });

  group('updateFavorite', () {
    test('replaces the name, tags and defaults', () async {
      final tags = await db.tagsDao.watchAll().first;
      final tagA = tags[0];
      final tagB = tags[1];

      await repository.createFavorite(
        name: 'Salade César',
        tagIds: [tagA.id],
        defaultMealType: MealType.lunch,
        defaultPhotoPath: '/photos/salad.jpg',
      );
      final created = (await repository.watchFavorites().first).single;

      await repository.updateFavorite(
        id: created.id,
        name: 'Salade César v2',
        tagIds: [tagB.id],
        defaultMealType: MealType.dinner,
        defaultPhotoPath: '/photos/salad2.jpg',
      );

      final favorites = await repository.watchFavorites().first;
      final favorite = favorites.single;
      expect(favorite.name, 'Salade César v2');
      expect(favorite.defaultMealType, MealType.dinner);
      expect(favorite.defaultPhotoPath, '/photos/salad2.jpg');
      expect(favorite.tags.single.id, tagB.id);
    });

    test('clears defaults when set to null', () async {
      await repository.createFavorite(
        name: 'Café',
        tagIds: [],
        defaultMealType: MealType.breakfast,
        defaultPhotoPath: '/photos/coffee.jpg',
      );
      final created = (await repository.watchFavorites().first).single;

      await repository.updateFavorite(
        id: created.id,
        name: 'Café',
        tagIds: [],
      );

      final favorite = (await repository.watchFavorites().first).single;
      expect(favorite.defaultMealType, isNull);
      expect(favorite.defaultPhotoPath, isNull);
    });
  });

  group('deleteFavorite', () {
    test('soft-deletes the favorite, hiding it from watchFavorites', () async {
      await repository.createFavorite(name: 'Café', tagIds: []);
      final created = (await repository.watchFavorites().first).single;

      await repository.deleteFavorite(created.id);

      final favorites = await repository.watchFavorites().first;
      expect(favorites, isEmpty);
    });
  });

  group('logFavorite', () {
    test(
      'creates a meal copying the template tags and returns its id',
      () async {
        final tags = await db.tagsDao.watchAll().first;
        final tag = tags.first;
        final template = MealTemplateOption(
          id: 'template-1',
          name: 'Salade César',
          defaultMealType: MealType.lunch,
          tags: [
            TagOption(id: tag.id, label: tag.label, isSystem: tag.isSystem),
          ],
        );

        final mealId = await repository.logFavorite(template);

        final meals = await db.mealsDao
            .watchByDayWithTags(DateTime.now())
            .first;
        final meal = meals.singleWhere((m) => m.meal.id == mealId);
        expect(meal.meal.mealType, MealType.lunch);
        expect(meal.meal.templateId, 'template-1');
        expect(meal.tags.single.id, tag.id);
      },
    );

    test(
      'falls back to a time-of-day meal type when the template has none',
      () async {
        const template = MealTemplateOption(
          id: 'template-2',
          name: 'Snack',
          tags: [],
        );

        final mealId = await repository.logFavorite(template);

        final meals = await db.mealsDao
            .watchByDayWithTags(DateTime.now())
            .first;
        final meal = meals.singleWhere((m) => m.meal.id == mealId);
        expect(meal.meal.mealType, defaultMealTypeFor(DateTime.now()));
      },
    );
  });

  group('undoLogFavorite', () {
    test('soft-deletes the logged meal', () async {
      const template = MealTemplateOption(
        id: 'template-3',
        name: 'Café',
        tags: [],
      );
      final mealId = await repository.logFavorite(template);

      await repository.undoLogFavorite(mealId);

      final meals = await db.mealsDao.watchByDayWithTags(DateTime.now()).first;
      expect(meals.where((m) => m.meal.id == mealId), isEmpty);
    });
  });
}
