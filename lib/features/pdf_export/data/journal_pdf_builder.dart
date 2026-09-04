import 'dart:typed_data';

import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:assiette/features/pdf_export/domain/day_journal_entry.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/localization/enum_labels.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Builds the printable/shareable journal PDF for a date range (US-17).
class JournalPdfBuilder {
  static final _sectionStyle = pw.TextStyle(
    fontSize: 11,
    fontWeight: pw.FontWeight.bold,
  );

  /// Renders [entries] into a PDF document, one section per day, and
  /// returns the resulting bytes. [locale] drives date/time formatting,
  /// matching the app's current locale.
  Future<Uint8List> build(
    AppStrings s,
    List<DayJournalEntry> entries, {
    String? locale,
  }) async {
    final dateFormat = DateFormat.MMMMEEEEd(locale);
    final timeFormat = DateFormat.Hm(locale);
    final doc = pw.Document()
      ..addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          header: (context) => context.pageNumber == 1
              ? pw.Text(
                  s.pdfDocTitle,
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                )
              : pw.SizedBox.shrink(),
          build: (context) => [
            for (final entry in entries)
              _daySection(s, entry, dateFormat, timeFormat),
          ],
        ),
      );

    return doc.save();
  }

  pw.Widget _daySection(
    AppStrings s,
    DayJournalEntry entry,
    DateFormat dateFormat,
    DateFormat timeFormat,
  ) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 16),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            _capitalize(dateFormat.format(entry.date.toLocal())),
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.Divider(thickness: 0.5),
          if (entry.meals.isNotEmpty)
            ..._mealsSection(s, entry.meals, timeFormat),
          if (entry.symptoms.isNotEmpty)
            ..._symptomsSection(s, entry.symptoms, timeFormat),
          if (entry.medications.isNotEmpty)
            ..._medicationsSection(s, entry.medications, timeFormat),
          if (entry.sleep != null) _sleepLine(s, entry.sleep!),
          if (entry.weather != null) _weatherLine(s, entry.weather!),
        ],
      ),
    );
  }

  List<pw.Widget> _mealsSection(
    AppStrings s,
    List<JournalMealEntry> meals,
    DateFormat timeFormat,
  ) {
    return [
      pw.Text(s.pdfSectionMeals, style: _sectionStyle),
      for (final meal in meals)
        pw.Bullet(
          text: [
            timeFormat.format(meal.timestamp.toLocal()),
            mealTypeLabel(s, meal.mealType),
            if (meal.tagLabels.isNotEmpty) meal.tagLabels.join(', '),
          ].join(' - '),
        ),
    ];
  }

  List<pw.Widget> _symptomsSection(
    AppStrings s,
    List<JournalSymptomEntry> symptoms,
    DateFormat timeFormat,
  ) {
    return [
      pw.Text(s.pdfSectionSymptoms, style: _sectionStyle),
      for (final symptom in symptoms)
        pw.Bullet(
          text: [
            if (!symptom.isDailyNote)
              timeFormat.format(symptom.timestamp.toLocal()),
            symptomTypeLabel(s, symptom.symptomType),
            if (symptom.intensity case final intensity?)
              symptom.isDailyNote
                  ? s.previousIntensity(intensity)
                  : '${s.intensityLabel} $intensity/10',
            if (symptom.detail != null) symptom.detail!,
            if (symptom.note != null) symptom.note!,
          ].join(' - '),
        ),
    ];
  }

  List<pw.Widget> _medicationsSection(
    AppStrings s,
    List<JournalMedicationEntry> medications,
    DateFormat timeFormat,
  ) {
    return [
      pw.Text(s.pdfSectionMedications, style: _sectionStyle),
      for (final medication in medications)
        pw.Bullet(
          text: [
            timeFormat.format(medication.timestamp.toLocal()),
            medication.name,
            if (medication.dose != null) medication.dose!,
          ].join(' - '),
        ),
    ];
  }

  pw.Widget _sleepLine(AppStrings s, SleepSummary sleep) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 4),
      child: pw.Text(
        '${s.sleepCardTitle} : ${sleepQualityLabel(s, sleep.quality)}',
      ),
    );
  }

  pw.Widget _weatherLine(AppStrings s, WeatherSummary weather) {
    final pressure = weather.pressure;
    if (pressure == null) return pw.SizedBox.shrink();
    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 4),
      child: pw.Text(
        '${s.pdfSectionWeather} : '
        '${pressure.toStringAsFixed(0)} ${s.pressureUnit}',
      ),
    );
  }

  static String _capitalize(String value) =>
      value.isEmpty ? value : value[0].toUpperCase() + value.substring(1);
}
