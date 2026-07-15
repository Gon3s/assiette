@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/sleep_entry/data/sleep_entry_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftSleepEntryRepository repository;

  final day = DateTime(2026, 7, 7);

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftSleepEntryRepository(db: db);
  });

  tearDown(() => db.close());

  group('saveSleepEntry', () {
    test('inserts the sleep entry with bed and wake time', () async {
      final bedTime = DateTime(2026, 7, 7, 23);
      final wakeTime = DateTime(2026, 7, 8, 7);

      await repository.saveSleepEntry(
        day: day,
        quality: 3,
        bedTime: bedTime,
        wakeTime: wakeTime,
      );

      final saved = await db.sleepEntriesDao.watchByDate(day).first;
      expect(saved?.quality, 3);
      expect(saved?.bedTime?.toUtc(), bedTime.toUtc());
      expect(saved?.wakeTime?.toUtc(), wakeTime.toUtc());
    });

    test('saves without bed or wake time', () async {
      await repository.saveSleepEntry(day: day, quality: 1);

      final saved = await db.sleepEntriesDao.watchByDate(day).first;
      expect(saved?.quality, 1);
      expect(saved?.bedTime, isNull);
      expect(saved?.wakeTime, isNull);
    });

    test('updates the same night (upsert) keeping the same row', () async {
      await repository.saveSleepEntry(day: day, quality: 1);
      final first = await db.sleepEntriesDao.watchByDate(day).first;

      await repository.saveSleepEntry(
        day: day,
        quality: 3,
        bedTime: DateTime(2026, 7, 7, 22),
      );
      final updated = await db.sleepEntriesDao.watchByDate(day).first;

      expect(updated?.id, first?.id);
      expect(updated?.quality, 3);
      expect(updated?.bedTime, isNotNull);
    });
  });
}
