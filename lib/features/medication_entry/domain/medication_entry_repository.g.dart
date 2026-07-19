// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_entry_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [MedicationEntryRepository] implementation.

@ProviderFor(medicationEntryRepository)
final medicationEntryRepositoryProvider = MedicationEntryRepositoryProvider._();

/// Provides the [MedicationEntryRepository] implementation.

final class MedicationEntryRepositoryProvider
    extends
        $FunctionalProvider<
          MedicationEntryRepository,
          MedicationEntryRepository,
          MedicationEntryRepository
        >
    with $Provider<MedicationEntryRepository> {
  /// Provides the [MedicationEntryRepository] implementation.
  MedicationEntryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'medicationEntryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$medicationEntryRepositoryHash();

  @$internal
  @override
  $ProviderElement<MedicationEntryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MedicationEntryRepository create(Ref ref) {
    return medicationEntryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MedicationEntryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MedicationEntryRepository>(value),
    );
  }
}

String _$medicationEntryRepositoryHash() =>
    r'eb76ec0e075b03e1d2796f1c23b9bb6e821698eb';

/// Recent medication names, for the suggestion chips of the symptom form.

@ProviderFor(recentMedicationNames)
final recentMedicationNamesProvider = RecentMedicationNamesProvider._();

/// Recent medication names, for the suggestion chips of the symptom form.

final class RecentMedicationNamesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  /// Recent medication names, for the suggestion chips of the symptom form.
  RecentMedicationNamesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentMedicationNamesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentMedicationNamesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return recentMedicationNames(ref);
  }
}

String _$recentMedicationNamesHash() =>
    r'484b761fff1e11b55e69e5caf9644beeaff992f2';
