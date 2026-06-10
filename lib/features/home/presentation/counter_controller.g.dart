// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for the counter feature.

@ProviderFor(CounterController)
final counterControllerProvider = CounterControllerProvider._();

/// Controller for the counter feature.
final class CounterControllerProvider
    extends $NotifierProvider<CounterController, int> {
  /// Controller for the counter feature.
  CounterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'counterControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$counterControllerHash();

  @$internal
  @override
  CounterController create() => CounterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$counterControllerHash() => r'993f3144efcf2472bbdb4ed3ed55460ddb878ec6';

/// Controller for the counter feature.

abstract class _$CounterController extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
