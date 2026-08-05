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
    // Silent sign-in restores a previous session but must never crash the
    // screen if it fails (missing account, Credential Manager error...) —
    // fall back to signed-out and let the user tap "Sign in" instead.
    try {
      final email = await ref
          .read(cloudBackupRepositoryProvider)
          .signInSilently();
      return CloudBackupState(signedInEmail: email);
    } on CloudBackupException {
      return const CloudBackupState();
    }
  }

  /// Shows the Google account picker. Returns `null` on success, or a
  /// diagnostic (non-localized) message if cancelled or sign-in failed.
  Future<String?> signIn() async {
    final current = state.value ?? const CloudBackupState();
    state = AsyncData(current.copyWith(isBusy: true));
    try {
      final email = await ref.read(cloudBackupRepositoryProvider).signIn();
      state = AsyncData(CloudBackupState(signedInEmail: email));
      return null;
    } on CloudBackupException catch (e) {
      state = AsyncData(current.copyWith(isBusy: false));
      return e.message;
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
