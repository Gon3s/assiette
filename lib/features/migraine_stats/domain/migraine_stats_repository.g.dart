// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migraine_stats_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the Drift-backed migraine statistics repository.

@ProviderFor(migraineStatsRepository)
final migraineStatsRepositoryProvider = MigraineStatsRepositoryProvider._();

/// Provides the Drift-backed migraine statistics repository.

final class MigraineStatsRepositoryProvider
    extends
        $FunctionalProvider<
          MigraineStatsRepository,
          MigraineStatsRepository,
          MigraineStatsRepository
        >
    with $Provider<MigraineStatsRepository> {
  /// Provides the Drift-backed migraine statistics repository.
  MigraineStatsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'migraineStatsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$migraineStatsRepositoryHash();

  @$internal
  @override
  $ProviderElement<MigraineStatsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MigraineStatsRepository create(Ref ref) {
    return migraineStatsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MigraineStatsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MigraineStatsRepository>(value),
    );
  }
}

String _$migraineStatsRepositoryHash() =>
    r'35e312070281204e090953375b1e0edc38ac823b';
