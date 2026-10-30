@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/data/db/enums/migraine_laterality.dart';
import 'package:assiette/data/db/enums/migraine_location.dart';
import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/cloud_backup/data/database_snapshot_codec.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_exception.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  late AppDatabase source;
  const codec = DatabaseSnapshotCodec();

  setUp(() {
    source = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => source.close());

  Future<void> seedSource() async {
    await source
        .into(source.tags)
        .insert(
          TagsCompanion.insert(id: 'tag-1', label: 'gluten'),
        );
    await source
        .into(source.mealTemplates)
        .insert(
          MealTemplatesCompanion.insert(
            id: 'template-1',
            name: 'Salade',
            defaultPhotoPath: const Value('/old/device/meal_photos/fav.jpg'),
          ),
        );
    await source
        .into(source.meals)
        .insert(
          MealsCompanion.insert(
            id: 'meal-1',
            timestamp: DateTime.utc(2026, 7, 1, 12),
            mealType: MealType.lunch,
            photoPath: const Value('/old/device/meal_photos/meal.jpg'),
            templateId: const Value('template-1'),
          ),
        );
    await source
        .into(source.mealTags)
        .insert(
          const MealTagsCompanion(
            mealId: Value('meal-1'),
            tagId: Value('tag-1'),
          ),
        );
    await source
        .into(source.symptoms)
        .insert(
          SymptomsCompanion.insert(
            id: 'symptom-1',
            timestamp: DateTime.utc(2026, 7, 1, 9),
            type: SymptomType.migraine,
            intensity: const Value(3),
            startedAt: Value(DateTime.utc(2026, 7, 1, 9)),
            startPrecision: const Value(MigraineStartPrecision.exact),
            endedAt: Value(DateTime.utc(2026, 7, 1, 11)),
            initialIntensity: const Value(3),
            maximumIntensity: const Value(8),
          ),
        );
    await source
        .into(source.migraineIntensityMeasurements)
        .insert(
          MigraineIntensityMeasurementsCompanion.insert(
            id: 'observation-1',
            symptomId: 'symptom-1',
            timestamp: DateTime.utc(2026, 7, 1, 10),
            intensity: 8,
            laterality: const Value(MigraineLaterality.left),
            location: const Value(MigraineLocation.temple),
            aura: const Value(false),
            nausea: const Value(true),
            note: const Value('structured observation'),
          ),
        );
    await source
        .into(source.medicationIntakes)
        .insert(
          MedicationIntakesCompanion.insert(
            id: 'intake-1',
            timestamp: DateTime.utc(2026, 7, 1, 9, 15),
            name: 'Ibuprofène',
            symptomId: const Value('symptom-1'),
          ),
        );
    await source
        .into(source.sleepEntries)
        .insert(
          SleepEntriesCompanion.insert(
            id: 'sleep-1',
            nightDate: DateTime.utc(2026, 6, 30),
            quality: const Value(2),
          ),
        );
    await source
        .into(source.environmentSnapshots)
        .insert(
          EnvironmentSnapshotsCompanion.insert(
            id: 'env-1',
            timestamp: DateTime.utc(2026, 7, 1, 8),
            pressure: const Value(1013.2),
          ),
        );
    await source
        .into(source.appSettings)
        .insert(
          AppSettingsCompanion.insert(
            id: const Value(0),
            onboardingDone: const Value(true),
          ),
        );
  }

  group('export', () {
    test(
      'dumps every table keyed by name, including custom tags',
      () async {
        await seedSource();
        final snapshot = await codec.export(source);

        List<Map<String, dynamic>> table(String name) =>
            (snapshot[name]! as List).cast<Map<String, dynamic>>();

        final tags = table('tags');
        expect(snapshot['formatVersion'], 7);
        expect(tags, hasLength(1));
        expect(tags.single['id'], 'tag-1');
        expect(table('meals').single['id'], 'meal-1');
        expect(table('mealTags').single['tagId'], 'tag-1');
        expect(table('symptoms').single['id'], 'symptom-1');
        final observation = table('migraineIntensityMeasurements').single;
        expect(observation['laterality'], MigraineLaterality.left.index);
        expect(observation['aura'], isFalse);
        expect(table('medicationIntakes').single['symptomId'], 'symptom-1');
        expect(table('sleepEntries').single['id'], 'sleep-1');
        expect(table('environmentSnapshots').single['id'], 'env-1');
        expect(table('appSettings').single['id'], 0);
      },
    );
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

  group('validation', () {
    test('rejects more than 100000 rows before deserializing them', () async {
      final snapshot = await codec.export(source)
        ..['tags'] = List.filled(100001, <String, dynamic>{});
      await expectLater(
        codec.validate(snapshot),
        throwsA(isA<CloudBackupException>()),
      );
    });

    for (final version in [null, 0, -1, 8, 1.0, '5']) {
      test('rejects unsupported format version $version', () async {
        final snapshot = await codec.export(source)
          ..['formatVersion'] = version;
        await expectLater(
          codec.validate(snapshot),
          throwsA(isA<CloudBackupException>()),
        );
      });
    }

    test('requires tables, object rows and version-specific fields', () async {
      for (final mutate in <void Function(Map<String, dynamic>)>[
        (snapshot) => snapshot.remove('meals'),
        (snapshot) => snapshot['tags'] = <String, dynamic>{},
        (snapshot) => snapshot['tags'] = [null],
        (snapshot) => snapshot['unexpected'] = <Object>[],
        (snapshot) => snapshot.remove('migraineIntensityMeasurements'),
      ]) {
        final snapshot = await codec.export(source);
        mutate(snapshot);
        await expectLater(
          codec.validate(snapshot),
          throwsA(isA<CloudBackupException>()),
        );
      }
    });

    test(
      'rejects invalid typed rows, enums and duplicate primary keys',
      () async {
        await seedSource();
        for (final mutate in <void Function(Map<String, dynamic>)>[
          (snapshot) =>
              ((snapshot['meals'] as List).single
                      as Map<String, dynamic>)['photoPath'] =
                  42,
          (snapshot) =>
              ((snapshot['meals'] as List).single
                      as Map<String, dynamic>)['mealType'] =
                  99,
          (snapshot) => (snapshot['meals'] as List).add(
            (snapshot['meals'] as List).first,
          ),
          (snapshot) =>
              ((snapshot['meals'] as List).single as Map<String, dynamic>)
                  .remove('timestamp'),
          (snapshot) =>
              ((snapshot['meals'] as List).single
                      as Map<String, dynamic>)['photoPath'] =
                  '/old/CON.jpg',
        ]) {
          final snapshot = await codec.export(source);
          mutate(snapshot);
          await expectLater(
            codec.validate(snapshot),
            throwsA(isA<CloudBackupException>()),
          );
        }
      },
    );

    for (final reference in [
      ('meals', 'templateId'),
      ('mealTags', 'mealId'),
      ('mealTags', 'tagId'),
      ('medicationIntakes', 'symptomId'),
      ('migraineIntensityMeasurements', 'symptomId'),
    ]) {
      test('rejects a dangling ${reference.$1}.${reference.$2}', () async {
        await seedSource();
        final snapshot = await codec.export(source);
        ((snapshot[reference.$1] as List).single
                as Map<String, dynamic>)[reference.$2] =
            'missing';
        await expectLater(
          codec.validate(snapshot),
          throwsA(isA<CloudBackupException>()),
        );
      });
    }

    test('checks template-tag references and migraine parent type', () async {
      await seedSource();
      final snapshot = await codec.export(source)
        ..['templateTags'] = [
          {'templateId': 'missing', 'tagId': 'tag-1'},
        ];
      await expectLater(
        codec.validate(snapshot),
        throwsA(isA<CloudBackupException>()),
      );
      snapshot['templateTags'] = [
        {'templateId': 'template-1', 'tagId': 'missing'},
      ];
      await expectLater(
        codec.validate(snapshot),
        throwsA(isA<CloudBackupException>()),
      );
      snapshot['templateTags'] = <Object>[];
      ((snapshot['symptoms'] as List).single as Map<String, dynamic>)['type'] =
          SymptomType.pain.index;
      await expectLater(
        codec.validate(snapshot),
        throwsA(isA<CloudBackupException>()),
      );
    });

    test('invalid snapshots leave existing rows unchanged', () async {
      await seedSource();
      final before = await codec.export(source);
      final invalid = await codec.export(source)
        ..['formatVersion'] = 999;
      await expectLater(
        codec.restore(source, invalid, '/new/photos'),
        throwsA(isA<CloudBackupException>()),
      );
      expect(await codec.export(source), before);
    });

    test('uses portable basenames and rejects ambiguous photo collisions', () {
      expect(
        DatabaseSnapshotCodec.photoFileName(r'C:\old\device\meal.jpg'),
        'meal.jpg',
      );
      expect(
        () => codec.photoFileNamesIn({
          'meals': [
            {'photoPath': '/first/meal.jpg'},
          ],
          'mealTemplates': [
            {'defaultPhotoPath': '/second/meal.jpg'},
          ],
        }),
        throwsA(isA<CloudBackupException>()),
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
      expect(meal.photoPath, p.join('/new/device/meal_photos', 'meal.jpg'));

      final template = (await target.select(target.mealTemplates).get()).single;
      expect(
        template.defaultPhotoPath,
        p.join('/new/device/meal_photos', 'fav.jpg'),
      );

      final mealTag = (await target.select(target.mealTags).get()).single;
      expect(mealTag.mealId, 'meal-1');
      expect(mealTag.tagId, 'tag-1');

      final intake =
          (await target.select(target.medicationIntakes).get()).single;
      expect(intake.symptomId, 'symptom-1');

      final settings = (await target.select(target.appSettings).get()).single;
      expect(settings.onboardingDone, isTrue);

      final symptom = (await target.select(target.symptoms).get()).single;
      expect(symptom.startedAt?.toUtc(), DateTime.utc(2026, 7, 1, 9));
      expect(symptom.startPrecision, MigraineStartPrecision.exact);
      expect(symptom.endedAt?.toUtc(), DateTime.utc(2026, 7, 1, 11));
      expect(symptom.initialIntensity, 3);
      expect(symptom.maximumIntensity, 8);
      final observation =
          (await target.select(target.migraineIntensityMeasurements).get())
              .single;
      expect(observation.location, MigraineLocation.temple);
      expect(observation.aura, isFalse);
      expect(observation.nausea, isTrue);
    });

    test('restores a version 1 symptom without episode fields', () async {
      await seedSource();
      final snapshot = await codec.export(source)
        ..['formatVersion'] = 1
        ..remove('migraineIntensityMeasurements');
      ((snapshot['symptoms'] as List).single as Map<String, dynamic>)
        ..remove('startedAt')
        ..remove('startPrecision')
        ..remove('endedAt')
        ..remove('initialIntensity')
        ..remove('maximumIntensity')
        ..remove('dailyDate')
        ..remove('isDailyNote');

      final target = AppDatabase(NativeDatabase.memory());
      addTearDown(target.close);
      await codec.restore(target, snapshot, '/new/device/meal_photos');

      final restored = (await target.select(target.symptoms).get()).single;
      expect(restored.id, 'symptom-1');
      expect(restored.startedAt, isNull);
      expect(restored.initialIntensity, isNull);
      final measurement =
          (await target.select(target.migraineIntensityMeasurements).get())
              .single;
      expect(measurement.intensity, 3);
    });

    test('wipes pre-existing local rows not present in the snapshot', () async {
      await seedSource();
      final snapshot = await codec.export(source);

      final target = AppDatabase(NativeDatabase.memory());
      addTearDown(target.close);
      await target
          .into(target.tags)
          .insert(
            TagsCompanion.insert(id: 'stale-tag', label: 'stale'),
          );

      await codec.restore(target, snapshot, '/new/device/meal_photos');

      final tags = await target.select(target.tags).get();
      expect(tags.any((tag) => tag.id == 'stale-tag'), isFalse);
    });
  });
}
