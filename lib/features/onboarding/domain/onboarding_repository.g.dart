// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [OnboardingRepository] implementation.

@ProviderFor(onboardingRepository)
final onboardingRepositoryProvider = OnboardingRepositoryProvider._();

/// Provides the [OnboardingRepository] implementation.

final class OnboardingRepositoryProvider
    extends
        $FunctionalProvider<
          OnboardingRepository,
          OnboardingRepository,
          OnboardingRepository
        >
    with $Provider<OnboardingRepository> {
  /// Provides the [OnboardingRepository] implementation.
  OnboardingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingRepositoryHash();

  @$internal
  @override
  $ProviderElement<OnboardingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OnboardingRepository create(Ref ref) {
    return onboardingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingRepository>(value),
    );
  }
}

String _$onboardingRepositoryHash() =>
    r'd02855daf42e2fc39380e6358f27383f84422303';

/// Whether the onboarding has already been completed, gating the router.

@ProviderFor(onboardingDone)
final onboardingDoneProvider = OnboardingDoneProvider._();

/// Whether the onboarding has already been completed, gating the router.

final class OnboardingDoneProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  /// Whether the onboarding has already been completed, gating the router.
  OnboardingDoneProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingDoneProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingDoneHash();

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    return onboardingDone(ref);
  }
}

String _$onboardingDoneHash() => r'd53c3ada0f8c32ebf3109d1826a057c0640f96cf';
