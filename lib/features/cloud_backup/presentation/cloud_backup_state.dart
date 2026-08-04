import 'package:freezed_annotation/freezed_annotation.dart';

part 'cloud_backup_state.freezed.dart';

/// UI state for the cloud backup screen (US-26).
@freezed
abstract class CloudBackupState with _$CloudBackupState {
  /// Creates a [CloudBackupState].
  const factory CloudBackupState({
    /// Email of the signed-in Google account, or `null` if signed out.
    String? signedInEmail,

    /// Whether a sign-in/out, backup, or restore is currently running.
    @Default(false) bool isBusy,
  }) = _CloudBackupState;
}

/// Outcome of a restore attempt.
enum RestoreOutcome {
  /// The local database and photos were replaced by the backup.
  success,

  /// No backup exists for the signed-in account.
  notFound,

  /// The restore failed (network, auth, or an unexpected error).
  failure,
}
