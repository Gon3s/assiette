import 'package:assiette/constants/app_colors.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:flutter/material.dart';

/// Accent color for a [SymptomType], taken from the app palette
/// (migraine=alert red, digestive=warm yellow, mood=primary blue,
/// pain=turquoise).
Color symptomTypeColor(SymptomType type) => switch (type) {
  SymptomType.migraine => AppColors.alert,
  SymptomType.digestive => AppColors.warning,
  SymptomType.mood => AppColors.primary,
  SymptomType.pain => AppColors.turquoise,
  SymptomType.eczema => AppColors.warning,
};
