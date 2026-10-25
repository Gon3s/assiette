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
    r'3e88a37ca4663e1a856ec24ffcf70fddf7148acd';

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
