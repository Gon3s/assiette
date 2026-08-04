import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/cloud_backup/data/google_drive_backup_repository.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cloud_backup_repository.g.dart';

/// Google Drive-backed backup/restore for the whole local database plus
/// photos (US-26). One backup per account, always fully overwritten on both
/// sides — no history, no merge.
abstract class CloudBackupRepository {
  /// Attempts to restore a previous session without showing any UI. Returns
  /// the account email if one is signed in, or `null` otherwise. Safe to
  /// call repeatedly (e.g. to read current status for display).
  Future<String?> signInSilently();

  /// Shows the Google account picker and signs in. Returns the account
  /// email. Throws [CloudBackupException] if the user cancels or sign-in
  /// fails.
  Future<String> signIn();

  /// Signs out of the Google account.
  Future<void> signOut();

  /// Whether a backup file exists on Drive for the signed-in account.
  Future<bool> hasRemoteBackup();

  /// Serializes the local database and its referenced photos and uploads
  /// them to Drive, overwriting any previous backup for this account.
  /// Throws [CloudBackupException] on failure; local data is untouched
  /// either way.
  Future<void> backupNow();

  /// Downloads the latest backup and replaces the local database and
  /// photos with its contents. Throws [CloudBackupException] if there is no
  /// backup or on failure — the local database is only ever mutated inside
  /// a transaction, so a failure never leaves it partially restored.
  Future<void> restoreLatest();
}

/// Provides the [CloudBackupRepository] implementation.
@riverpod
CloudBackupRepository cloudBackupRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return GoogleDriveBackupRepository(db: db);
}

/// Whether the app should offer to restore a cloud backup right now: a
/// Google session restores silently, a backup exists for it, and this
/// device hasn't already been offered (or completed) a restore.
@riverpod
Future<bool> shouldOfferRestore(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);
  final alreadyHandled = await db.cloudBackupStateDao
      .getHasRestoredOnThisDevice();
  if (alreadyHandled) return false;

  final repository = ref.watch(cloudBackupRepositoryProvider);
  final email = await repository.signInSilently();
  if (email == null) return false;
  return repository.hasRemoteBackup();
}
