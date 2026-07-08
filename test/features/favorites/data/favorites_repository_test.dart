@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/favorites/data/favorites_repository.dart';
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
}
