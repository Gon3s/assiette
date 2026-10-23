import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_entry_state.freezed.dart';

/// Form state of the meal entry screen.
@freezed
abstract class MealEntryState with _$MealEntryState {
  /// Creates a [MealEntryState].
  const factory MealEntryState({
    required MealType mealType,
    required DateTime timestamp,
    required List<TagOption> selectedTags,
    @Default('') String note,
    String? photoPath,
    @Default(false) bool isSaving,
    String? id,
  }) = _MealEntryState;
}
