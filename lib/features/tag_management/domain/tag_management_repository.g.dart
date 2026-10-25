// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_management_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tagManagementRepository)
final tagManagementRepositoryProvider = TagManagementRepositoryProvider._();

final class TagManagementRepositoryProvider
    extends
        $FunctionalProvider<
          TagManagementRepository,
          TagManagementRepository,
          TagManagementRepository
        >
    with $Provider<TagManagementRepository> {
  TagManagementRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagManagementRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagManagementRepositoryHash();

  @$internal
  @override
  $ProviderElement<TagManagementRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TagManagementRepository create(Ref ref) {
    return tagManagementRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TagManagementRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TagManagementRepository>(value),
    );
  }
}

String _$tagManagementRepositoryHash() =>
    r'69edb43b8256b93ca43d648aef1986249790999f';
