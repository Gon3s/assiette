// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_backup_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [CloudBackupRepository] implementation.

@ProviderFor(cloudBackupRepository)
final cloudBackupRepositoryProvider = CloudBackupRepositoryProvider._();

/// Provides the [CloudBackupRepository] implementation.

final class CloudBackupRepositoryProvider
    extends
        $FunctionalProvider<
          CloudBackupRepository,
          CloudBackupRepository,
          CloudBackupRepository
        >
    with $Provider<CloudBackupRepository> {
  /// Provides the [CloudBackupRepository] implementation.
  CloudBackupRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cloudBackupRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cloudBackupRepositoryHash();

  @$internal
  @override
  $ProviderElement<CloudBackupRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CloudBackupRepository create(Ref ref) {
    return cloudBackupRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CloudBackupRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CloudBackupRepository>(value),
    );
  }
}

String _$cloudBackupRepositoryHash() =>
    r'98c1c5268a4dc6a28fdc997e1f4d50902591652a';

/// Whether the app should offer to restore a cloud backup right now: a
/// Google session restores silently, a backup exists for it, and this
/// device hasn't already been offered (or completed) a restore.

@ProviderFor(shouldOfferRestore)
final shouldOfferRestoreProvider = ShouldOfferRestoreProvider._();

/// Whether the app should offer to restore a cloud backup right now: a
/// Google session restores silently, a backup exists for it, and this
/// device hasn't already been offered (or completed) a restore.

final class ShouldOfferRestoreProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Whether the app should offer to restore a cloud backup right now: a
  /// Google session restores silently, a backup exists for it, and this
  /// device hasn't already been offered (or completed) a restore.
  ShouldOfferRestoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shouldOfferRestoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shouldOfferRestoreHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return shouldOfferRestore(ref);
  }
}

String _$shouldOfferRestoreHash() =>
    r'a0e977fdc2fc4d802b11c57a2afc27f04800e79d';
