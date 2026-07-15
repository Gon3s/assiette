// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_entry_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [SymptomEntryRepository] implementation.

@ProviderFor(symptomEntryRepository)
final symptomEntryRepositoryProvider = SymptomEntryRepositoryProvider._();

/// Provides the [SymptomEntryRepository] implementation.

final class SymptomEntryRepositoryProvider
    extends
        $FunctionalProvider<
          SymptomEntryRepository,
          SymptomEntryRepository,
          SymptomEntryRepository
        >
    with $Provider<SymptomEntryRepository> {
  /// Provides the [SymptomEntryRepository] implementation.
  SymptomEntryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'symptomEntryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$symptomEntryRepositoryHash();

  @$internal
  @override
  $ProviderElement<SymptomEntryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SymptomEntryRepository create(Ref ref) {
    return symptomEntryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SymptomEntryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SymptomEntryRepository>(value),
    );
  }
}

String _$symptomEntryRepositoryHash() =>
    r'3ac72687e241dbcab9d5e7445c0bece0e5a072f6';
