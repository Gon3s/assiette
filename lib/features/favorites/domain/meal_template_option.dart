import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_template_option.freezed.dart';

/// A reusable meal favorite (template) that can be logged in one tap.
@freezed
abstract class MealTemplateOption with _$MealTemplateOption {
  /// Creates a [MealTemplateOption].
  const factory MealTemplateOption({
    required String id,
    required String name,
    required List<TagOption> tags,
    MealType? defaultMealType,
    String? defaultPhotoPath,
  }) = _MealTemplateOption;
}
