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
    final wakeDay = DateTime(2026, 7, 8);

    test(
      'starting a night records only bedtime without inventing quality',
      () async {
        final bedtime = DateTime(2026, 7, 7, 23, 15);
        expect(await repository.startNight(bedtime), wakeDay);

        final entry = (await db.select(db.sleepEntries).get()).single;
        expect(entry.nightDate.toUtc(), DateTime.utc(2026, 7, 8));
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
      expect(night, wakeDay);
      expect(entry.id, first.id);
      expect(entry.bedTime, first.bedTime);
    });

    test(
      'waking closes the previous night and preserves its details',
      () async {
        final bedtime = DateTime(2026, 7, 7, 23, 15);
        final wakeTime = DateTime(2026, 7, 8, 7, 20);
        await repository.saveSleepEntry(
          day: wakeDay,
          bedTime: bedtime,
          quality: 2,
          note: 'Restless',
        );
        final first = (await db.select(db.sleepEntries).get()).single;

        expect(await repository.recordWake(wakeTime), wakeDay);
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

      await repository.startNight(DateTime(2026, 7, 7, 1));
      await repository.recordWake(DateTime(2026, 7, 7, 7));
      final entry = (await db.select(db.sleepEntries).get()).single;
      expect(entry.id, 'legacy-night');
      expect(entry.nightDate.toUtc(), legacyKey);
      expect(entry.quality, 2);
      expect(entry.bedTime, isNotNull);
      expect(entry.wakeTime, isNotNull);
    });

    test(
      'two consecutive nights preserve the previous completed night',
      () async {
        await repository.saveSleepEntry(
          day: day,
          bedTime: DateTime(2026, 7, 6, 22),
          wakeTime: DateTime(2026, 7, 7, 7),
          quality: 3,
          note: 'Previous night',
        );
        final previous = await db.sleepEntriesDao.watchByDate(day).first;

        expect(await repository.startNight(DateTime(2026, 7, 7, 22)), wakeDay);
        expect(await repository.recordWake(DateTime(2026, 7, 8, 7)), wakeDay);
        await repository.startNight(DateTime(2026, 7, 8, 22));

        expect(await db.sleepEntriesDao.watchByDate(day).first, previous);
        final current = await db.sleepEntriesDao.watchByDate(wakeDay).first;
        expect(current?.bedTime?.toLocal(), DateTime(2026, 7, 7, 22));
        expect(current?.wakeTime?.toLocal(), DateTime(2026, 7, 8, 7));
        final next = await db.sleepEntriesDao
            .watchByDate(DateTime(2026, 7, 9))
            .first;
        expect(next?.bedTime?.toLocal(), DateTime(2026, 7, 8, 22));
        expect(await db.select(db.sleepEntries).get(), hasLength(3));
      },
    );

    test('a bedtime after midnight belongs to the current day', () async {
      expect(await repository.startNight(DateTime(2026, 7, 8, 1, 30)), wakeDay);
      expect(await repository.recordWake(DateTime(2026, 7, 8, 9)), wakeDay);
      expect(await db.select(db.sleepEntries).get(), hasLength(1));
    });

    test(
      'the noon boundary uses calendar dates at the end of a month',
      () async {
        expect(
          await repository.startNight(DateTime(2026, 12, 31, 12)),
          DateTime(2027),
        );
        final entry = (await db.select(db.sleepEntries).get()).single;
        expect(entry.nightDate.toUtc(), DateTime.utc(2027));
      },
    );

    test(
      'bedtime fills the target day without losing quality or note',
      () async {
        await repository.saveSleepEntry(
          day: wakeDay,
          quality: 2,
          note: 'Keep me',
        );
        await repository.startNight(DateTime(2026, 7, 7, 22));
        final before = await db.sleepEntriesDao.watchByDate(wakeDay).first;
        await repository.startNight(DateTime(2026, 7, 7, 22, 5));
        final after = await db.sleepEntriesDao.watchByDate(wakeDay).first;
        expect(after, before);
        expect(after?.quality, 2);
        expect(after?.note, 'Keep me');
        expect(after?.bedTime?.toLocal(), DateTime(2026, 7, 7, 22));
      },
    );

    test('an unfinished old night does not steal bedtime or wake', () async {
      await repository.saveSleepEntry(
        day: day,
        bedTime: DateTime(2026, 7, 3, 22),
        note: 'Old unfinished night',
      );
      final old = await db.sleepEntriesDao.watchByDate(day).first;
      await repository.startNight(DateTime(2026, 7, 7, 22));
      await repository.recordWake(DateTime(2026, 7, 8, 7));
      expect(await db.sleepEntriesDao.watchByDate(day).first, old);
      final current = await db.sleepEntriesDao.watchByDate(wakeDay).first;
      expect(current?.wakeTime?.toLocal(), DateTime(2026, 7, 8, 7));
    });

    test('wake alone ignores an open night older than 24 hours', () async {
      await repository.saveSleepEntry(
        day: day,
        bedTime: DateTime(2026, 7, 6, 22),
      );
      expect(await repository.recordWake(DateTime(2026, 7, 8, 7)), wakeDay);
      expect(
        (await db.sleepEntriesDao.watchByDate(day).first)?.wakeTime,
        isNull,
      );
      expect(
        (await db.sleepEntriesDao.watchByDate(wakeDay).first)?.wakeTime
            ?.toLocal(),
        DateTime(2026, 7, 8, 7),
      );
    });

    test(
      'a recent legacy night moves on wake when the target is empty',
      () async {
        await repository.saveSleepEntry(
          day: day,
          bedTime: DateTime(2026, 7, 7, 22),
          quality: 2,
          note: 'Legacy',
        );
        final old = await db.sleepEntriesDao.watchByDate(day).first;
        expect(await repository.recordWake(DateTime(2026, 7, 8, 7)), wakeDay);
        expect(await db.sleepEntriesDao.watchByDate(day).first, isNull);
        final saved = await db.sleepEntriesDao.watchByDate(wakeDay).first;
        expect(saved?.id, old?.id);
        expect(saved?.quality, 2);
        expect(saved?.note, 'Legacy');
        expect(saved?.bedTime, old?.bedTime);
        expect(saved?.wakeTime?.toLocal(), DateTime(2026, 7, 8, 7));
      },
    );

    test('a legacy night never overwrites an occupied destination', () async {
      await repository.saveSleepEntry(
        day: day,
        bedTime: DateTime(2026, 7, 7, 22),
      );
      await repository.saveSleepEntry(day: wakeDay, note: 'Existing target');
      final old = await db.sleepEntriesDao.watchByDate(day).first;
      expect(await repository.recordWake(DateTime(2026, 7, 8, 7)), wakeDay);
      expect(await db.sleepEntriesDao.watchByDate(day).first, old);
      final target = await db.sleepEntriesDao.watchByDate(wakeDay).first;
      expect(target?.note, 'Existing target');
      expect(target?.wakeTime?.toLocal(), DateTime(2026, 7, 8, 7));
    });

    test('a future bedtime cannot be closed by an earlier wake', () async {
      await repository.startNight(DateTime(2026, 7, 8, 1));
      await repository.recordWake(DateTime(2026, 7, 8, 0, 30));
      expect(
        (await db.sleepEntriesDao.watchByDate(wakeDay).first)?.wakeTime,
        isNull,
      );
    });

    test('repairing a legacy night preserves a deleted destination', () async {
      await repository.saveSleepEntry(
        day: day,
        bedTime: DateTime(2026, 7, 7, 22),
      );
      await repository.saveSleepEntry(day: wakeDay, note: 'Deleted target');
      final target = await db.sleepEntriesDao.watchByDate(wakeDay).first;
      await db.sleepEntriesDao.softDeleteSleepEntry(target!.id);

      await repository.recordWake(DateTime(2026, 7, 8, 7));
      final rows = await db.select(db.sleepEntries).get();
      expect(rows, hasLength(2));
      final deleted = rows.singleWhere((row) => row.id == target.id);
      expect(deleted.deletedAt, isNotNull);
      expect(deleted.note, 'Deleted target');
      expect(deleted.wakeTime, isNull);
    });

    test(
      'concurrent bedtime and wake taps keep one row and first hours',
      () async {
        final bedtime = DateTime(2026, 7, 7, 22);
        await Future.wait([
          repository.startNight(bedtime),
          repository.startNight(bedtime.add(const Duration(minutes: 1))),
        ]);
        final wake = DateTime(2026, 7, 8, 7);
        await Future.wait([
          repository.recordWake(wake),
          repository.recordWake(wake.add(const Duration(minutes: 1))),
        ]);
        final saved = (await db.select(db.sleepEntries).get()).single;
        expect(saved.bedTime?.toLocal(), bedtime);
        expect(saved.wakeTime?.toLocal(), wake);
      },
    );

    for (final bedtime in [
      DateTime(2026, 3, 28, 22),
      DateTime(2026, 10, 24, 22),
    ]) {
      test('calendar day survives the clock change after $bedtime', () async {
        final nextDay = DateTime(bedtime.year, bedtime.month, bedtime.day + 1);
        expect(await repository.startNight(bedtime.toUtc()), nextDay);
        final wake = DateTime(nextDay.year, nextDay.month, nextDay.day, 7);
        expect(await repository.recordWake(wake), nextDay);
        final saved = (await db.select(db.sleepEntries).get()).single;
        expect(
          saved.nightDate.toUtc(),
          DateTime.utc(nextDay.year, nextDay.month, nextDay.day),
        );
        expect(saved.wakeTime?.toLocal(), wake);
      });
    }

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
