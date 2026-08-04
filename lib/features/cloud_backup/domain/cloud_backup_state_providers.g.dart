// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_backup_state_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Timestamp of the last successful cloud backup run on this device, or
/// `null` if it never ran. Local-only metadata — not part of the
/// exported/restored snapshot.

@ProviderFor(lastBackupAt)
final lastBackupAtProvider = LastBackupAtProvider._();

/// Timestamp of the last successful cloud backup run on this device, or
/// `null` if it never ran. Local-only metadata — not part of the
/// exported/restored snapshot.

final class LastBackupAtProvider
    extends
        $FunctionalProvider<AsyncValue<DateTime?>, DateTime?, Stream<DateTime?>>
    with $FutureModifier<DateTime?>, $StreamProvider<DateTime?> {
  /// Timestamp of the last successful cloud backup run on this device, or
  /// `null` if it never ran. Local-only metadata — not part of the
  /// exported/restored snapshot.
  LastBackupAtProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lastBackupAtProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lastBackupAtHash();

  @$internal
  @override
  $StreamProviderElement<DateTime?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DateTime?> create(Ref ref) {
    return lastBackupAt(ref);
  }
}

String _$lastBackupAtHash() => r'96df5691f0d7a5f2cd692fccf33db5c229b33f83';
