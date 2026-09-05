@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/migraine_laterality.dart';
import 'package:assiette/data/db/enums/migraine_location.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/symptom_entry/data/migraine_observation_repository.dart';
import 'package:assiette/features/symptom_entry/domain/migraine_observation.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftMigraineObservationRepository repository;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftMigraineObservationRepository(db);
    await db.symptomsDao.insertSymptom(
      SymptomsCompanion.insert(
        id: 'migraine',
        timestamp: DateTime.utc(2026, 9, 5, 8),
        type: SymptomType.migraine,
        intensity: const Value(5),
        initialIntensity: const Value(5),
      ),
    );
  });

  tearDown(() => db.close());

  test('stores structured states including confirmed absence', () async {
    await repository.addObservation(
      'migraine',
      MigraineObservationInput(
        timestamp: DateTime.utc(2026, 9, 5, 9),
        intensity: 0,
        laterality: MigraineLaterality.left,
        location: MigraineLocation.temple,
        aura: false,
        nausea: true,
        note: '  after breakfast  ',
      ),
    );

    final observation =
        (await repository.watchObservations('migraine').first).single;
    expect(observation.intensity, 0);
    expect(observation.laterality, MigraineLaterality.left);
    expect(observation.location, MigraineLocation.temple);
    expect(observation.aura, isFalse);
    expect(observation.nausea, isTrue);
    expect(observation.photophobia, isNull);
    expect(observation.note, 'after breakfast');
  });

  test(
    'editing one observation preserves the others and recomputes max',
    () async {
      final firstId = await repository.addObservation(
        'migraine',
        MigraineObservationInput(
          timestamp: DateTime.utc(2026, 9, 5, 9),
          intensity: 4,
        ),
      );
      await repository.addObservation(
        'migraine',
        MigraineObservationInput(
          timestamp: DateTime.utc(2026, 9, 5, 10),
          intensity: 8,
          aura: true,
        ),
      );

      await repository.updateObservation(
        firstId,
        MigraineObservationInput(
          timestamp: DateTime.utc(2026, 9, 5, 9, 30),
          intensity: 9,
          aura: false,
        ),
      );

      final observations = await repository.watchObservations('migraine').first;
      expect(observations, hasLength(2));
      expect(observations.first.intensity, 9);
      expect(observations.first.aura, isFalse);
      expect(observations.last.intensity, 8);
      expect(observations.last.aura, isTrue);
      final migraine = await db.symptomsDao.getSymptomById('migraine');
      expect(migraine?.initialIntensity, 9);
      expect(migraine?.maximumIntensity, 9);
    },
  );

  test('soft-delete and undo only affect the selected observation', () async {
    final firstId = await repository.addObservation(
      'migraine',
      MigraineObservationInput(
        timestamp: DateTime.utc(2026, 9, 5, 9),
        intensity: 7,
      ),
    );
    await repository.addObservation(
      'migraine',
      MigraineObservationInput(
        timestamp: DateTime.utc(2026, 9, 5, 10),
        intensity: 3,
      ),
    );

    await repository.deleteObservation(firstId);
    var observations = await repository.watchObservations('migraine').first;
    expect(observations.map((item) => item.intensity), [3]);
    expect(
      (await db.symptomsDao.getSymptomById('migraine'))?.maximumIntensity,
      3,
    );

    await repository.undoDeleteObservation(firstId);
    observations = await repository.watchObservations('migraine').first;
    expect(observations.map((item) => item.intensity), [7, 3]);
  });

  test('rejects intensity outside 0 to 10', () async {
    expect(
      () => repository.addObservation(
        'migraine',
        MigraineObservationInput(
          timestamp: DateTime.utc(2026, 9, 5, 9),
          intensity: 11,
        ),
      ),
      throwsArgumentError,
    );
  });
}
