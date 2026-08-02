import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_exception.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_repository.dart';
import 'package:assiette/features/cloud_backup/presentation/cloud_backup_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cloud_backup_controller.g.dart';

/// Drives Google sign-in/out and the backup/restore actions for the cloud
/// backup screen (US-26).
@riverpod
class CloudBackupController extends _$CloudBackupController {
  @override
  Future<CloudBackupState> build() async {
    final email = await ref.read(cloudBackupRepositoryProvider).signInSilently();
    return CloudBackupState(signedInEmail: email);
  }

  /// Shows the Google account picker. Returns `false` if cancelled or
  /// sign-in failed.
  Future<bool> signIn() async {
    final current = state.value ?? const CloudBackupState();
    state = AsyncData(current.copyWith(isBusy: true));
    try {
      final email = await ref.read(cloudBackupRepositoryProvider).signIn();
      state = AsyncData(CloudBackupState(signedInEmail: email));
      return true;
    } on CloudBackupException {
      state = AsyncData(current.copyWith(isBusy: false));
      return false;
    }
  }

  /// Signs out of the Google account.
  Future<void> signOut() async {
    final current = state.value ?? const CloudBackupState();
    state = AsyncData(current.copyWith(isBusy: true));
    await ref.read(cloudBackupRepositoryProvider).signOut();
    state = const AsyncData(CloudBackupState());
  }

  /// Uploads a fresh snapshot to Drive. Returns `false` on failure — local
  /// data is never touched by a backup, so nothing to roll back.
  Future<bool> backupNow() async {
    final current = state.value ?? const CloudBackupState();
    state = AsyncData(current.copyWith(isBusy: true));
    try {
      await ref.read(cloudBackupRepositoryProvider).backupNow();
      return true;
    } on CloudBackupException {
      return false;
    } finally {
      state = AsyncData(
        (state.value ?? current).copyWith(isBusy: false),
      );
    }
  }

  /// Downloads the latest backup and replaces local data with it.
  Future<RestoreOutcome> restoreLatest() async {
    final current = state.value ?? const CloudBackupState();
    state = AsyncData(current.copyWith(isBusy: true));
    try {
      await ref.read(cloudBackupRepositoryProvider).restoreLatest();
      return RestoreOutcome.success;
    } on CloudBackupException catch (e) {
      return e.isNotFound ? RestoreOutcome.notFound : RestoreOutcome.failure;
    } finally {
      state = AsyncData(
        (state.value ?? current).copyWith(isBusy: false),
      );
      await ref.read(appDatabaseProvider).cloudBackupStateDao
          .setHasRestoredOnThisDevice(value: true);
    }
  }

  /// Marks the startup restore offer as handled without restoring, so it
  /// doesn't come back up on the next launch.
  Future<void> dismissRestoreOffer() => ref
      .read(appDatabaseProvider)
      .cloudBackupStateDao
      .setHasRestoredOnThisDevice(value: true);
}
