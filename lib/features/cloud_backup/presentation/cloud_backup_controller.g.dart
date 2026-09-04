// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_backup_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Drives Google sign-in/out and the backup/restore actions for the cloud
/// backup screen (US-26).

@ProviderFor(CloudBackupController)
final cloudBackupControllerProvider = CloudBackupControllerProvider._();

/// Drives Google sign-in/out and the backup/restore actions for the cloud
/// backup screen (US-26).
final class CloudBackupControllerProvider
    extends $AsyncNotifierProvider<CloudBackupController, CloudBackupState> {
  /// Drives Google sign-in/out and the backup/restore actions for the cloud
  /// backup screen (US-26).
  CloudBackupControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cloudBackupControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cloudBackupControllerHash();

  @$internal
  @override
  CloudBackupController create() => CloudBackupController();
}

String _$cloudBackupControllerHash() =>
    r'790c45146eebbf00f2018b3fc8b4d58c26970f81';

/// Drives Google sign-in/out and the backup/restore actions for the cloud
/// backup screen (US-26).

abstract class _$CloudBackupController
    extends $AsyncNotifier<CloudBackupState> {
  FutureOr<CloudBackupState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CloudBackupState>, CloudBackupState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CloudBackupState>, CloudBackupState>,
              AsyncValue<CloudBackupState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
