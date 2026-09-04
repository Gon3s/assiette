@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'v8 migration preserves every legacy health entry through v10',
    () async {
      final executor = NativeDatabase.memory(
        setup: (database) {
          database
            ..execute('''
CREATE TABLE symptoms (
  id TEXT NOT NULL PRIMARY KEY,
  timestamp INTEGER NOT NULL,
  type INTEGER NOT NULL,
  intensity INTEGER NOT NULL,
  detail TEXT NULL,
  end_time INTEGER NULL,
  note TEXT NULL,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  deleted_at INTEGER NULL
)
''')
            ..execute('''
INSERT INTO symptoms (
  id, timestamp, type, intensity, detail, end_time, note,
  created_at, updated_at, deleted_at
) VALUES (
  'legacy-migraine',
  unixepoch('2026-07-07 09:30:00'),
  0,
  7,
  'aura',
  unixepoch('2026-07-07 11:00:00'),
  'legacy note',
  unixepoch('2026-07-07 12:00:00'),
  unixepoch('2026-07-07 12:00:00'),
  NULL
)
''')
            ..execute('''
INSERT INTO symptoms (
  id, timestamp, type, intensity, detail, end_time, note,
  created_at, updated_at, deleted_at
) VALUES (
  'legacy-digestive',
  unixepoch('2026-07-08 08:00:00'),
  1,
  3,
  NULL,
  NULL,
  NULL,
  unixepoch('2026-07-08 08:05:00'),
  unixepoch('2026-07-08 08:05:00'),
  NULL
)
''')
            ..execute('''
INSERT INTO symptoms (
  id, timestamp, type, intensity, detail, end_time, note,
  created_at, updated_at, deleted_at
) VALUES
  ('legacy-mood-1', unixepoch('2026-07-08 09:00:00'), 2, 2, NULL, NULL,
   'fatigué', unixepoch('2026-07-08 09:00:00'), unixepoch('2026-07-08 09:00:00'), NULL),
  ('legacy-mood-2', unixepoch('2026-07-08 18:00:00'), 2, 7, NULL, NULL,
   'mieux', unixepoch('2026-07-08 18:00:00'), unixepoch('2026-07-08 18:00:00'), NULL),
  ('legacy-pain', unixepoch('2026-07-08 14:00:00'), 3, 5, 'dos', NULL,
   NULL, unixepoch('2026-07-08 14:00:00'), unixepoch('2026-07-08 14:00:00'), NULL)
''')
            ..execute('''
CREATE TABLE medication_intakes (
  id TEXT NOT NULL PRIMARY KEY,
  timestamp INTEGER NOT NULL,
  name TEXT NOT NULL,
  dose TEXT NULL,
  symptom_id TEXT NULL REFERENCES symptoms(id),
  note TEXT NULL,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  deleted_at INTEGER NULL
)
''')
            ..execute('''
INSERT INTO medication_intakes (
  id, timestamp, name, dose, symptom_id, note,
  created_at, updated_at, deleted_at
) VALUES (
  'legacy-medication', unixepoch('2026-07-07 09:45:00'), 'Sumatriptan',
  '50 mg', 'legacy-migraine', NULL, unixepoch('2026-07-07 09:45:00'),
  unixepoch('2026-07-07 09:45:00'), NULL
)
''')
            ..execute('PRAGMA user_version = 8');
        },
      );
      final db = AppDatabase(executor);
      addTearDown(db.close);

      final rows = await db.select(db.symptoms).get();
      final migraine = rows.singleWhere((row) => row.id == 'legacy-migraine');
      final digestive = rows.singleWhere((row) => row.id == 'legacy-digestive');

      expect(migraine.startedAt?.toUtc(), DateTime.utc(2026, 7, 7, 9, 30));
      expect(
        migraine.startPrecision,
        MigraineStartPrecision.approximate,
      );
      expect(migraine.endedAt?.toUtc(), DateTime.utc(2026, 7, 7, 11));
      expect(migraine.initialIntensity, 7);
      expect(migraine.maximumIntensity, isNull);
      expect(migraine.createdAt.toUtc(), DateTime.utc(2026, 7, 7, 12));
      expect(migraine.timestamp.toUtc(), DateTime.utc(2026, 7, 7, 9, 30));
      expect(migraine.intensity, 7);
      expect(migraine.detail, 'aura');
      expect(migraine.note, 'legacy note');

      expect(digestive.startedAt, isNull);
      expect(digestive.startPrecision, isNull);
      expect(digestive.initialIntensity, isNull);

      final dailyNotes = await db.symptomsDao
          .watchDailyNotes(DateTime(2026, 7, 8))
          .first;
      expect(
        dailyNotes.map((row) => row.id),
        containsAll([
          'legacy-digestive',
          'legacy-mood-1',
          'legacy-mood-2',
          'legacy-pain',
        ]),
      );
      expect(
        dailyNotes.where((row) => row.type == SymptomType.mood),
        hasLength(2),
      );
      expect(dailyNotes.every((row) => !row.isDailyNote), isTrue);

      final measurements = await db
          .select(db.migraineIntensityMeasurements)
          .get();
      expect(measurements, hasLength(1));
      expect(measurements.single.symptomId, 'legacy-migraine');
      expect(measurements.single.intensity, 7);

      final medication = (await db.select(db.medicationIntakes).get()).single;
      expect(medication.symptomId, 'legacy-migraine');
      expect(medication.dose, '50 mg');

      final version = await db.customSelect('PRAGMA user_version').getSingle();
      expect(version.read<int>('user_version'), 10);
    },
  );
}
