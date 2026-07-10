// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// All non-deleted favorites (meal templates), sorted by name.

@ProviderFor(favoriteTemplates)
final favoriteTemplatesProvider = FavoriteTemplatesProvider._();

/// All non-deleted favorites (meal templates), sorted by name.

final class FavoriteTemplatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MealTemplateOption>>,
          List<MealTemplateOption>,
          Stream<List<MealTemplateOption>>
        >
    with
        $FutureModifier<List<MealTemplateOption>>,
        $StreamProvider<List<MealTemplateOption>> {
  /// All non-deleted favorites (meal templates), sorted by name.
  FavoriteTemplatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteTemplatesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteTemplatesHash();

  @$internal
  @override
  $StreamProviderElement<List<MealTemplateOption>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MealTemplateOption>> create(Ref ref) {
    return favoriteTemplates(ref);
  }
}

String _$favoriteTemplatesHash() => r'fbd7b50cf3efcb1d08fd027b8c812609fad34808';
