@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/migraine_stats/data/drift_migraine_stats_repository.dart';
import 'package:assiette/features/migraine_stats/domain/migraine_stats.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftMigraineStatsRepository repository;

  final now = DateTime(2026, 7, 30, 12);
  DateTime at(int day, int hour) => DateTime(2026, 7, day, hour).toUtc();

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftMigraineStatsRepository(
      symptomsDao: db.symptomsDao,
      medicationIntakesDao: db.medicationIntakesDao,
    );
  });

  tearDown(() => db.close());

  group('load', () {
    test('aggregates migraine frequency, duration and intensity', () async {
      await _insertMigraine(
        db,
        id: 'migraine-1',
        timestamp: at(2, 8),
        startedAt: at(2, 8),
        endedAt: at(2, 12),
        maximumIntensity: 8,
      );
      await _insertMigraine(
        db,
        id: 'migraine-2',
        timestamp: at(2, 10),
        startedAt: at(2, 10),
        endedAt: at(2, 12),
        maximumIntensity: 6,
      );
      await _insertMigraine(
        db,
        id: 'migraine-3',
        timestamp: at(20, 9),
        intensity: 4,
      );
      await db.symptomsDao.insertSymptom(
        SymptomsCompanion.insert(
          id: 'not-a-migraine',
          timestamp: at(4, 9),
          type: SymptomType.digestive,
        ),
      );

      final stats = await repository.load(
        MigraineStatsPeriod.thirtyDays,
        now,
      );

      expect(stats.migraineCount, 3);
      expect(stats.migraineDays, 2);
      expect(stats.averageDuration, const Duration(hours: 3));
      expect(stats.averageMaximumIntensity, 6);
      expect(stats.frequency.fold<int>(0, (sum, item) => sum + item.count), 3);
    });

    test('groups treatment names and calculates linked intake delay', () async {
      await _insertMigraine(
        db,
        id: 'migraine-1',
        timestamp: at(2, 8),
        startedAt: at(2, 8),
        endedAt: at(2, 12),
        maximumIntensity: 8,
      );
      await _insertMigraine(
        db,
        id: 'migraine-2',
        timestamp: at(10, 9),
        startedAt: at(10, 9),
        endedAt: at(10, 11),
        maximumIntensity: 5,
      );
      await _insertMedication(
        db,
        id: 'intake-1',
        timestamp: at(2, 9),
        name: 'Ibuprofène',
        symptomId: 'migraine-1',
      );
      await _insertMedication(
        db,
        id: 'intake-2',
        timestamp: at(10, 11),
        name: 'ibuprofène',
        symptomId: 'migraine-2',
      );
      await _insertMedication(
        db,
        id: 'intake-3',
        timestamp: at(20, 14),
        name: 'Paracétamol',
      );

      final stats = await repository.load(
        MigraineStatsPeriod.thirtyDays,
        now,
      );

      expect(stats.medicationIntakeCount, 3);
      expect(stats.medicationDays, 3);
      expect(stats.medications, hasLength(2));
      final ibuprofen = stats.medications.first;
      expect(ibuprofen.name, 'Ibuprofène');
      expect(ibuprofen.intakeCount, 2);
      expect(ibuprofen.linkedMigraineCount, 2);
      expect(
        ibuprofen.averageDelayAfterMigraineStart,
        const Duration(minutes: 90),
      );
    });

    test(
      'returns an empty snapshot when the period contains no data',
      () async {
        final stats = await repository.load(
          MigraineStatsPeriod.thirtyDays,
          now,
        );

        expect(stats.migraineCount, 0);
        expect(stats.medicationIntakeCount, 0);
        expect(stats.averageDuration, isNull);
        expect(stats.averageMaximumIntensity, isNull);
        expect(stats.medications, isEmpty);
      },
    );
  });
}

Future<void> _insertMigraine(
  AppDatabase db, {
  required String id,
  required DateTime timestamp,
  DateTime? startedAt,
  DateTime? endedAt,
  int? intensity,
  int? maximumIntensity,
}) => db.symptomsDao.insertSymptom(
  SymptomsCompanion.insert(
    id: id,
    timestamp: timestamp,
    type: SymptomType.migraine,
    startedAt: Value(startedAt),
    endedAt: Value(endedAt),
    intensity: Value(intensity),
    maximumIntensity: Value(maximumIntensity),
  ),
);

Future<void> _insertMedication(
  AppDatabase db, {
  required String id,
  required DateTime timestamp,
  required String name,
  String? symptomId,
}) => db.medicationIntakesDao.insertIntake(
  MedicationIntakesCompanion.insert(
    id: id,
    timestamp: timestamp,
    name: name,
    symptomId: Value(symptomId),
  ),
);
