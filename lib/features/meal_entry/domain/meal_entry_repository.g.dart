// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_entry_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [MealEntryRepository] implementation.

@ProviderFor(mealEntryRepository)
final mealEntryRepositoryProvider = MealEntryRepositoryProvider._();

/// Provides the [MealEntryRepository] implementation.

final class MealEntryRepositoryProvider
    extends
        $FunctionalProvider<
          MealEntryRepository,
          MealEntryRepository,
          MealEntryRepository
        >
    with $Provider<MealEntryRepository> {
  /// Provides the [MealEntryRepository] implementation.
  MealEntryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealEntryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealEntryRepositoryHash();

  @$internal
  @override
  $ProviderElement<MealEntryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MealEntryRepository create(Ref ref) {
    return mealEntryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MealEntryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MealEntryRepository>(value),
    );
  }
}

String _$mealEntryRepositoryHash() =>
    r'046cf3cf5aebe22a56cee4ded61142e1349555b5';
