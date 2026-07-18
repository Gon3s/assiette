import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'day_journal_entry.freezed.dart';

/// A single logged meal, as shown in the PDF export.
@freezed
abstract class JournalMealEntry with _$JournalMealEntry {
  /// Creates a [JournalMealEntry].
  const factory JournalMealEntry({
    required DateTime timestamp,
    required MealType mealType,
    required List<String> tagLabels,
    String? note,
  }) = _JournalMealEntry;
}

/// A single logged symptom, as shown in the PDF export.
@freezed
abstract class JournalSymptomEntry with _$JournalSymptomEntry {
  /// Creates a [JournalSymptomEntry].
  const factory JournalSymptomEntry({
    required DateTime timestamp,
    required SymptomType symptomType,
    required int intensity,
    String? detail,
    String? note,
  }) = _JournalSymptomEntry;
}

/// Everything logged on a single day, aggregated for the PDF export.
@freezed
abstract class DayJournalEntry with _$DayJournalEntry {
  /// Creates a [DayJournalEntry].
  const factory DayJournalEntry({
    required DateTime date,
    required List<JournalMealEntry> meals,
    required List<JournalSymptomEntry> symptoms,
    SleepSummary? sleep,
    WeatherSummary? weather,
  }) = _DayJournalEntry;

  const DayJournalEntry._();

  /// Whether anything was logged this day.
  bool get hasData =>
      meals.isNotEmpty || symptoms.isNotEmpty || sleep != null ||
      weather != null;
}
