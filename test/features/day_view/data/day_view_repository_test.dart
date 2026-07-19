@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/day_view/data/day_view_repository.dart';
import 'package:assiette/features/day_view/domain/timeline_item.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftDayViewRepository repository;

  final day = DateTime(2026, 7, 6);
  DateTime at(int hour, [int minute = 0]) =>
      DateTime(2026, 7, 6, hour, minute).toUtc();

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftDayViewRepository(
      mealsDao: db.mealsDao,
      symptomsDao: db.symptomsDao,
      medicationIntakesDao: db.medicationIntakesDao,
      sleepEntriesDao: db.sleepEntriesDao,
      environmentDao: db.environmentDao,
    );
  });

  tearDown(() => db.close());

  Future<void> insertMeal(
    String id,
    DateTime timestamp, {
    List<String> tagIds = const [],
  }) async {
    await db.mealsDao.insertMeal(
      MealsCompanion.insert(
        id: id,
        timestamp: timestamp,
        mealType: MealType.lunch,
      ),
    );
    for (final tagId in tagIds) {
      await db.mealsDao.addTag(
        MealTagsCompanion.insert(mealId: id, tagId: tagId),
      );
    }
  }

  Future<void> insertSymptom(String id, DateTime timestamp) =>
      db.symptomsDao.insertSymptom(
        SymptomsCompanion.insert(
          id: id,
          timestamp: timestamp,
          type: SymptomType.migraine,
          intensity: 7,
        ),
      );

  group('watchTimeline', () {
    test('merges meals and symptoms sorted by timestamp', () async {
      await insertMeal('meal-1', at(12));
      await insertSymptom('symptom-1', at(9));

      final items = await repository.watchTimeline(day).first;

      expect(items, hasLength(2));
      expect(items[0], isA<SymptomTimelineItem>());
      expect(items[1], isA<MealTimelineItem>());
    });

    test('includes the meal tags', () async {
      final tag = await db.tagsDao.watchAll().first.then((t) => t.first);
      await insertMeal('meal-1', at(12), tagIds: [tag.id]);

      final items = await repository.watchTimeline(day).first;

      final meal = items.single as MealTimelineItem;
      expect(meal.tagLabels, [tag.label]);
    });

    test('excludes soft-deleted entries and other days', () async {
      await insertMeal('meal-deleted', at(12));
      await db.mealsDao.softDeleteMeal('meal-deleted');
      await insertSymptom('symptom-other-day', at(12).add(const Duration(days: 2)));

      final items = await repository.watchTimeline(day).first;

      expect(items, isEmpty);
    });

    test('re-emits when a new entry is inserted', () async {
      final emissions = <List<TimelineItem>>[];
      final sub = repository.watchTimeline(day).listen(emissions.add);
      addTearDown(sub.cancel);
      await pumpEventQueue();

      await insertSymptom('symptom-1', at(9));
      await pumpEventQueue();

      expect(emissions.first, isEmpty);
      expect(emissions.last, hasLength(1));
    });
  });

  group('logSleepQuality', () {
    test('inserts then updates the same night (upsert)', () async {
      await repository.logSleepQuality(day, 1);
      var summary = await repository.watchSleepForNight(day).first;
      expect(summary?.quality, 1);

      await repository.logSleepQuality(day, 3);
      summary = await repository.watchSleepForNight(day).first;
      expect(summary?.quality, 3);
    });

    test('returns null when the night is not logged', () async {
      final summary = await repository.watchSleepForNight(day).first;
      expect(summary, isNull);
    });

    test('exposes the entry id', () async {
      await repository.logSleepQuality(day, 2);
      final summary = await repository.watchSleepForNight(day).first;
      expect(summary?.id, isNotNull);
    });
  });

  group('deleteSleepEntry / undoDeleteSleepEntry', () {
    test('soft-deletes then restores the night', () async {
      await repository.logSleepQuality(day, 2);
      final id = (await repository.watchSleepForNight(day).first)!.id!;

      await repository.deleteSleepEntry(id);
      expect(await repository.watchSleepForNight(day).first, isNull);

      await repository.undoDeleteSleepEntry(id);
      expect(await repository.watchSleepForNight(day).first, isNotNull);
    });
  });

  group('watchLatestWeather', () {
    test('returns the most recent snapshot of the day', () async {
      await db.environmentDao.insertSnapshot(
        EnvironmentSnapshotsCompanion.insert(
          id: 'env-1',
          timestamp: at(8),
          pressure: const Value(1013),
        ),
      );
      await db.environmentDao.insertSnapshot(
        EnvironmentSnapshotsCompanion.insert(
          id: 'env-2',
          timestamp: at(14),
          pressure: const Value(1009),
          pressureDelta: const Value(-4),
        ),
      );

      final weather = await repository.watchLatestWeather(day).first;

      expect(weather?.pressure, 1009);
      expect(weather?.pressureDelta, -4);
    });

    test('returns null without snapshots', () async {
      final weather = await repository.watchLatestWeather(day).first;
      expect(weather, isNull);
    });
  });
}
