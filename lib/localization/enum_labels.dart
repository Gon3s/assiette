import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/localization/app_strings.dart';

/// Localized label for a [MealType].
String mealTypeLabel(AppStrings s, MealType type) => switch (type) {
      MealType.breakfast => s.mealTypeBreakfast,
      MealType.lunch => s.mealTypeLunch,
      MealType.dinner => s.mealTypeDinner,
      MealType.snack => s.mealTypeSnack,
    };

/// Localized label for a [SymptomType].
String symptomTypeLabel(AppStrings s, SymptomType type) => switch (type) {
      SymptomType.migraine => s.symptomTypeMigraine,
      SymptomType.digestive => s.symptomTypeDigestive,
      SymptomType.mood => s.symptomTypeMood,
      SymptomType.pain => s.symptomTypePain,
    };

/// Localized label for a sleep [quality] score (1-3).
String sleepQualityLabel(AppStrings s, int quality) => switch (quality) {
      1 => s.sleepQualityBad,
      2 => s.sleepQualityMedium,
      _ => s.sleepQualityGood,
    };

/// Suggested detail chips for a [SymptomType]; empty when none apply.
List<String> symptomDetailSuggestions(AppStrings s, SymptomType type) =>
    switch (type) {
      SymptomType.digestive => [
          s.symptomDetailBloating,
          s.symptomDetailPain,
          s.symptomDetailNausea,
        ],
      SymptomType.mood => [
          s.symptomDetailIrritable,
          s.symptomDetailAnxious,
          s.symptomDetailLow,
        ],
      SymptomType.pain => [
          s.symptomDetailBack,
          s.symptomDetailJoint,
          s.symptomDetailMuscle,
        ],
      SymptomType.migraine => const [],
    };
