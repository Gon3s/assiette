// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migraine_stats_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Period currently selected on the migraine statistics screen.

@ProviderFor(SelectedMigraineStatsPeriod)
final selectedMigraineStatsPeriodProvider =
    SelectedMigraineStatsPeriodProvider._();

/// Period currently selected on the migraine statistics screen.
final class SelectedMigraineStatsPeriodProvider
    extends
        $NotifierProvider<SelectedMigraineStatsPeriod, MigraineStatsPeriod> {
  /// Period currently selected on the migraine statistics screen.
  SelectedMigraineStatsPeriodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedMigraineStatsPeriodProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedMigraineStatsPeriodHash();

  @$internal
  @override
  SelectedMigraineStatsPeriod create() => SelectedMigraineStatsPeriod();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MigraineStatsPeriod value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MigraineStatsPeriod>(value),
    );
  }
}

String _$selectedMigraineStatsPeriodHash() =>
    r'f07ef709adfcb29f0fd67d1107afcbe2a1021d46';

/// Period currently selected on the migraine statistics screen.

abstract class _$SelectedMigraineStatsPeriod
    extends $Notifier<MigraineStatsPeriod> {
  MigraineStatsPeriod build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MigraineStatsPeriod, MigraineStatsPeriod>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MigraineStatsPeriod, MigraineStatsPeriod>,
              MigraineStatsPeriod,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Loads migraine statistics for [period].

@ProviderFor(migraineStats)
final migraineStatsProvider = MigraineStatsFamily._();

/// Loads migraine statistics for [period].

final class MigraineStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<MigraineStats>,
          MigraineStats,
          FutureOr<MigraineStats>
        >
    with $FutureModifier<MigraineStats>, $FutureProvider<MigraineStats> {
  /// Loads migraine statistics for [period].
  MigraineStatsProvider._({
    required MigraineStatsFamily super.from,
    required MigraineStatsPeriod super.argument,
  }) : super(
         retry: null,
         name: r'migraineStatsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$migraineStatsHash();

  @override
  String toString() {
    return r'migraineStatsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MigraineStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MigraineStats> create(Ref ref) {
    final argument = this.argument as MigraineStatsPeriod;
    return migraineStats(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MigraineStatsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$migraineStatsHash() => r'e880e1f47005763bd4163b249f85ecc610527344';

/// Loads migraine statistics for [period].

final class MigraineStatsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<MigraineStats>,
          MigraineStatsPeriod
        > {
  MigraineStatsFamily._()
    : super(
        retry: null,
        name: r'migraineStatsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Loads migraine statistics for [period].

  MigraineStatsProvider call(MigraineStatsPeriod period) =>
      MigraineStatsProvider._(argument: period, from: this);

  @override
  String toString() => r'migraineStatsProvider';
}
