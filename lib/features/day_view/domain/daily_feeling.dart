import 'package:assiette/data/db/enums/symptom_type.dart';

/// A non-timed health note attached to one calendar day.
class DailyFeeling {
  const DailyFeeling({
    required this.id,
    required this.type,
    required this.text,
    this.previousIntensity,
  });

  final String id;
  final SymptomType type;
  final String text;
  final int? previousIntensity;
}
