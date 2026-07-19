import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timeline_item.freezed.dart';

/// A single entry shown on the day view timeline: a meal, a symptom or a
/// medication intake, all sharing an [id] and [timestamp] so they can be
/// merged and sorted chronologically.
@freezed
sealed class TimelineItem with _$TimelineItem {
  /// A logged meal.
  const factory TimelineItem.meal({
    required String id,
    required DateTime timestamp,
    required MealType mealType,
    required List<String> tagLabels,
    String? photoPath,
  }) = MealTimelineItem;

  /// A logged symptom.
  const factory TimelineItem.symptom({
    required String id,
    required DateTime timestamp,
    required SymptomType symptomType,
    required int intensity,
    String? detail,
  }) = SymptomTimelineItem;

  /// A logged medication intake (US-20).
  const factory TimelineItem.medication({
    required String id,
    required DateTime timestamp,
    required String name,
    String? dose,
  }) = MedicationTimelineItem;
}
