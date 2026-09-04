// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_view_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [DayViewRepository] implementation.

@ProviderFor(dayViewRepository)
final dayViewRepositoryProvider = DayViewRepositoryProvider._();

/// Provides the [DayViewRepository] implementation.

final class DayViewRepositoryProvider
    extends
        $FunctionalProvider<
          DayViewRepository,
          DayViewRepository,
          DayViewRepository
        >
    with $Provider<DayViewRepository> {
  /// Provides the [DayViewRepository] implementation.
  DayViewRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dayViewRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dayViewRepositoryHash();

  @$internal
  @override
  $ProviderElement<DayViewRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DayViewRepository create(Ref ref) {
    return dayViewRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DayViewRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DayViewRepository>(value),
    );
  }
}

String _$dayViewRepositoryHash() => r'25ceceef4e1bd09217c580610f5ffae25e915666';
