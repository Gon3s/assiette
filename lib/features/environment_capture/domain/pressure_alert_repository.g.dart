// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pressure_alert_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [PressureAlertRepository] implementation.

@ProviderFor(pressureAlertRepository)
final pressureAlertRepositoryProvider = PressureAlertRepositoryProvider._();

/// Provides the [PressureAlertRepository] implementation.

final class PressureAlertRepositoryProvider
    extends
        $FunctionalProvider<
          PressureAlertRepository,
          PressureAlertRepository,
          PressureAlertRepository
        >
    with $Provider<PressureAlertRepository> {
  /// Provides the [PressureAlertRepository] implementation.
  PressureAlertRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pressureAlertRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pressureAlertRepositoryHash();

  @$internal
  @override
  $ProviderElement<PressureAlertRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PressureAlertRepository create(Ref ref) {
    return pressureAlertRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PressureAlertRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PressureAlertRepository>(value),
    );
  }
}

String _$pressureAlertRepositoryHash() =>
    r'57a6bc96910763469957a4cdf28dec256911b924';
