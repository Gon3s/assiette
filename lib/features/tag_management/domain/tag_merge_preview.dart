import 'package:assiette/features/tag_management/domain/managed_tag.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_merge_preview.freezed.dart';

@freezed
abstract class TagMergePreview with _$TagMergePreview {
  const factory TagMergePreview({
    required ManagedTag source,
    required ManagedTag target,
    required List<String> favoriteNames,
  }) = _TagMergePreview;
}
