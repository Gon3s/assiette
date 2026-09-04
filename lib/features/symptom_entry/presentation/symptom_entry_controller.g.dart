// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_entry_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds and mutates the symptom entry form, and performs the final save.

@ProviderFor(SymptomEntryController)
final symptomEntryControllerProvider = SymptomEntryControllerProvider._();

/// Holds and mutates the symptom entry form, and performs the final save.
final class SymptomEntryControllerProvider
    extends $NotifierProvider<SymptomEntryController, SymptomEntryState> {
  /// Holds and mutates the symptom entry form, and performs the final save.
  SymptomEntryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'symptomEntryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$symptomEntryControllerHash();

  @$internal
  @override
  SymptomEntryController create() => SymptomEntryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SymptomEntryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SymptomEntryState>(value),
    );
  }
}

String _$symptomEntryControllerHash() =>
    r'b9e86bea2dcf8210bc9bde258b1b8173ba5d9126';

/// Holds and mutates the symptom entry form, and performs the final save.

abstract class _$SymptomEntryController extends $Notifier<SymptomEntryState> {
  SymptomEntryState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SymptomEntryState, SymptomEntryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SymptomEntryState, SymptomEntryState>,
              SymptomEntryState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
