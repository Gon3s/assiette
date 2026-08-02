@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/cloud_backup/data/database_snapshot_codec.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase source;
  const codec = DatabaseSnapshotCodec();

  setUp(() {
    source = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => source.close());

  Future<void> seedSource() async {
    await source.into(source.tags).insert(
      TagsCompanion.insert(id: 'tag-1', label: 'gluten'),
    );
    await source.into(source.mealTemplates).insert(
      MealTemplatesCompanion.insert(
        id: 'template-1',
        name: 'Salade',
        defaultPhotoPath: const Value('/old/device/meal_photos/fav.jpg'),
      ),
    );
    await source.into(source.meals).insert(
      MealsCompanion.insert(
        id: 'meal-1',
        timestamp: DateTime.utc(2026, 7, 1, 12),
        mealType: MealType.lunch,
        photoPath: const Value('/old/device/meal_photos/meal.jpg'),
        templateId: const Value('template-1'),
      ),
    );
    await source.into(source.mealTags).insert(
      const MealTagsCompanion(mealId: Value('meal-1'), tagId: Value('tag-1')),
    );
    await source.into(source.symptoms).insert(
      SymptomsCompanion.insert(
        id: 'symptom-1',
        timestamp: DateTime.utc(2026, 7, 1, 9),
        type: SymptomType.migraine,
        intensity: 3,
      ),
    );
    await source.into(source.medicationIntakes).insert(
      MedicationIntakesCompanion.insert(
        id: 'intake-1',
        timestamp: DateTime.utc(2026, 7, 1, 9, 15),
        name: 'Ibuprofène',
        symptomId: const Value('symptom-1'),
      ),
    );
    await source.into(source.sleepEntries).insert(
      SleepEntriesCompanion.insert(
        id: 'sleep-1',
        nightDate: DateTime.utc(2026, 6, 30),
        quality: 2,
      ),
    );
    await source.into(source.environmentSnapshots).insert(
      EnvironmentSnapshotsCompanion.insert(
        id: 'env-1',
        timestamp: DateTime.utc(2026, 7, 1, 8),
        pressure: const Value(1013.2),
      ),
    );
    await source.into(source.appSettings).insert(
      AppSettingsCompanion.insert(
        id: const Value(0),
        onboardingDone: const Value(true),
      ),
    );
  }

  group('export', () {
    test('dumps every table keyed by name, including seeded system tags', () async {
      await seedSource();
      final snapshot = await codec.export(source);

      List<Map<String, dynamic>> table(String name) =>
          (snapshot[name]! as List).cast<Map<String, dynamic>>();

      final tags = table('tags');
      expect(tags.length, greaterThan(1)); // 25 seeded + the custom one
      expect(tags.any((row) => row['id'] == 'tag-1'), isTrue);
      expect(table('meals').single['id'], 'meal-1');
      expect(table('mealTags').single['tagId'], 'tag-1');
      expect(table('symptoms').single['id'], 'symptom-1');
      expect(table('medicationIntakes').single['symptomId'], 'symptom-1');
      expect(table('sleepEntries').single['id'], 'sleep-1');
      expect(table('environmentSnapshots').single['id'], 'env-1');
      expect(table('appSettings').single['id'], 0);
    });
  });

  group('photoFileNamesIn', () {
    test('collects basenames from meals and favorite templates', () async {
      await seedSource();
      final snapshot = await codec.export(source);

      expect(
        codec.photoFileNamesIn(snapshot),
        equals({'meal.jpg', 'fav.jpg'}),
      );
    });
  });

  group('restore', () {
    test('replaces every row and rewrites photo paths', () async {
      await seedSource();
      final snapshot = await codec.export(source);

      final target = AppDatabase(NativeDatabase.memory());
      addTearDown(target.close);

      await codec.restore(target, snapshot, '/new/device/meal_photos');

      final tags = await target.select(target.tags).get();
      expect(tags.any((tag) => tag.id == 'tag-1'), isTrue);

      final meal = (await target.select(target.meals).get()).single;
      expect(meal.id, 'meal-1');
      expect(meal.photoPath, '/new/device/meal_photos/meal.jpg');

      final template = (await target.select(target.mealTemplates).get()).single;
      expect(
        template.defaultPhotoPath,
        '/new/device/meal_photos/fav.jpg',
      );

      final mealTag = (await target.select(target.mealTags).get()).single;
      expect(mealTag.mealId, 'meal-1');
      expect(mealTag.tagId, 'tag-1');

      final intake =
          (await target.select(target.medicationIntakes).get()).single;
      expect(intake.symptomId, 'symptom-1');

      final settings = (await target.select(target.appSettings).get()).single;
      expect(settings.onboardingDone, isTrue);
    });

    test('wipes pre-existing local rows not present in the snapshot', () async {
      await seedSource();
      final snapshot = await codec.export(source);

      final target = AppDatabase(NativeDatabase.memory());
      addTearDown(target.close);
      await target.into(target.tags).insert(
        TagsCompanion.insert(id: 'stale-tag', label: 'stale'),
      );

      await codec.restore(target, snapshot, '/new/device/meal_photos');

      final tags = await target.select(target.tags).get();
      expect(tags.any((tag) => tag.id == 'stale-tag'), isFalse);
    });
  });
}
