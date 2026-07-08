// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_photo_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [MealPhotoService] implementation.

@ProviderFor(mealPhotoService)
final mealPhotoServiceProvider = MealPhotoServiceProvider._();

/// Provides the [MealPhotoService] implementation.

final class MealPhotoServiceProvider
    extends
        $FunctionalProvider<
          MealPhotoService,
          MealPhotoService,
          MealPhotoService
        >
    with $Provider<MealPhotoService> {
  /// Provides the [MealPhotoService] implementation.
  MealPhotoServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealPhotoServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealPhotoServiceHash();

  @$internal
  @override
  $ProviderElement<MealPhotoService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MealPhotoService create(Ref ref) {
    return mealPhotoService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MealPhotoService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MealPhotoService>(value),
    );
  }
}

String _$mealPhotoServiceHash() => r'f698378ec29bcf7059054df20b2c0c4afe3d13da';
