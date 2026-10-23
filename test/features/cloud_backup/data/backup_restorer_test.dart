import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/cloud_backup/data/backup_archive_codec.dart';
import 'package:assiette/features/cloud_backup/data/backup_restorer.dart';
import 'package:assiette/features/cloud_backup/data/database_snapshot_codec.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_exception.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

class _FailingCodec extends DatabaseSnapshotCodec {
  const _FailingCodec();

  @override
  Future<void> restore(
    AppDatabase db,
    Map<String, dynamic> snapshot,
    String photosDirPath,
  ) async {
    await super.restore(db, snapshot, photosDirPath);
    throw StateError('Simulated transaction failure after rows were replaced');
  }
}

void main() {
  const codec = DatabaseSnapshotCodec();
  const restorer = BackupRestorer();
  late AppDatabase db;
  late Directory documents;
  late Directory photos;
  late File original;
  late Map<String, dynamic> snapshot;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    documents = await Directory.systemTemp.createTemp('assiette-backup-test-');
    photos = await Directory(p.join(documents.path, 'meal_photos')).create();
    original = await File(
      p.join(photos.path, 'meal.jpg'),
    ).writeAsBytes([1, 2, 3]);
    await db
        .into(db.meals)
        .insert(
          MealsCompanion.insert(
            id: 'local-meal',
            timestamp: DateTime.utc(2026),
            mealType: MealType.lunch,
            photoPath: Value(original.path),
            note: const Value('original'),
          ),
        );
    snapshot = await codec.export(db);
    final meal = (snapshot['meals'] as List).single as Map<String, dynamic>;
    meal['note'] = 'restored';
    meal['photoPath'] = '/old/device/meal.jpg';
  });

  tearDown(() async {
    await db.close();
    await documents.delete(recursive: true);
  });

  Uint8List zip({bool includePhoto = true, bool extraPhoto = false}) {
    final archive = Archive()
      ..addFile(ArchiveFile.string('database.json', jsonEncode(snapshot)));
    if (includePhoto) {
      archive.addFile(ArchiveFile.bytes('photos/meal.jpg', [7, 8, 9]));
    }
    if (extraPhoto) {
      archive.addFile(ArchiveFile.bytes('photos/extra.jpg', [10]));
    }
    return ZipEncoder().encodeBytes(archive);
  }

  Future<void> expectUnchanged() async {
    final meal = (await db.select(db.meals).get()).single;
    expect(meal.note, 'original');
    expect(meal.photoPath, original.path);
    expect(await original.readAsBytes(), [1, 2, 3]);
    expect(await photos.list().toList(), hasLength(1));
    expect(await documents.list().toList(), hasLength(1));
    expect(await db.select(db.cloudBackupStates).get(), isEmpty);
  }

  test(
    'publishes new files and atomically commits their paths and restore flag',
    () async {
      await restorer.restore(db, zip(), photos);
      final meal = (await db.select(db.meals).get()).single;
      expect(meal.note, 'restored');
      expect(meal.photoPath, isNot(original.path));
      expect(p.isWithin(photos.path, meal.photoPath!), isTrue);
      expect(await File(meal.photoPath!).readAsBytes(), [7, 8, 9]);
      expect(await original.readAsBytes(), [1, 2, 3]);
      expect(
        (await db.select(db.cloudBackupStates).get())
            .single
            .hasRestoredOnThisDevice,
        isTrue,
      );
      expect(await documents.list().toList(), hasLength(1));

      // A subsequent backup must read the newly published subdirectory.
      final exported = await codec.export(db);
      final reencoded = await const BackupArchiveCodec().encode(exported);
      final decoded = await const BackupArchiveCodec().decode(reencoded);
      expect(decoded.photos['meal.jpg'], [7, 8, 9]);
    },
  );

  test(
    'rolls back rows and removes newly published files on transaction failure',
    () async {
      const failing = BackupRestorer(snapshotCodec: _FailingCodec());
      await expectLater(
        failing.restore(db, zip(), photos),
        throwsA(isA<CloudBackupException>()),
      );
      await expectUnchanged();
    },
  );

  test(
    'a failure updating the restore flag also rolls back imported rows',
    () async {
      await db.customStatement(
        'CREATE TRIGGER reject_restore BEFORE INSERT ON cloud_backup_states '
        "BEGIN SELECT RAISE(ABORT, 'simulated restore flag failure'); END",
      );
      await expectLater(
        restorer.restore(db, zip(), photos),
        throwsA(isA<CloudBackupException>()),
      );
      await expectUnchanged();
    },
  );

  for (final incompatible in [false, true]) {
    test(
      'rejects ${incompatible ? 'incompatible versions' : 'invalid references'} before publishing files',
      () async {
        if (incompatible) {
          snapshot['formatVersion'] = 999;
        } else {
          snapshot['mealTags'] = [
            {'mealId': 'missing', 'tagId': 'missing'},
          ];
        }
        await expectLater(
          restorer.restore(db, zip(), photos),
          throwsA(isA<CloudBackupException>()),
        );
        await expectUnchanged();
      },
    );
  }

  test(
    'rejects missing and unreferenced photos without changing local data',
    () async {
      for (final bytes in [zip(includePhoto: false), zip(extraPhoto: true)]) {
        await expectLater(
          restorer.restore(db, bytes, photos),
          throwsA(isA<CloudBackupException>()),
        );
        await expectUnchanged();
      }
    },
  );

  test('filesystem publication failure preserves local data', () async {
    final blocked = await File(
      p.join(documents.path, 'blocked'),
    ).writeAsString('keep');
    await expectLater(
      restorer.restore(db, zip(), Directory(blocked.path)),
      throwsA(isA<CloudBackupException>()),
    );
    expect((await db.select(db.meals).get()).single.note, 'original');
    expect(await original.readAsBytes(), [1, 2, 3]);
    expect(await blocked.readAsString(), 'keep');
    expect(await documents.list().toList(), hasLength(2));
  });

  test('backup creation refuses missing or oversized photos', () async {
    final exported = await codec.export(db);
    const small = BackupArchiveCodec(
      limits: BackupArchiveLimits(photoBytes: 2),
    );
    await expectLater(
      small.encode(exported),
      throwsA(isA<CloudBackupException>()),
    );
    await original.delete();
    await expectLater(
      const BackupArchiveCodec().encode(exported),
      throwsA(isA<CloudBackupException>()),
    );
  });
}
