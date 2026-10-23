import 'dart:io';
import 'dart:typed_data';

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/cloud_backup/data/backup_archive_codec.dart';
import 'package:assiette/features/cloud_backup/data/database_snapshot_codec.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_exception.dart';
import 'package:path/path.dart' as p;

/// Publishes into a fresh directory before committing any new photo references.
/// Old files stay intact, even if the process stops before SQLite commits.
class BackupRestorer {
  const BackupRestorer({
    this.archiveCodec = const BackupArchiveCodec(),
    this.snapshotCodec = const DatabaseSnapshotCodec(),
  });

  final BackupArchiveCodec archiveCodec;
  final DatabaseSnapshotCodec snapshotCodec;

  Future<void> restore(
    AppDatabase db,
    Uint8List bytes,
    Directory photos,
  ) async {
    Directory? workspace;
    Directory? published;
    var committed = false;
    try {
      final backup = await archiveCodec.decode(bytes);
      await snapshotCodec.validate(backup.snapshot);
      final expected = snapshotCodec.photoFileNamesIn(backup.snapshot);
      if (expected.length != backup.photos.length ||
          !expected.every(backup.photos.containsKey)) {
        throw CloudBackupException('Backup photo references are inconsistent');
      }
      workspace = await photos.parent.createTemp('.assiette-restore-');
      final staged = await Directory(p.join(workspace.path, 'photos')).create();
      for (final photo in backup.photos.entries) {
        await File(
          p.join(staged.path, photo.key),
        ).writeAsBytes(photo.value, flush: true);
      }
      await photos.create(recursive: true);
      // A unique namespace avoids overwriting files used by the current DB.
      // Interrupted restores can leave unused files, never broken old paths.
      published = await staged.rename(
        p.join(photos.path, p.basename(workspace.path)),
      );
      final publishedPath = published.path;
      await db.transaction(() async {
        await snapshotCodec.restore(db, backup.snapshot, publishedPath);
        await db.cloudBackupStateDao.setHasRestoredOnThisDevice(value: true);
      });
      committed = true;
    } on CloudBackupException {
      rethrow;
    } on Object {
      throw CloudBackupException('Backup restoration failed');
    } finally {
      if (!committed && published != null) {
        try {
          await published.delete(recursive: true);
        } on FileSystemException {
          // Only unreferenced files remain if best-effort cleanup fails.
        }
      }
      if (workspace != null) {
        try {
          await workspace.delete(recursive: true);
        } on FileSystemException {
          // A cleanup error must not turn a committed restore into a failure.
        }
      }
    }
  }
}
