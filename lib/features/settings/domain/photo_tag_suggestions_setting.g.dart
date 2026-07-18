// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_tag_suggestions_setting.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether photo-based tag suggestions (US-19) are enabled. Defaults to
/// `true` until the user opts out in settings.

@ProviderFor(photoTagSuggestionsEnabled)
final photoTagSuggestionsEnabledProvider =
    PhotoTagSuggestionsEnabledProvider._();

/// Whether photo-based tag suggestions (US-19) are enabled. Defaults to
/// `true` until the user opts out in settings.

final class PhotoTagSuggestionsEnabledProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  /// Whether photo-based tag suggestions (US-19) are enabled. Defaults to
  /// `true` until the user opts out in settings.
  PhotoTagSuggestionsEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoTagSuggestionsEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoTagSuggestionsEnabledHash();

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    return photoTagSuggestionsEnabled(ref);
  }
}

String _$photoTagSuggestionsEnabledHash() =>
    r'd09096cd7772ee7981c39ad6f859053be6748da1';

/// Persists the photo tag suggestions toggle (US-19).

@ProviderFor(PhotoTagSuggestionsSettingController)
final photoTagSuggestionsSettingControllerProvider =
    PhotoTagSuggestionsSettingControllerProvider._();

/// Persists the photo tag suggestions toggle (US-19).
final class PhotoTagSuggestionsSettingControllerProvider
    extends $NotifierProvider<PhotoTagSuggestionsSettingController, void> {
  /// Persists the photo tag suggestions toggle (US-19).
  PhotoTagSuggestionsSettingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoTagSuggestionsSettingControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$photoTagSuggestionsSettingControllerHash();

  @$internal
  @override
  PhotoTagSuggestionsSettingController create() =>
      PhotoTagSuggestionsSettingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$photoTagSuggestionsSettingControllerHash() =>
    r'12897774c9cc2b334ec7b2cfce17e2b34fb7bf80';

/// Persists the photo tag suggestions toggle (US-19).

abstract class _$PhotoTagSuggestionsSettingController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
