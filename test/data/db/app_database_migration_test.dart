@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'v13 adds optional menstrual tracking without changing existing settings',
    () async {
      final db = AppDatabase(
        NativeDatabase.memory(
          setup: (database) {
            database
              ..execute(_legacyTagSchema)
              ..execute(
                'INSERT INTO app_settings (id, onboarding_done, breakfast_hour) VALUES (0, 1, 9)',
              )
              ..execute(
                "INSERT INTO tags (id, label, created_at, updated_at) VALUES ('kept', 'custom', 1, 1)",
              )
              ..execute('PRAGMA user_version = 13');
          },
        ),
      );
      addTearDown(db.close);
      final settings = (await db.select(db.appSettings).get()).single;
      expect(settings.onboardingDone, isTrue);
      expect(settings.breakfastHour, 9);
      expect(settings.quickFavoriteId, isNull);
      expect(await db.select(db.coffeeIntakes).get(), isEmpty);
      expect(settings.menstrualTrackingEnabled, isFalse);
      expect(settings.menstrualBackupEnabled, isFalse);
      expect(settings.menstrualPdfEnabled, isFalse);
      expect(await db.select(db.menstrualDays).get(), isEmpty);
      expect((await db.select(db.tags).get()).single.id, 'kept');
    },
  );
  test(
    'v8 migration preserves every legacy health entry through v15',
    () async {
      final executor = NativeDatabase.memory(
        setup: (database) {
          database
            ..execute(_legacyTagSchema)
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
            ..execute(_legacySleepSchema)
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
      expect(measurements.single.aura, isNull);
      expect(measurements.single.deletedAt, isNull);

      final medication = (await db.select(db.medicationIntakes).get()).single;
      expect(medication.symptomId, 'legacy-migraine');
      expect(medication.dose, '50 mg');

      final version = await db.customSelect('PRAGMA user_version').getSingle();
      expect(version.read<int>('user_version'), 15);
    },
  );

  test('v10 migration preserves existing intensity measurements', () async {
    final executor = NativeDatabase.memory(
      setup: (database) {
        database
          ..execute(_legacyTagSchema)
          ..execute('''
CREATE TABLE migraine_intensity_measurements (
  id TEXT NOT NULL PRIMARY KEY,
  symptom_id TEXT NOT NULL,
  timestamp INTEGER NOT NULL,
  intensity INTEGER NOT NULL,
  created_at INTEGER NOT NULL
)
''')
          ..execute('''
INSERT INTO migraine_intensity_measurements (
  id, symptom_id, timestamp, intensity, created_at
) VALUES (
  'measurement-1', 'migraine-1', unixepoch('2026-09-05 09:00:00'), 6,
  unixepoch('2026-09-05 09:01:00')
)
''')
          ..execute(_legacySleepSchema)
          ..execute('PRAGMA user_version = 10');
      },
    );
    final db = AppDatabase(executor);
    addTearDown(db.close);

    final measurement =
        (await db.select(db.migraineIntensityMeasurements).get()).single;

    expect(measurement.id, 'measurement-1');
    expect(measurement.intensity, 6);
    expect(measurement.laterality, isNull);
    expect(measurement.aura, isNull);
    expect(measurement.updatedAt, isNotNull);
    expect(measurement.deletedAt, isNull);
  });

  test(
    'v12 preserves sleep entries and allows optional quality and notes',
    () async {
      final executor = NativeDatabase.memory(
        setup: (database) {
          database
            ..execute(_legacyTagSchema)
            ..execute(_legacySleepSchema)
            ..execute('''
INSERT INTO sleep_entries (
  id, night_date, quality, bed_time, wake_time, source, created_at, updated_at
) VALUES (
  'legacy-sleep', unixepoch('2026-07-07 00:00:00'), 3,
  unixepoch('2026-07-07 23:00:00'), unixepoch('2026-07-08 07:00:00'),
  'manual', unixepoch('2026-07-07 23:00:00'), unixepoch('2026-07-08 07:00:00')
)
''')
            ..execute('PRAGMA user_version = 11');
        },
      );
      final db = AppDatabase(executor);
      addTearDown(db.close);

      final original = (await db.select(db.sleepEntries).get()).single;
      expect(original.id, 'legacy-sleep');
      expect(original.nightDate.toUtc(), DateTime.utc(2026, 7, 7));
      expect(original.quality, 3);
      expect(original.bedTime?.toUtc(), DateTime.utc(2026, 7, 7, 23));
      expect(original.wakeTime?.toUtc(), DateTime.utc(2026, 7, 8, 7));
      expect(original.note, isNull);
      expect(original.source, 'manual');
      expect(original.createdAt.toUtc(), DateTime.utc(2026, 7, 7, 23));
      expect(original.updatedAt.toUtc(), DateTime.utc(2026, 7, 8, 7));
      expect(original.deletedAt, isNull);

      await db.customStatement(
        'UPDATE sleep_entries SET quality = NULL, note = ? WHERE id = ?',
        ['Restful night', original.id],
      );
      final updated = (await db.select(db.sleepEntries).get()).single;
      expect(updated.quality, isNull);
      expect(updated.note, 'Restful night');
      expect(updated.bedTime, original.bedTime);
      expect(updated.wakeTime, original.wakeTime);
    },
  );

  test('v13 retires only untouched and unused system tags', () async {
    final db = AppDatabase(
      NativeDatabase.memory(
        setup: (database) {
          database
            ..execute(_legacyTagSchema)
            ..execute('''
INSERT INTO tags (id, label, is_system, created_at, updated_at, deleted_at)
VALUES
  ('unused', 'coffee', 1, 100, 100, NULL),
  ('meal', 'milk', 1, 100, 100, NULL),
  ('favorite', 'wheat', 1, 100, 100, NULL),
  ('renamed', 'my tag', 1, 100, 200, NULL),
  ('custom', 'egg', 0, 100, 100, NULL),
  ('deleted', 'cheese', 1, 100, 200, 200);
INSERT INTO meal_tags VALUES ('meal-1', 'meal');
INSERT INTO template_tags VALUES ('favorite-1', 'favorite');
PRAGMA user_version = 12;
''');
        },
      ),
    );
    addTearDown(db.close);

    final active = await db.tagsDao.watchAll().first;
    expect(
      active.map((tag) => tag.id),
      unorderedEquals(['meal', 'favorite', 'renamed', 'custom']),
    );
    final all = await db.select(db.tags).get();
    final retired = all.singleWhere((tag) => tag.id == 'unused');
    expect(retired.deletedAt, isNotNull);
    expect(retired.updatedAt, retired.deletedAt);
    expect(
      all.singleWhere((tag) => tag.id == 'deleted').deletedAt,
      DateTime.fromMillisecondsSinceEpoch(200000),
    );
    expect((await db.select(db.mealTags).get()).single.tagId, 'meal');
    expect((await db.select(db.templateTags).get()).single.tagId, 'favorite');
  });
}

const _legacyTagSchema = '''
CREATE TABLE app_settings (
  id INTEGER NOT NULL PRIMARY KEY,
  onboarding_done INTEGER NOT NULL DEFAULT 0,
  last_pressure_alert_date INTEGER NULL,
  reminders_meals_enabled INTEGER NOT NULL DEFAULT 1,
  breakfast_hour INTEGER NOT NULL DEFAULT 8,
  breakfast_minute INTEGER NOT NULL DEFAULT 30,
  lunch_hour INTEGER NOT NULL DEFAULT 12,
  lunch_minute INTEGER NOT NULL DEFAULT 30,
  dinner_hour INTEGER NOT NULL DEFAULT 19,
  dinner_minute INTEGER NOT NULL DEFAULT 30,
  reminders_sleep_enabled INTEGER NOT NULL DEFAULT 1,
  sleep_hour INTEGER NOT NULL DEFAULT 8,
  sleep_minute INTEGER NOT NULL DEFAULT 0,
  reminders_weather_enabled INTEGER NOT NULL DEFAULT 1,
  reminders_symptoms_enabled INTEGER NOT NULL DEFAULT 0,
  symptoms_hour INTEGER NOT NULL DEFAULT 20,
  symptoms_minute INTEGER NOT NULL DEFAULT 0,
  photo_tag_suggestions_enabled INTEGER NOT NULL DEFAULT 1
);
CREATE TABLE tags (
  id TEXT NOT NULL PRIMARY KEY,
  label TEXT NOT NULL,
  category TEXT NULL,
  is_system INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  deleted_at INTEGER NULL
);
CREATE TABLE meal_tags (meal_id TEXT NOT NULL, tag_id TEXT NOT NULL);
CREATE TABLE template_tags (template_id TEXT NOT NULL, tag_id TEXT NOT NULL);
''';

const _legacySleepSchema = '''
CREATE TABLE sleep_entries (
  id TEXT NOT NULL PRIMARY KEY,
  night_date INTEGER NOT NULL UNIQUE,
  quality INTEGER NOT NULL,
  bed_time INTEGER NULL,
  wake_time INTEGER NULL,
  source TEXT NOT NULL DEFAULT 'manual',
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  deleted_at INTEGER NULL
)
''';
