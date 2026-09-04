@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/symptom_entry/data/symptom_entry_repository.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_entry_repository.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftSymptomEntryRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftSymptomEntryRepository(db: db);
  });

  tearDown(() => db.close());

  group('saveSymptom', () {
    test('inserts the symptom with detail, end time and note', () async {
      final timestamp = DateTime(2026, 7, 7, 9, 30);
      final endTime = DateTime(2026, 7, 7, 11);

      await repository.saveSymptom(
        timestamp: timestamp,
        type: SymptomType.migraine,
        intensity: 7,
        detail: 'aura',
        endTime: endTime,
        note: 'après le café',
      );

      final symptoms = await db.symptomsDao
          .watchByDay(DateTime(2026, 7, 7))
          .first;
      final saved = symptoms.single;
      expect(saved.type, SymptomType.migraine);
      expect(saved.intensity, 7);
      // Drift reads datetimes back as local; compare the instant.
      expect(saved.timestamp.toUtc(), timestamp.toUtc());
      expect(saved.endTime?.toUtc(), endTime.toUtc());
      expect(saved.startedAt?.toUtc(), timestamp.toUtc());
      expect(saved.startPrecision, MigraineStartPrecision.approximate);
      expect(saved.endedAt?.toUtc(), endTime.toUtc());
      expect(saved.initialIntensity, 7);
      expect(saved.maximumIntensity, isNull);
      expect(saved.detail, 'aura');
      expect(saved.note, 'après le café');
    });

    test(
      'stores explicit migraine episode fields and mirrors legacy fields',
      () async {
        final loggedAt = DateTime(2026, 7, 7, 12);
        final startedAt = DateTime(2026, 7, 7, 9, 15);
        final endedAt = DateTime(2026, 7, 7, 11, 45);

        await repository.saveSymptom(
          timestamp: loggedAt,
          type: SymptomType.migraine,
          intensity: 4,
          startedAt: startedAt,
          startPrecision: MigraineStartPrecision.exact,
          endedAt: endedAt,
          initialIntensity: 3,
          maximumIntensity: 8,
        );

        final saved = (await db.select(db.symptoms).get()).single;
        expect(saved.startedAt?.toUtc(), startedAt.toUtc());
        expect(saved.startPrecision, MigraineStartPrecision.exact);
        expect(saved.endedAt?.toUtc(), endedAt.toUtc());
        expect(saved.initialIntensity, 3);
        expect(saved.maximumIntensity, 8);
        expect(saved.timestamp.toUtc(), startedAt.toUtc());
        expect(saved.endTime?.toUtc(), endedAt.toUtc());
        expect(saved.intensity, 3);
      },
    );

    test('rejects an end before the migraine start', () async {
      await expectLater(
        repository.saveSymptom(
          timestamp: DateTime(2026, 7, 7, 9),
          type: SymptomType.migraine,
          intensity: 5,
          endedAt: DateTime(2026, 7, 7, 8, 59),
        ),
        throwsArgumentError,
      );
    });

    test('rejects a maximum below the initial intensity', () async {
      await expectLater(
        repository.saveSymptom(
          timestamp: DateTime(2026, 7, 7, 9),
          type: SymptomType.migraine,
          intensity: 5,
          initialIntensity: 7,
          maximumIntensity: 6,
        ),
        throwsArgumentError,
      );
    });

    test(
      'saves without detail, end time or note (empty stored as null)',
      () async {
        await repository.saveSymptom(
          timestamp: DateTime(2026, 7, 7, 8),
          type: SymptomType.digestive,
          intensity: 3,
          detail: '',
          note: '',
        );

        final symptoms = await db.symptomsDao
            .watchByDay(DateTime(2026, 7, 7))
            .first;
        final saved = symptoms.single;
        expect(saved.detail, isNull);
        expect(saved.endTime, isNull);
        expect(saved.note, isNull);
      },
    );

    test('stores daily feelings without intensity or medical time', () async {
      final day = DateTime(2026, 7, 7);
      await repository.saveSymptom(
        timestamp: day,
        type: SymptomType.eczema,
        note: 'plaques sur le bras',
        dailyDate: day,
        isDailyNote: true,
      );
      await repository.saveSymptom(
        timestamp: day,
        type: SymptomType.eczema,
        note: 'démangeaisons',
        dailyDate: day,
        isDailyNote: true,
      );

      final rows = await db.symptomsDao.watchDailyNotes(day).first;
      expect(rows, hasLength(2));
      expect(rows.every((row) => row.intensity == null), isTrue);
      expect(rows.every((row) => row.dailyDate != null), isTrue);
    });

    test('allows only one new mood per day', () async {
      final day = DateTime(2026, 7, 7);
      await repository.saveSymptom(
        timestamp: day,
        type: SymptomType.mood,
        note: 'calme',
        dailyDate: day,
        isDailyNote: true,
      );

      await expectLater(
        repository.saveSymptom(
          timestamp: day,
          type: SymptomType.mood,
          note: 'fatigué',
          dailyDate: day,
          isDailyNote: true,
        ),
        throwsA(isA<DailyMoodExistsException>()),
      );
    });

    test(
      'creates one first measurement and rejects a second active migraine',
      () async {
        await repository.saveSymptom(
          timestamp: DateTime(2026, 7, 7, 9),
          type: SymptomType.migraine,
          intensity: 6,
        );
        final measurements = await db
            .select(db.migraineIntensityMeasurements)
            .get();
        expect(measurements.single.intensity, 6);

        await expectLater(
          repository.saveSymptom(
            timestamp: DateTime(2026, 7, 7, 10),
            type: SymptomType.migraine,
            intensity: 4,
          ),
          throwsA(isA<ActiveMigraineExistsException>()),
        );
      },
    );
  });

  group('loadSymptom', () {
    test('returns the symptom', () async {
      await repository.saveSymptom(
        timestamp: DateTime(2026, 7, 7, 9, 30),
        type: SymptomType.migraine,
        intensity: 7,
        detail: 'aura',
      );
      final id = (await db.symptomsDao.watchByDay(DateTime(2026, 7, 7)).first)
          .single
          .id;

      final draft = await repository.loadSymptom(id);

      expect(draft, isNotNull);
      expect(draft!.type, SymptomType.migraine);
      expect(draft.intensity, 7);
      expect(draft.detail, 'aura');
      expect(draft.startedAt?.toUtc(), DateTime(2026, 7, 7, 9, 30).toUtc());
      expect(draft.startPrecision, MigraineStartPrecision.approximate);
      expect(draft.initialIntensity, 7);
    });

    test('returns null for an unknown id', () async {
      expect(await repository.loadSymptom('missing'), isNull);
    });
  });

  group('updateSymptom', () {
    test('replaces the fields', () async {
      await repository.saveSymptom(
        timestamp: DateTime(2026, 7, 7, 9),
        type: SymptomType.migraine,
        intensity: 7,
      );
      final id = (await db.symptomsDao.watchByDay(DateTime(2026, 7, 7)).first)
          .single
          .id;

      await repository.updateSymptom(
        id: id,
        timestamp: DateTime(2026, 7, 7, 10),
        type: SymptomType.mood,
        intensity: 4,
        detail: 'abattu',
      );

      final draft = await repository.loadSymptom(id);
      expect(draft!.type, SymptomType.mood);
      expect(draft.intensity, 4);
      expect(draft.detail, 'abattu');
    });

    test('completes a migraine with its end and maximum intensity', () async {
      final id = await repository.saveSymptom(
        timestamp: DateTime(2026, 7, 7, 9),
        type: SymptomType.migraine,
        intensity: 4,
      );
      final endedAt = DateTime(2026, 7, 7, 13, 30);

      await repository.updateSymptom(
        id: id,
        timestamp: DateTime(2026, 7, 7, 9),
        type: SymptomType.migraine,
        startedAt: DateTime(2026, 7, 7, 9),
        startPrecision: MigraineStartPrecision.exact,
        endedAt: endedAt,
        initialIntensity: 4,
        maximumIntensity: 9,
      );

      final draft = await repository.loadSymptom(id);
      expect(draft?.endedAt?.toUtc(), endedAt.toUtc());
      expect(draft?.endTime?.toUtc(), endedAt.toUtc());
      expect(draft?.maximumIntensity, 9);
    });
  });

  group('deleteSymptom / undoDeleteSymptom', () {
    test('soft-deletes then restores the symptom', () async {
      await repository.saveSymptom(
        timestamp: DateTime(2026, 7, 7, 9),
        type: SymptomType.migraine,
        intensity: 7,
      );
      final id = (await db.symptomsDao.watchByDay(DateTime(2026, 7, 7)).first)
          .single
          .id;

      await repository.deleteSymptom(id);
      expect(
        await db.symptomsDao.watchByDay(DateTime(2026, 7, 7)).first,
        isEmpty,
      );

      await repository.undoDeleteSymptom(id);
      expect(
        await db.symptomsDao.watchByDay(DateTime(2026, 7, 7)).first,
        hasLength(1),
      );
    });

    test('does not delete a medication linked to the migraine', () async {
      final symptomId = await repository.saveSymptom(
        timestamp: DateTime(2026, 7, 7, 9),
        type: SymptomType.migraine,
        intensity: 7,
      );
      await db.medicationIntakesDao.insertIntake(
        MedicationIntakesCompanion.insert(
          id: 'medication',
          timestamp: DateTime.utc(2026, 7, 7, 9, 30),
          name: 'Sumatriptan',
          symptomId: Value(symptomId),
        ),
      );

      await repository.deleteSymptom(symptomId);

      final medication = await db.medicationIntakesDao.getIntakeById(
        'medication',
      );
      expect(medication?.deletedAt, isNull);
      expect(medication?.symptomId, symptomId);
    });
  });
}
