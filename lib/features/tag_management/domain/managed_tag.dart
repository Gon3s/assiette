import 'package:freezed_annotation/freezed_annotation.dart';

part 'managed_tag.freezed.dart';

@freezed
abstract class ManagedTag with _$ManagedTag {
  const factory ManagedTag({
    required String id,
    required String label,
    required bool isSystem,
    required int dayCount,
    required int mealCount,
    required int favoriteCount,
    String? category,
  }) = _ManagedTag;
}
