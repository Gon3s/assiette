@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/medication_entry/data/medication_entry_repository.dart';
import 'package:assiette/features/symptom_entry/data/symptom_entry_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftMedicationEntryRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftMedicationEntryRepository(db: db);
  });

  tearDown(() => db.close());

  group('saveIntake / loadIntakesForSymptom', () {
    test('round-trips an intake linked to a symptom', () async {
      await repository.saveIntake(
        timestamp: DateTime.utc(2026, 7, 19, 10),
        name: '  Bi-Profenid ',
        dose: ' 100 mg ',
        symptomId: 'symptom-1',
      );

      final intakes = await repository.loadIntakesForSymptom('symptom-1');
      expect(intakes, hasLength(1));
      expect(intakes.first.name, 'Bi-Profenid');
      expect(intakes.first.dose, '100 mg');
      expect(intakes.first.symptomId, 'symptom-1');
      // Drift returns local DateTimes; compare in UTC.
      expect(intakes.first.timestamp.toUtc(), DateTime.utc(2026, 7, 19, 10));
    });

    test('stores an empty dose as null', () async {
      await repository.saveIntake(
        timestamp: DateTime.utc(2026, 7, 19, 10),
        name: 'Sumatriptan',
        dose: '  ',
        symptomId: 'symptom-1',
      );

      final intakes = await repository.loadIntakesForSymptom('symptom-1');
      expect(intakes.single.dose, isNull);
    });

    test('supports intakes without a symptom (standalone)', () async {
      await repository.saveIntake(
        timestamp: DateTime.utc(2026, 7, 19, 8),
        name: 'Doliprane',
      );

      final rows = await db.medicationIntakesDao.getRange(
        DateTime.utc(2026, 7, 19),
        DateTime.utc(2026, 7, 20),
      );
      expect(rows.single.symptomId, isNull);
    });
  });

  group('recentNames', () {
    test('returns distinct names, most recently used first', () async {
      await repository.saveIntake(
        timestamp: DateTime.utc(2026, 7, 17, 9),
        name: 'Bi-Profenid',
      );
      await repository.saveIntake(
        timestamp: DateTime.utc(2026, 7, 18, 9),
        name: 'Sumatriptan',
      );
      await repository.saveIntake(
        timestamp: DateTime.utc(2026, 7, 19, 9),
        name: 'Bi-Profenid',
      );

      final names = await repository.recentNames();
      expect(names, ['Bi-Profenid', 'Sumatriptan']);
    });

    test('ignores soft-deleted intakes', () async {
      await repository.saveIntake(
        timestamp: DateTime.utc(2026, 7, 19, 9),
        name: 'Doliprane',
        symptomId: 'symptom-1',
      );
      final intake =
          (await repository.loadIntakesForSymptom('symptom-1')).single;
      await repository.deleteIntake(intake.id!);

      expect(await repository.recentNames(), isEmpty);
    });
  });

  group('deleteIntake / undoDeleteIntake', () {
    test('soft-deletes then restores', () async {
      await repository.saveIntake(
        timestamp: DateTime.utc(2026, 7, 19, 10),
        name: 'Bi-Profenid',
        symptomId: 'symptom-1',
      );
      final intake =
          (await repository.loadIntakesForSymptom('symptom-1')).single;

      await repository.deleteIntake(intake.id!);
      expect(await repository.loadIntakesForSymptom('symptom-1'), isEmpty);

      await repository.undoDeleteIntake(intake.id!);
      expect(
        await repository.loadIntakesForSymptom('symptom-1'),
        hasLength(1),
      );
    });
  });

  group('symptom delete cascade', () {
    test('deleting a symptom hides its intakes; undo restores them',
        () async {
      final symptomRepository = DriftSymptomEntryRepository(db: db);
      final symptomId = await symptomRepository.saveSymptom(
        timestamp: DateTime.utc(2026, 7, 19, 9),
        type: SymptomType.migraine,
        intensity: 7,
      );
      await repository.saveIntake(
        timestamp: DateTime.utc(2026, 7, 19, 10),
        name: 'Sumatriptan',
        symptomId: symptomId,
      );

      await symptomRepository.deleteSymptom(symptomId);
      expect(await repository.loadIntakesForSymptom(symptomId), isEmpty);

      await symptomRepository.undoDeleteSymptom(symptomId);
      expect(
        await repository.loadIntakesForSymptom(symptomId),
        hasLength(1),
      );
    });
  });
}
