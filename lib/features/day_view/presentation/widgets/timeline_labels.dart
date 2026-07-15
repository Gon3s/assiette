import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:flutter/material.dart';

/// Accent color for a [SymptomType] (migraine=red, digestive=amber,
/// mood=blue).
Color symptomTypeColor(SymptomType type) => switch (type) {
      SymptomType.migraine => Colors.red,
      SymptomType.digestive => Colors.amber,
      SymptomType.mood => Colors.blue,
    };
