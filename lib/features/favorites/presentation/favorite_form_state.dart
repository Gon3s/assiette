import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_form_state.freezed.dart';

/// Form state of the favorite create/edit screen. [id] is null when
/// creating a new favorite.
@freezed
abstract class FavoriteFormState with _$FavoriteFormState {
  /// Creates a [FavoriteFormState].
  const factory FavoriteFormState({
    String? id,
    @Default('') String name,
    MealType? mealType,
    @Default([]) List<TagOption> selectedTags,
    String? photoPath,
    @Default(false) bool isSaving,
  }) = _FavoriteFormState;
}
