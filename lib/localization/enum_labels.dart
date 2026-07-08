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
    };
