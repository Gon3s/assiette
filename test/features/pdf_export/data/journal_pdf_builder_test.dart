import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:assiette/features/pdf_export/data/journal_pdf_builder.dart';
import 'package:assiette/features/pdf_export/domain/day_journal_entry.dart';
import 'package:assiette/localization/strings_fr.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  test('build renders a valid PDF for the given entries', () async {
    await initializeDateFormatting('fr');
    final entry = DayJournalEntry(
      date: DateTime(2026, 7).toUtc(),
      meals: [
        JournalMealEntry(
          timestamp: DateTime(2026, 7, 1, 12).toUtc(),
          mealType: MealType.lunch,
          tagLabels: const ['Gluten'],
        ),
      ],
      symptoms: [
        JournalSymptomEntry(
          timestamp: DateTime(2026, 7, 1, 9).toUtc(),
          symptomType: SymptomType.migraine,
          intensity: 7,
        ),
      ],
      sleep: const SleepSummary(quality: 2),
      weather: WeatherSummary(
        timestamp: DateTime(2026, 7, 1, 8).toUtc(),
        pressure: 1013,
      ),
    );

    final bytes = await JournalPdfBuilder().build(
      AppStringsFr(),
      [entry],
      locale: 'fr',
    );

    expect(bytes, isNotEmpty);
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
  });

  test('build renders an empty document when there are no entries', () async {
    final bytes = await JournalPdfBuilder().build(AppStringsFr(), []);

    expect(bytes, isNotEmpty);
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
  });
}
