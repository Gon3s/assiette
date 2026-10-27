// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_management_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(managedTags)
final managedTagsProvider = ManagedTagsProvider._();

final class ManagedTagsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ManagedTag>>,
          List<ManagedTag>,
          Stream<List<ManagedTag>>
        >
    with $FutureModifier<List<ManagedTag>>, $StreamProvider<List<ManagedTag>> {
  ManagedTagsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'managedTagsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$managedTagsHash();

  @$internal
  @override
  $StreamProviderElement<List<ManagedTag>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ManagedTag>> create(Ref ref) {
    return managedTags(ref);
  }
}

String _$managedTagsHash() => r'8dbf9a5255b3bf9edb49b36db8b8e4ca31de2e62';

@ProviderFor(tagMergePreview)
final tagMergePreviewProvider = TagMergePreviewFamily._();

final class TagMergePreviewProvider
    extends
        $FunctionalProvider<
          AsyncValue<TagMergePreview>,
          TagMergePreview,
          FutureOr<TagMergePreview>
        >
    with $FutureModifier<TagMergePreview>, $FutureProvider<TagMergePreview> {
  TagMergePreviewProvider._({
    required TagMergePreviewFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'tagMergePreviewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tagMergePreviewHash();

  @override
  String toString() {
    return r'tagMergePreviewProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<TagMergePreview> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TagMergePreview> create(Ref ref) {
    final argument = this.argument as (String, String);
    return tagMergePreview(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is TagMergePreviewProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tagMergePreviewHash() => r'7c40cfd66771d1308a894557a27b623f3db9cdaa';

final class TagMergePreviewFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<TagMergePreview>, (String, String)> {
  TagMergePreviewFamily._()
    : super(
        retry: null,
        name: r'tagMergePreviewProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TagMergePreviewProvider call(String sourceId, String targetId) =>
      TagMergePreviewProvider._(argument: (sourceId, targetId), from: this);

  @override
  String toString() => r'tagMergePreviewProvider';
}

@ProviderFor(TagManagementController)
final tagManagementControllerProvider = TagManagementControllerProvider._();

final class TagManagementControllerProvider
    extends $AsyncNotifierProvider<TagManagementController, void> {
  TagManagementControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagManagementControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagManagementControllerHash();

  @$internal
  @override
  TagManagementController create() => TagManagementController();
}

String _$tagManagementControllerHash() =>
    r'435de37f3d067420c25d0effd4ac6012f2848ea2';

abstract class _$TagManagementController extends $AsyncNotifier<void> {
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
