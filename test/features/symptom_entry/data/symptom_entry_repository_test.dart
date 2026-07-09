@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/symptom_entry/data/symptom_entry_repository.dart';
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

      final symptoms =
          await db.symptomsDao.watchByDay(DateTime(2026, 7, 7)).first;
      final saved = symptoms.single;
      expect(saved.type, SymptomType.migraine);
      expect(saved.intensity, 7);
      // Drift reads datetimes back as local; compare the instant.
      expect(saved.timestamp.toUtc(), timestamp.toUtc());
      expect(saved.endTime?.toUtc(), endTime.toUtc());
      expect(saved.detail, 'aura');
      expect(saved.note, 'après le café');
    });

    test('saves without detail, end time or note (empty stored as null)',
        () async {
      await repository.saveSymptom(
        timestamp: DateTime(2026, 7, 7, 8),
        type: SymptomType.digestive,
        intensity: 3,
        detail: '',
        note: '',
      );

      final symptoms =
          await db.symptomsDao.watchByDay(DateTime(2026, 7, 7)).first;
      final saved = symptoms.single;
      expect(saved.detail, isNull);
      expect(saved.endTime, isNull);
      expect(saved.note, isNull);
    });
  });
}
