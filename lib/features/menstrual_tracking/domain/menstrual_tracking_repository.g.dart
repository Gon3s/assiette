// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menstrual_tracking_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(menstrualTrackingRepository)
final menstrualTrackingRepositoryProvider =
    MenstrualTrackingRepositoryProvider._();

final class MenstrualTrackingRepositoryProvider
    extends
        $FunctionalProvider<
          MenstrualTrackingRepository,
          MenstrualTrackingRepository,
          MenstrualTrackingRepository
        >
    with $Provider<MenstrualTrackingRepository> {
  MenstrualTrackingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menstrualTrackingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menstrualTrackingRepositoryHash();

  @$internal
  @override
  $ProviderElement<MenstrualTrackingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MenstrualTrackingRepository create(Ref ref) {
    return menstrualTrackingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MenstrualTrackingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MenstrualTrackingRepository>(value),
    );
  }
}

String _$menstrualTrackingRepositoryHash() =>
    r'4a246c67adee4892a5b7a6d63a1a12f1fb9f4c68';
