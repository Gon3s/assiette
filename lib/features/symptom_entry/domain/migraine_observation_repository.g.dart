// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migraine_observation_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the Drift implementation.

@ProviderFor(migraineObservationRepository)
final migraineObservationRepositoryProvider =
    MigraineObservationRepositoryProvider._();

/// Provides the Drift implementation.

final class MigraineObservationRepositoryProvider
    extends
        $FunctionalProvider<
          MigraineObservationRepository,
          MigraineObservationRepository,
          MigraineObservationRepository
        >
    with $Provider<MigraineObservationRepository> {
  /// Provides the Drift implementation.
  MigraineObservationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'migraineObservationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$migraineObservationRepositoryHash();

  @$internal
  @override
  $ProviderElement<MigraineObservationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MigraineObservationRepository create(Ref ref) {
    return migraineObservationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MigraineObservationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MigraineObservationRepository>(
        value,
      ),
    );
  }
}

String _$migraineObservationRepositoryHash() =>
    r'9f099d2f6f02228cb37d6f7df9362839538ef583';

/// Reactive observation list for one migraine episode.

@ProviderFor(migraineObservations)
final migraineObservationsProvider = MigraineObservationsFamily._();

/// Reactive observation list for one migraine episode.

final class MigraineObservationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MigraineObservation>>,
          List<MigraineObservation>,
          Stream<List<MigraineObservation>>
        >
    with
        $FutureModifier<List<MigraineObservation>>,
        $StreamProvider<List<MigraineObservation>> {
  /// Reactive observation list for one migraine episode.
  MigraineObservationsProvider._({
    required MigraineObservationsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'migraineObservationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$migraineObservationsHash();

  @override
  String toString() {
    return r'migraineObservationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<MigraineObservation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MigraineObservation>> create(Ref ref) {
    final argument = this.argument as String;
    return migraineObservations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MigraineObservationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$migraineObservationsHash() =>
    r'dcb42fc145fb1a5eb7043d7558604028514bdba3';

/// Reactive observation list for one migraine episode.

final class MigraineObservationsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<MigraineObservation>>, String> {
  MigraineObservationsFamily._()
    : super(
        retry: null,
        name: r'migraineObservationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Reactive observation list for one migraine episode.

  MigraineObservationsProvider call(String migraineId) =>
      MigraineObservationsProvider._(argument: migraineId, from: this);

  @override
  String toString() => r'migraineObservationsProvider';
}
