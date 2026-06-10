// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_startup.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The application startup provider.

@ProviderFor(appStartup)
final appStartupProvider = AppStartupProvider._();

/// The application startup provider.

final class AppStartupProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppDependencies>,
          AppDependencies,
          FutureOr<AppDependencies>
        >
    with $FutureModifier<AppDependencies>, $FutureProvider<AppDependencies> {
  /// The application startup provider.
  AppStartupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appStartupProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appStartupHash();

  @$internal
  @override
  $FutureProviderElement<AppDependencies> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppDependencies> create(Ref ref) {
    return appStartup(ref);
  }
}

String _$appStartupHash() => r'5ad9c8bedcdd4a3451a2e49e827bc96ad38e709a';
