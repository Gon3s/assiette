import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/menstrual_tracking/data/drift_menstrual_tracking_repository.dart';
import 'package:assiette/features/menstrual_tracking/domain/menstrual_observation.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftMenstrualTrackingRepository repository;
  const observation = MenstrualObservation(
    localDate: '2026-10-25',
    status: BleedingStatus.period,
    isPeriodStart: true,
  );

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftMenstrualTrackingRepository(
      db,
      now: () => DateTime(2026, 10, 28),
    );
  });
  tearDown(() => db.close());

  test('preferences are opt-in and disabled tracking rejects writes', () async {
    expect(await repository.getPreferences(), const MenstrualPreferences());
    await expectLater(repository.save(observation), throwsStateError);
    expect(await repository.watchDay(observation.localDate).first, isNull);
  });

  test(
    'upsert, deletion and reactivation keep a unique date and creation time',
    () async {
      await repository.setPreferences(
        const MenstrualPreferences(enabled: true),
      );
      await repository.save(observation);
      final created =
          (await db.select(db.menstrualDays).get()).single.createdAt;
      await Future.wait([
        repository.save(observation.copyWith(flow: MenstrualFlow.heavy)),
        repository.save(observation.copyWith(note: '  observation  ')),
      ]);
      expect(await db.select(db.menstrualDays).get(), hasLength(1));
      final saved = await repository.watchDay(observation.localDate).first;
      expect(saved?.note, 'observation');
      expect(saved?.flow, isNull);
      await repository.delete(observation.localDate);
      expect(await repository.watchDay(observation.localDate).first, isNull);
      expect(await repository.getRange('2026-10-01', '2026-10-28'), isEmpty);
      await repository.save(
        observation.copyWith(
          status: BleedingStatus.none,
          isPeriodStart: false,
        ),
      );
      final row = (await db.select(db.menstrualDays).get()).single;
      expect(row.createdAt, created);
      expect(row.deletedAt, isNull);
      expect(row.bleedingStatus, 'none');
    },
  );

  test('gaps stay unknown, spotting does not create a period start', () async {
    await repository.setPreferences(const MenstrualPreferences(enabled: true));
    await repository.save(observation);
    await repository.save(
      observation.copyWith(
        localDate: '2026-10-27',
        status: BleedingStatus.spotting,
        isPeriodStart: false,
      ),
    );
    expect(await repository.watchDay('2026-10-26').first, isNull);
    final rows = await repository.getRange('2026-10-25', '2026-10-27');
    expect(rows.map((row) => row.localDate), ['2026-10-25', '2026-10-27']);
    expect(rows.last.isPeriodStart, isFalse);
    await repository.setPreferences(const MenstrualPreferences());
    expect(await repository.getRange('2026-10-25', '2026-10-27'), hasLength(2));
  });

  test(
    'invalid dates, future days and incompatible states are rejected',
    () async {
      await repository.setPreferences(
        const MenstrualPreferences(enabled: true),
      );
      for (final invalid in [
        observation.copyWith(localDate: '2026-02-30'),
        observation.copyWith(localDate: '2026-2-01'),
        observation.copyWith(localDate: '2026-10-29'),
        observation.copyWith(status: BleedingStatus.spotting),
        observation.copyWith(
          status: BleedingStatus.none,
          isPeriodStart: false,
          flow: MenstrualFlow.light,
        ),
        observation.copyWith(note: 'x' * 2001),
      ]) {
        await expectLater(repository.save(invalid), throwsFormatException);
      }
      expect(await db.select(db.menstrualDays).get(), isEmpty);
    },
  );

  test('civil dates survive leap years and daylight-saving boundaries', () {
    for (final key in [
      '2024-02-29',
      '2026-03-29',
      '2026-10-25',
      '2026-12-31',
    ]) {
      expect(menstrualDateKey(parseMenstrualDate(key)), key);
    }
    expect(menstrualDateKey(DateTime.utc(2026, 10, 25, 23)), '2026-10-25');
    expect(() => parseMenstrualDate('2025-02-29'), throwsFormatException);
  });

  test('permanent purge resets only menstrual data and preferences', () async {
    await db
        .into(db.tags)
        .insert(TagsCompanion.insert(id: 'tag', label: 'test'));
    await db.appSettingsDao.setOnboardingDone(done: true);
    await repository.setPreferences(
      const MenstrualPreferences(
        enabled: true,
        includeInBackup: true,
        includeInPdf: true,
      ),
    );
    await repository.save(observation);
    await repository.delete(observation.localDate);
    await repository.purge();
    expect(await db.select(db.menstrualDays).get(), isEmpty);
    expect(await repository.getPreferences(), const MenstrualPreferences());
    expect(await db.tagsDao.watchAll().first, hasLength(1));
    expect(await db.appSettingsDao.watchOnboardingDone().first, isTrue);
  });
}
