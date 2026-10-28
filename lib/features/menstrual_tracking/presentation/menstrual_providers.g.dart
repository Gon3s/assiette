// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menstrual_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(menstrualPreferences)
final menstrualPreferencesProvider = MenstrualPreferencesProvider._();

final class MenstrualPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<MenstrualPreferences>,
          MenstrualPreferences,
          Stream<MenstrualPreferences>
        >
    with
        $FutureModifier<MenstrualPreferences>,
        $StreamProvider<MenstrualPreferences> {
  MenstrualPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menstrualPreferencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menstrualPreferencesHash();

  @$internal
  @override
  $StreamProviderElement<MenstrualPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<MenstrualPreferences> create(Ref ref) {
    return menstrualPreferences(ref);
  }
}

String _$menstrualPreferencesHash() =>
    r'5f72e5a01597c5d35aa444d97bd7e8166035812e';

@ProviderFor(menstrualDay)
final menstrualDayProvider = MenstrualDayFamily._();

final class MenstrualDayProvider
    extends
        $FunctionalProvider<
          AsyncValue<MenstrualObservation?>,
          MenstrualObservation?,
          Stream<MenstrualObservation?>
        >
    with
        $FutureModifier<MenstrualObservation?>,
        $StreamProvider<MenstrualObservation?> {
  MenstrualDayProvider._({
    required MenstrualDayFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'menstrualDayProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$menstrualDayHash();

  @override
  String toString() {
    return r'menstrualDayProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<MenstrualObservation?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<MenstrualObservation?> create(Ref ref) {
    final argument = this.argument as String;
    return menstrualDay(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MenstrualDayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$menstrualDayHash() => r'c5012dc7a4340c1d858f8a4d4df7f58208a60e04';

final class MenstrualDayFamily extends $Family
    with $FunctionalFamilyOverride<Stream<MenstrualObservation?>, String> {
  MenstrualDayFamily._()
    : super(
        retry: null,
        name: r'menstrualDayProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MenstrualDayProvider call(String date) =>
      MenstrualDayProvider._(argument: date, from: this);

  @override
  String toString() => r'menstrualDayProvider';
}

@ProviderFor(MenstrualActions)
final menstrualActionsProvider = MenstrualActionsProvider._();

final class MenstrualActionsProvider
    extends $AsyncNotifierProvider<MenstrualActions, void> {
  MenstrualActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menstrualActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menstrualActionsHash();

  @$internal
  @override
  MenstrualActions create() => MenstrualActions();
}

String _$menstrualActionsHash() => r'62aa2a055cf329d68027fa9f405eced4f275efa7';

abstract class _$MenstrualActions extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
