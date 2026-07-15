// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment_capture_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [EnvironmentCaptureRepository] implementation.

@ProviderFor(environmentCaptureRepository)
final environmentCaptureRepositoryProvider =
    EnvironmentCaptureRepositoryProvider._();

/// Provides the [EnvironmentCaptureRepository] implementation.

final class EnvironmentCaptureRepositoryProvider
    extends
        $FunctionalProvider<
          EnvironmentCaptureRepository,
          EnvironmentCaptureRepository,
          EnvironmentCaptureRepository
        >
    with $Provider<EnvironmentCaptureRepository> {
  /// Provides the [EnvironmentCaptureRepository] implementation.
  EnvironmentCaptureRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'environmentCaptureRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$environmentCaptureRepositoryHash();

  @$internal
  @override
  $ProviderElement<EnvironmentCaptureRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnvironmentCaptureRepository create(Ref ref) {
    return environmentCaptureRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnvironmentCaptureRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnvironmentCaptureRepository>(value),
    );
  }
}

String _$environmentCaptureRepositoryHash() =>
    r'f7397ebf95db4802eb741c14be73fbabc6dc21f3';
