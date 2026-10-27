// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migraine_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(migraineHistory)
final migraineHistoryProvider = MigraineHistoryProvider._();

final class MigraineHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MigraineHistoryEntry>>,
          List<MigraineHistoryEntry>,
          Stream<List<MigraineHistoryEntry>>
        >
    with
        $FutureModifier<List<MigraineHistoryEntry>>,
        $StreamProvider<List<MigraineHistoryEntry>> {
  MigraineHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'migraineHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$migraineHistoryHash();

  @$internal
  @override
  $StreamProviderElement<List<MigraineHistoryEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MigraineHistoryEntry>> create(Ref ref) {
    return migraineHistory(ref);
  }
}

String _$migraineHistoryHash() => r'de4b54a6c12f07bb94c5d50c57926e4b16952876';
