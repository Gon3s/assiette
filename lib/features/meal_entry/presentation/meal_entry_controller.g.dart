// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_entry_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// All tags available for selection, sorted by label.

@ProviderFor(availableTags)
final availableTagsProvider = AvailableTagsProvider._();

/// All tags available for selection, sorted by label.

final class AvailableTagsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TagOption>>,
          List<TagOption>,
          Stream<List<TagOption>>
        >
    with $FutureModifier<List<TagOption>>, $StreamProvider<List<TagOption>> {
  /// All tags available for selection, sorted by label.
  AvailableTagsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableTagsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableTagsHash();

  @$internal
  @override
  $StreamProviderElement<List<TagOption>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TagOption>> create(Ref ref) {
    return availableTags(ref);
  }
}

String _$availableTagsHash() => r'f3d336e750a727e1c577e76af0fb6997201e1962';

/// Holds and mutates the meal entry form, and performs the final save.

@ProviderFor(MealEntryController)
final mealEntryControllerProvider = MealEntryControllerProvider._();

/// Holds and mutates the meal entry form, and performs the final save.
final class MealEntryControllerProvider
    extends $NotifierProvider<MealEntryController, MealEntryState> {
  /// Holds and mutates the meal entry form, and performs the final save.
  MealEntryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealEntryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealEntryControllerHash();

  @$internal
  @override
  MealEntryController create() => MealEntryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MealEntryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MealEntryState>(value),
    );
  }
}

String _$mealEntryControllerHash() =>
    r'd3ee2bff9a7f2a224ff853c1b9971229569827ce';

/// Holds and mutates the meal entry form, and performs the final save.

abstract class _$MealEntryController extends $Notifier<MealEntryState> {
  MealEntryState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MealEntryState, MealEntryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MealEntryState, MealEntryState>,
              MealEntryState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
