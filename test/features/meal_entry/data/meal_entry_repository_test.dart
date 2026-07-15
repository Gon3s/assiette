@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/meal_entry/data/meal_entry_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftMealEntryRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftMealEntryRepository(db: db);
  });

  tearDown(() => db.close());

  group('watchTags', () {
    test('exposes the seeded system tags sorted by label', () async {
      final tags = await repository.watchTags().first;

      expect(tags, isNotEmpty);
      expect(tags.every((t) => t.isSystem), isTrue);
      final labels = [for (final t in tags) t.label];
      expect(labels, containsAll(['café', 'gluten', 'stress']));
    });
  });

  group('createTag', () {
    test('inserts a user tag and returns it', () async {
      final tag = await repository.createTag('pizza');

      expect(tag.label, 'pizza');
      expect(tag.isSystem, isFalse);

      final all = await repository.watchTags().first;
      expect(all.any((t) => t.id == tag.id && !t.isSystem), isTrue);
    });
  });

  group('saveMeal', () {
    test('inserts the meal and its tag links in one transaction', () async {
      final tag = await repository.createTag('pizza');
      final timestamp = DateTime(2026, 7, 7, 12, 30);

      await repository.saveMeal(
        timestamp: timestamp,
        mealType: MealType.lunch,
        tagIds: [tag.id],
        note: 'très bon',
      );

      final meals =
          await db.mealsDao.watchByDayWithTags(DateTime(2026, 7, 7)).first;
      final saved = meals.single;
      expect(saved.meal.mealType, MealType.lunch);
      // Drift reads datetimes back as local; compare the instant.
      expect(saved.meal.timestamp.toUtc(), timestamp.toUtc());
      expect(saved.meal.note, 'très bon');
      expect(saved.meal.photoPath, isNull);
      expect([for (final t in saved.tags) t.label], ['pizza']);
    });

    test('saves without photo, tags or note (empty note stored as null)',
        () async {
      await repository.saveMeal(
        timestamp: DateTime(2026, 7, 7, 8),
        mealType: MealType.breakfast,
        tagIds: [],
        note: '',
      );

      final meals =
          await db.mealsDao.watchByDayWithTags(DateTime(2026, 7, 7)).first;
      final saved = meals.single;
      expect(saved.meal.note, isNull);
      expect(saved.tags, isEmpty);
    });
  });

  group('loadMeal', () {
    test('returns the meal with its tags', () async {
      final tag = await repository.createTag('pizza');
      await repository.saveMeal(
        timestamp: DateTime(2026, 7, 7, 12, 30),
        mealType: MealType.lunch,
        tagIds: [tag.id],
        note: 'très bon',
      );
      final saved =
          (await db.mealsDao.watchByDayWithTags(DateTime(2026, 7, 7)).first)
              .single;

      final draft = await repository.loadMeal(saved.meal.id);

      expect(draft, isNotNull);
      expect(draft!.mealType, MealType.lunch);
      expect(draft.note, 'très bon');
      expect(draft.tags.single.label, 'pizza');
    });

    test('returns null for an unknown id', () async {
      expect(await repository.loadMeal('missing'), isNull);
    });
  });

  group('updateMeal', () {
    test('replaces the fields and tag links', () async {
      final tagA = await repository.createTag('pizza');
      final tagB = await repository.createTag('salade');
      await repository.saveMeal(
        timestamp: DateTime(2026, 7, 7, 12),
        mealType: MealType.lunch,
        tagIds: [tagA.id],
      );
      final id =
          (await db.mealsDao.watchByDayWithTags(DateTime(2026, 7, 7)).first)
              .single
              .meal
              .id;

      await repository.updateMeal(
        id: id,
        timestamp: DateTime(2026, 7, 7, 19),
        mealType: MealType.dinner,
        tagIds: [tagB.id],
        note: 'modifié',
      );

      final draft = await repository.loadMeal(id);
      expect(draft!.mealType, MealType.dinner);
      expect(draft.note, 'modifié');
      expect(draft.tags.single.label, 'salade');
    });
  });

  group('deleteMeal / undoDeleteMeal', () {
    test('soft-deletes then restores the meal', () async {
      await repository.saveMeal(
        timestamp: DateTime(2026, 7, 7, 12),
        mealType: MealType.lunch,
        tagIds: [],
      );
      final id =
          (await db.mealsDao.watchByDayWithTags(DateTime(2026, 7, 7)).first)
              .single
              .meal
              .id;

      await repository.deleteMeal(id);
      expect(
        await db.mealsDao.watchByDayWithTags(DateTime(2026, 7, 7)).first,
        isEmpty,
      );

      await repository.undoDeleteMeal(id);
      expect(
        await db.mealsDao.watchByDayWithTags(DateTime(2026, 7, 7)).first,
        hasLength(1),
      );
    });
  });
}
