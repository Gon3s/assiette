@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/pdf_export/data/journal_export_repository.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftJournalExportRepository repository;

  final day1 = DateTime(2026, 7);
  final day2 = DateTime(2026, 7, 2);
  final day3 = DateTime(2026, 7, 3);
  DateTime at(DateTime day, int hour) =>
      DateTime(day.year, day.month, day.day, hour).toUtc();

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftJournalExportRepository(
      mealsDao: db.mealsDao,
      symptomsDao: db.symptomsDao,
      medicationIntakesDao: db.medicationIntakesDao,
      sleepEntriesDao: db.sleepEntriesDao,
      environmentDao: db.environmentDao,
    );
  });

  tearDown(() => db.close());

  group('loadRange', () {
    test('aggregates meals, symptoms, sleep and weather per day', () async {
      final tag = await db.tagsDao.watchAll().first.then((t) => t.first);
      await db.mealsDao.insertMealWithTags(
        MealsCompanion.insert(
          id: 'meal-1',
          timestamp: at(day1, 12),
          mealType: MealType.lunch,
        ),
        [tag.id],
      );
      await db.symptomsDao.insertSymptom(
        SymptomsCompanion.insert(
          id: 'symptom-1',
          timestamp: at(day1, 9),
          type: SymptomType.migraine,
          intensity: const Value(7),
        ),
      );
      await db.sleepEntriesDao.upsertSleepEntry(
        SleepEntriesCompanion.insert(
          id: 'sleep-1',
          nightDate: DateTime(day1.year, day1.month, day1.day).toUtc(),
          quality: 2,
        ),
      );
      await db.environmentDao.insertSnapshot(
        EnvironmentSnapshotsCompanion.insert(
          id: 'env-1',
          timestamp: at(day1, 8),
          pressure: const Value(1013),
        ),
      );

      final entries = await repository.loadRange(day1, day1);

      expect(entries, hasLength(1));
      final entry = entries.single;
      expect(entry.meals.single.tagLabels, [tag.label]);
      expect(entry.symptoms.single.intensity, 7);
      expect(entry.sleep?.quality, 2);
      expect(entry.weather?.pressure, 1013);
    });

    test('skips days with nothing logged', () async {
      await db.symptomsDao.insertSymptom(
        SymptomsCompanion.insert(
          id: 'symptom-1',
          timestamp: at(day1, 9),
          type: SymptomType.mood,
          intensity: const Value(3),
        ),
      );

      final entries = await repository.loadRange(day1, day3);

      expect(entries, hasLength(1));
      expect(
        entries.single.date,
        DateTime(day1.year, day1.month, day1.day).toUtc(),
      );
    });

    test('excludes soft-deleted entries', () async {
      await db.mealsDao.insertMeal(
        MealsCompanion.insert(
          id: 'meal-1',
          timestamp: at(day1, 12),
          mealType: MealType.lunch,
        ),
      );
      await db.mealsDao.softDeleteMeal('meal-1');

      final entries = await repository.loadRange(day1, day1);

      expect(entries, isEmpty);
    });

    test('excludes entries outside the range', () async {
      await db.symptomsDao.insertSymptom(
        SymptomsCompanion.insert(
          id: 'symptom-1',
          timestamp: at(day2, 9),
          type: SymptomType.digestive,
          intensity: const Value(5),
        ),
      );

      final entries = await repository.loadRange(day1, day1);

      expect(entries, isEmpty);
    });
  });
}
