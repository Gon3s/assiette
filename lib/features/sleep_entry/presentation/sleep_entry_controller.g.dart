// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_entry_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds and mutates the sleep entry detail form (quality, bed/wake time),
/// seeded from the sleep already logged for the selected day, and performs
/// the final save.

@ProviderFor(SleepEntryController)
final sleepEntryControllerProvider = SleepEntryControllerProvider._();

/// Holds and mutates the sleep entry detail form (quality, bed/wake time),
/// seeded from the sleep already logged for the selected day, and performs
/// the final save.
final class SleepEntryControllerProvider
    extends $NotifierProvider<SleepEntryController, SleepEntryState> {
  /// Holds and mutates the sleep entry detail form (quality, bed/wake time),
  /// seeded from the sleep already logged for the selected day, and performs
  /// the final save.
  SleepEntryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sleepEntryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sleepEntryControllerHash();

  @$internal
  @override
  SleepEntryController create() => SleepEntryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SleepEntryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SleepEntryState>(value),
    );
  }
}

String _$sleepEntryControllerHash() =>
    r'b5201108a7c9a977adc9795f65966c0d7c8655a8';

/// Holds and mutates the sleep entry detail form (quality, bed/wake time),
/// seeded from the sleep already logged for the selected day, and performs
/// the final save.

abstract class _$SleepEntryController extends $Notifier<SleepEntryState> {
  SleepEntryState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SleepEntryState, SleepEntryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SleepEntryState, SleepEntryState>,
              SleepEntryState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
