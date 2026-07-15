// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_entry_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [SleepEntryRepository] implementation.

@ProviderFor(sleepEntryRepository)
final sleepEntryRepositoryProvider = SleepEntryRepositoryProvider._();

/// Provides the [SleepEntryRepository] implementation.

final class SleepEntryRepositoryProvider
    extends
        $FunctionalProvider<
          SleepEntryRepository,
          SleepEntryRepository,
          SleepEntryRepository
        >
    with $Provider<SleepEntryRepository> {
  /// Provides the [SleepEntryRepository] implementation.
  SleepEntryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sleepEntryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sleepEntryRepositoryHash();

  @$internal
  @override
  $ProviderElement<SleepEntryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SleepEntryRepository create(Ref ref) {
    return sleepEntryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SleepEntryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SleepEntryRepository>(value),
    );
  }
}

String _$sleepEntryRepositoryHash() =>
    r'b38d0773c270e3e98e9c802a392c74ec86094709';
