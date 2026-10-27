// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migraine_history_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(migraineHistoryRepository)
final migraineHistoryRepositoryProvider = MigraineHistoryRepositoryProvider._();

final class MigraineHistoryRepositoryProvider
    extends
        $FunctionalProvider<
          MigraineHistoryRepository,
          MigraineHistoryRepository,
          MigraineHistoryRepository
        >
    with $Provider<MigraineHistoryRepository> {
  MigraineHistoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'migraineHistoryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$migraineHistoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<MigraineHistoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MigraineHistoryRepository create(Ref ref) {
    return migraineHistoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MigraineHistoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MigraineHistoryRepository>(value),
    );
  }
}

String _$migraineHistoryRepositoryHash() =>
    r'26c0a7facca1f8d83a60cf54612975d69200a0a8';
