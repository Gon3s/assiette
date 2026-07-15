// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds and mutates the favorite create/edit form, seeded from the
/// existing favorite when [templateId] is not null, and performs the
/// final save (create or update).

@ProviderFor(FavoriteFormController)
final favoriteFormControllerProvider = FavoriteFormControllerFamily._();

/// Holds and mutates the favorite create/edit form, seeded from the
/// existing favorite when [templateId] is not null, and performs the
/// final save (create or update).
final class FavoriteFormControllerProvider
    extends $NotifierProvider<FavoriteFormController, FavoriteFormState> {
  /// Holds and mutates the favorite create/edit form, seeded from the
  /// existing favorite when [templateId] is not null, and performs the
  /// final save (create or update).
  FavoriteFormControllerProvider._({
    required FavoriteFormControllerFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'favoriteFormControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$favoriteFormControllerHash();

  @override
  String toString() {
    return r'favoriteFormControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FavoriteFormController create() => FavoriteFormController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoriteFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoriteFormState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FavoriteFormControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$favoriteFormControllerHash() =>
    r'637a83650126ae93403a94798380d49581c4ddec';

/// Holds and mutates the favorite create/edit form, seeded from the
/// existing favorite when [templateId] is not null, and performs the
/// final save (create or update).

final class FavoriteFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          FavoriteFormController,
          FavoriteFormState,
          FavoriteFormState,
          FavoriteFormState,
          String?
        > {
  FavoriteFormControllerFamily._()
    : super(
        retry: null,
        name: r'favoriteFormControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Holds and mutates the favorite create/edit form, seeded from the
  /// existing favorite when [templateId] is not null, and performs the
  /// final save (create or update).

  FavoriteFormControllerProvider call(String? templateId) =>
      FavoriteFormControllerProvider._(argument: templateId, from: this);

  @override
  String toString() => r'favoriteFormControllerProvider';
}

/// Holds and mutates the favorite create/edit form, seeded from the
/// existing favorite when [templateId] is not null, and performs the
/// final save (create or update).

abstract class _$FavoriteFormController extends $Notifier<FavoriteFormState> {
  late final _$args = ref.$arg as String?;
  String? get templateId => _$args;

  FavoriteFormState build(String? templateId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<FavoriteFormState, FavoriteFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FavoriteFormState, FavoriteFormState>,
              FavoriteFormState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
