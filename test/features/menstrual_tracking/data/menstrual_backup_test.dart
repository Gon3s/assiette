import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/cloud_backup/data/database_snapshot_codec.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_exception.dart';
import 'package:assiette/features/menstrual_tracking/data/drift_menstrual_tracking_repository.dart';
import 'package:assiette/features/menstrual_tracking/domain/menstrual_observation.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftMenstrualTrackingRepository repository;
  const codec = DatabaseSnapshotCodec();
  const observation = MenstrualObservation(
    localDate: '2026-10-01',
    status: BleedingStatus.period,
    flow: MenstrualFlow.light,
    isPeriodStart: true,
  );

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftMenstrualTrackingRepository(db);
    await repository.setPreferences(const MenstrualPreferences(enabled: true));
    await repository.save(observation);
  });
  tearDown(() => db.close());

  test(
    'backup excludes observations by default, inclusion round-trips',
    () async {
      expect((await codec.export(db))['menstrualDays'], isEmpty);
      await repository.setPreferences(
        const MenstrualPreferences(
          enabled: true,
          includeInBackup: true,
        ),
      );
      final snapshot = await codec.export(db);
      expect(snapshot['formatVersion'], 7);
      expect(snapshot['menstrualDays'], hasLength(1));
      await repository.purge();
      await codec.restore(db, snapshot, 'photos');
      expect(
        await repository.watchDay(observation.localDate).first,
        observation,
      );
      expect((await repository.getPreferences()).includeInBackup, isTrue);
    },
  );

  for (final version in [1, 2, 3, 4, 5]) {
    test(
      'v$version restoration clears observations and new preferences',
      () async {
        final snapshot = await codec.export(db)
          ..['formatVersion'] = version
          ..remove('menstrualDays');
        await repository.setPreferences(
          const MenstrualPreferences(
            enabled: true,
            includeInBackup: true,
            includeInPdf: true,
          ),
        );
        await codec.restore(db, snapshot, 'photos');
        expect(await db.select(db.menstrualDays).get(), isEmpty);
        expect(await repository.getPreferences(), const MenstrualPreferences());
      },
    );
  }

  test('an excluded snapshot replaces menstrual rows too', () async {
    final snapshot = await codec.export(db);
    await codec.restore(db, snapshot, 'photos');
    expect(await db.select(db.menstrualDays).get(), isEmpty);
  });

  test(
    'invalid dates, codes, duplicates and combinations leave local rows intact',
    () async {
      await repository.setPreferences(
        const MenstrualPreferences(
          enabled: true,
          includeInBackup: true,
        ),
      );
      for (final mutate in <void Function(List<dynamic>)>[
        (rows) =>
            (rows.single as Map<String, dynamic>)['localDate'] = '2026-02-30',
        (rows) =>
            (rows.single as Map<String, dynamic>)['bleedingStatus'] = 'invalid',
        (rows) => (rows.single as Map<String, dynamic>)['flow'] = 'invalid',
        (rows) =>
            (rows.single as Map<String, dynamic>)['bleedingStatus'] = 'none',
        (rows) => rows.add(rows.single),
      ]) {
        final before = await codec.export(db);
        final invalid = await codec.export(db);
        mutate(invalid['menstrualDays'] as List);
        await expectLater(
          codec.restore(db, invalid, 'photos'),
          throwsA(isA<CloudBackupException>()),
        );
        expect(await codec.export(db), before);
      }
    },
  );
}
