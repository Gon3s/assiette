@Timeout(Duration(seconds: 5))
library;

import 'dart:async';

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/migraine_history/data/drift_migraine_history_repository.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftMigraineHistoryRepository repository;
  final recent = DateTime.utc(2026, 10, 27, 9);
  final old = DateTime.utc(2020, 1, 2, 8);

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftMigraineHistoryRepository(symptomsDao: db.symptomsDao);
  });

  tearDown(() => db.close());

  test(
    'loads all years with only active migraines and linked intakes',
    () async {
      await db.symptomsDao.insertSymptom(
        SymptomsCompanion.insert(
          id: 'old',
          timestamp: old,
          type: SymptomType.migraine,
          startedAt: Value(old),
          startPrecision: const Value(MigraineStartPrecision.approximate),
          endedAt: Value(old.add(const Duration(hours: 2))),
          intensity: const Value(4),
          detail: const Value('historical detail'),
          note: const Value('historical note'),
        ),
      );
      await _insertMigraine(db, 'recent', recent);
      await _insertMigraine(db, 'deleted', recent);
      await db.symptomsDao.softDeleteSymptom('deleted');
      await db.symptomsDao.insertSymptom(
        SymptomsCompanion.insert(
          id: 'mood',
          timestamp: recent,
          type: SymptomType.mood,
        ),
      );
      await _insertIntake(db, 'later', old.add(const Duration(days: 1)), 'old');
      await _insertIntake(db, 'earlier', old, 'old', dose: '500 mg');
      await _insertIntake(db, 'deleted-intake', old, 'old');
      await db.medicationIntakesDao.softDeleteIntake('deleted-intake');
      await _insertIntake(db, 'isolated', recent, null);
      await _insertIntake(db, 'for-deleted', recent, 'deleted');
      await _insertIntake(db, 'for-mood', recent, 'mood');

      final entries = await repository.watchHistory().first;

      expect(entries.map((entry) => entry.migraine.id), ['recent', 'old']);
      expect(entries.first.intakes, isEmpty);
      expect(entries.first.migraine.startedAt, isNull);
      expect(
        entries.first.migraine.startPrecision,
        MigraineStartPrecision.unknown,
      );
      final historical = entries.last;
      expect(historical.intakes.map((intake) => intake.id), [
        'earlier',
        'later',
      ]);
      expect(historical.intakes.first.dose, '500 mg');
      expect(historical.migraine.startedAt?.toUtc(), old);
      expect(
        historical.migraine.startPrecision,
        MigraineStartPrecision.approximate,
      );
      expect(
        historical.migraine.endedAt?.toUtc(),
        old.add(const Duration(hours: 2)),
      );
      expect(historical.migraine.detail, 'historical detail');
      expect(historical.migraine.note, 'historical note');
    },
  );

  test(
    'reacts to migraine and intake additions, edits and deletions',
    () async {
      final history = StreamIterator(repository.watchHistory());
      addTearDown(history.cancel);
      await history.moveNext();
      expect(history.current, isEmpty);

      await _insertMigraine(db, 'migraine', recent);
      await history.moveNext();
      expect(history.current.single.migraine.id, 'migraine');

      await _insertIntake(db, 'intake', recent, 'migraine');
      await history.moveNext();
      expect(history.current.single.intakes.single.name, 'Medication');

      await db.medicationIntakesDao.updateIntake(
        'intake',
        const MedicationIntakesCompanion(dose: Value('1 tablet')),
      );
      await history.moveNext();
      expect(history.current.single.intakes.single.dose, '1 tablet');

      final end = recent.add(const Duration(hours: 1));
      await db.symptomsDao.updateSymptom(
        'migraine',
        SymptomsCompanion(endedAt: Value(end)),
      );
      await history.moveNext();
      expect(history.current.single.migraine.endedAt?.toUtc(), end);

      await db.medicationIntakesDao.softDeleteIntake('intake');
      await history.moveNext();
      expect(history.current.single.intakes, isEmpty);

      await db.symptomsDao.softDeleteSymptom('migraine');
      await history.moveNext();
      expect(history.current, isEmpty);
    },
  );
}

Future<void> _insertMigraine(AppDatabase db, String id, DateTime timestamp) =>
    db.symptomsDao.insertSymptom(
      SymptomsCompanion.insert(
        id: id,
        timestamp: timestamp,
        type: SymptomType.migraine,
        startPrecision: const Value(MigraineStartPrecision.unknown),
        intensity: const Value(5),
      ),
    );

Future<void> _insertIntake(
  AppDatabase db,
  String id,
  DateTime timestamp,
  String? symptomId, {
  String? dose,
}) => db.medicationIntakesDao.insertIntake(
  MedicationIntakesCompanion.insert(
    id: id,
    timestamp: timestamp,
    name: 'Medication',
    dose: Value(dose),
    symptomId: Value(symptomId),
  ),
);
