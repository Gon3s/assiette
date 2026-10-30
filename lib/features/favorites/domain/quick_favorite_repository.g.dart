// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_favorite_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(quickFavoriteRepository)
final quickFavoriteRepositoryProvider = QuickFavoriteRepositoryProvider._();

final class QuickFavoriteRepositoryProvider
    extends
        $FunctionalProvider<
          QuickFavoriteRepository,
          QuickFavoriteRepository,
          QuickFavoriteRepository
        >
    with $Provider<QuickFavoriteRepository> {
  QuickFavoriteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quickFavoriteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quickFavoriteRepositoryHash();

  @$internal
  @override
  $ProviderElement<QuickFavoriteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  QuickFavoriteRepository create(Ref ref) {
    return quickFavoriteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuickFavoriteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuickFavoriteRepository>(value),
    );
  }
}

String _$quickFavoriteRepositoryHash() =>
    r'a3fcf4b6b22ce50b2e2aa64f909a8a5949bf43b5';

@ProviderFor(quickFavoriteSelection)
final quickFavoriteSelectionProvider = QuickFavoriteSelectionProvider._();

final class QuickFavoriteSelectionProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, Stream<String?>>
    with $FutureModifier<String?>, $StreamProvider<String?> {
  QuickFavoriteSelectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quickFavoriteSelectionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quickFavoriteSelectionHash();

  @$internal
  @override
  $StreamProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String?> create(Ref ref) {
    return quickFavoriteSelection(ref);
  }
}

String _$quickFavoriteSelectionHash() =>
    r'460fc066ffc5e94b15baf874aa0bebbf0228328d';
