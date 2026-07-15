import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_draft.freezed.dart';

/// A previously logged meal, loaded for editing.
@freezed
abstract class MealDraft with _$MealDraft {
  /// Creates a [MealDraft].
  const factory MealDraft({
    required String id,
    required DateTime timestamp,
    required MealType mealType,
    required List<TagOption> tags,
    String? photoPath,
    String? note,
  }) = _MealDraft;
}
