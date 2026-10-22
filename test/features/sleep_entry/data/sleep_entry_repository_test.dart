@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/sleep_entry/data/sleep_entry_repository.dart';
import 'package:drift/drift.dart' show Value;
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

    test('allows missing quality and trims an optional note', () async {
      await repository.saveSleepEntry(day: day, note: '  Woke up twice  ');
      final saved = await db.sleepEntriesDao.watchByDate(day).first;
      expect(saved?.quality, isNull);
      expect(saved?.note, 'Woke up twice');

      await repository.saveSleepEntry(day: day, note: '   ');
      expect((await db.sleepEntriesDao.watchByDate(day).first)?.note, isNull);
    });
  });

  group('sleep shortcuts', () {
    test(
      'starting a night records only bedtime without inventing quality',
      () async {
        final bedtime = DateTime(2026, 7, 7, 23, 15);
        expect(await repository.startNight(bedtime), day);

        final entry = (await db.select(db.sleepEntries).get()).single;
        expect(entry.nightDate.toUtc(), DateTime.utc(2026, 7, 7));
        expect(entry.bedTime?.toUtc(), bedtime.toUtc());
        expect(entry.wakeTime, isNull);
        expect(entry.quality, isNull);
      },
    );

    test('a repeated start after midnight keeps the original night', () async {
      final bedtime = DateTime(2026, 7, 7, 23, 15);
      await repository.startNight(bedtime);
      final first = (await db.select(db.sleepEntries).get()).single;

      final night = await repository.startNight(DateTime(2026, 7, 8, 0, 10));
      final entry = (await db.select(db.sleepEntries).get()).single;
      expect(night, day);
      expect(entry.id, first.id);
      expect(entry.bedTime, first.bedTime);
    });

    test(
      'waking closes the previous night and preserves its details',
      () async {
        final bedtime = DateTime(2026, 7, 7, 23, 15);
        final wakeTime = DateTime(2026, 7, 8, 7, 20);
        await repository.saveSleepEntry(
          day: day,
          bedTime: bedtime,
          quality: 2,
          note: 'Restless',
        );
        final first = (await db.select(db.sleepEntries).get()).single;

        expect(await repository.recordWake(wakeTime), day);
        final entry = (await db.select(db.sleepEntries).get()).single;
        expect(entry.id, first.id);
        expect(entry.bedTime, first.bedTime);
        expect(entry.wakeTime?.toUtc(), wakeTime.toUtc());
        expect(entry.quality, 2);
        expect(entry.note, 'Restless');
        expect(await db.sleepEntriesDao.getOpenEntry(), isNull);
      },
    );

    test(
      'waking without bedtime creates one entry and is idempotent',
      () async {
        final wakeTime = DateTime(2026, 7, 8, 7, 20);
        expect(await repository.recordWake(wakeTime), DateTime(2026, 7, 8));
        final first = (await db.select(db.sleepEntries).get()).single;
        expect(first.bedTime, isNull);
        expect(first.quality, isNull);
        expect(first.wakeTime?.toUtc(), wakeTime.toUtc());

        await repository.recordWake(wakeTime.add(const Duration(minutes: 5)));
        final second = (await db.select(db.sleepEntries).get()).single;
        expect(second.id, first.id);
        expect(second.wakeTime, first.wakeTime);
      },
    );

    test('waking preserves an existing note without bedtime', () async {
      await repository.saveSleepEntry(day: day, quality: 3, note: 'A note');
      final first = (await db.select(db.sleepEntries).get()).single;

      await repository.recordWake(DateTime(2026, 7, 7, 7));
      final entry = (await db.select(db.sleepEntries).get()).single;
      expect(entry.id, first.id);
      expect(entry.quality, 3);
      expect(entry.note, 'A note');
    });

    test('updating a legacy local date key keeps the same entry', () async {
      final legacyKey = day.toUtc();
      final now = DateTime.now().toUtc();
      await db.sleepEntriesDao.upsertSleepEntry(
        SleepEntriesCompanion.insert(
          id: 'legacy-night',
          nightDate: legacyKey,
          quality: const Value(2),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );

      await repository.startNight(DateTime(2026, 7, 7, 23));
      await repository.recordWake(DateTime(2026, 7, 8, 7));
      final entry = (await db.select(db.sleepEntries).get()).single;
      expect(entry.id, 'legacy-night');
      expect(entry.nightDate.toUtc(), legacyKey);
      expect(entry.quality, 2);
      expect(entry.bedTime, isNotNull);
      expect(entry.wakeTime, isNotNull);
    });

    test(
      'a timezone change preserves the stored night date without duplicates',
      () async {
        final bedtimeInCurrentZone = DateTime(2026, 7, 6, 23);
        await db.sleepEntriesDao.upsertSleepEntry(
          SleepEntriesCompanion.insert(
            id: 'travelling-night',
            nightDate: DateTime.utc(2026, 7, 7),
            bedTime: Value(bedtimeInCurrentZone.toUtc()),
          ),
        );

        final night = await repository.recordWake(DateTime(2026, 7, 7, 8));

        expect(night, day);
        expect(
          await db.sleepEntriesDao.watchByDate(DateTime(2026, 7, 6)).first,
          isNull,
        );
        final entry = await db.sleepEntriesDao.watchByDate(day).first;
        expect(entry?.id, 'travelling-night');
        expect(entry?.bedTime?.toUtc(), bedtimeInCurrentZone.toUtc());
        expect(entry?.wakeTime, isNotNull);
        expect(await db.select(db.sleepEntries).get(), hasLength(1));
      },
    );
  });
}
