import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_option.freezed.dart';

/// A tag that can be attached to a meal.
@freezed
abstract class TagOption with _$TagOption {
  /// Creates a [TagOption].
  const factory TagOption({
    required String id,
    required String label,
    required bool isSystem,
  }) = _TagOption;
}
