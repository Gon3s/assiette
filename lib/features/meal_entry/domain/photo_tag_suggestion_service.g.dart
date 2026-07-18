// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_tag_suggestion_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [PhotoTagSuggestionService] implementation.

@ProviderFor(photoTagSuggestionService)
final photoTagSuggestionServiceProvider = PhotoTagSuggestionServiceProvider._();

/// Provides the [PhotoTagSuggestionService] implementation.

final class PhotoTagSuggestionServiceProvider
    extends
        $FunctionalProvider<
          PhotoTagSuggestionService,
          PhotoTagSuggestionService,
          PhotoTagSuggestionService
        >
    with $Provider<PhotoTagSuggestionService> {
  /// Provides the [PhotoTagSuggestionService] implementation.
  PhotoTagSuggestionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoTagSuggestionServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoTagSuggestionServiceHash();

  @$internal
  @override
  $ProviderElement<PhotoTagSuggestionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhotoTagSuggestionService create(Ref ref) {
    return photoTagSuggestionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoTagSuggestionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoTagSuggestionService>(value),
    );
  }
}

String _$photoTagSuggestionServiceHash() =>
    r'0e6f9fa156e1bab221d2233e0a68bbf5f68f52e8';
