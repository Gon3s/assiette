import 'package:assiette/data/daos/environment_dao.dart';
import 'package:assiette/data/daos/meals_dao.dart';
import 'package:assiette/data/daos/medication_intakes_dao.dart';
import 'package:assiette/data/daos/sleep_entries_dao.dart';
import 'package:assiette/data/daos/symptoms_dao.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:assiette/features/pdf_export/domain/day_journal_entry.dart';
import 'package:assiette/features/pdf_export/domain/journal_export_repository.dart';
import 'package:collection/collection.dart';

/// Drift-backed implementation of [JournalExportRepository].
class DriftJournalExportRepository implements JournalExportRepository {
  /// Creates a [DriftJournalExportRepository] backed by the given DAOs.
  DriftJournalExportRepository({
    required MealsDao mealsDao,
    required SymptomsDao symptomsDao,
    required MedicationIntakesDao medicationIntakesDao,
    required SleepEntriesDao sleepEntriesDao,
    required EnvironmentDao environmentDao,
  }) : _mealsDao = mealsDao,
       _symptomsDao = symptomsDao,
       _medicationIntakesDao = medicationIntakesDao,
       _sleepEntriesDao = sleepEntriesDao,
       _environmentDao = environmentDao;

  final MealsDao _mealsDao;
  final SymptomsDao _symptomsDao;
  final MedicationIntakesDao _medicationIntakesDao;
  final SleepEntriesDao _sleepEntriesDao;
  final EnvironmentDao _environmentDao;

  @override
  Future<List<DayJournalEntry>> loadRange(DateTime start, DateTime end) async {
    final rangeStart = _dayStartUtc(start);
    final rangeEnd = _dayStartUtc(end).add(const Duration(days: 1));

    final meals = await _mealsDao.getRangeWithTags(rangeStart, rangeEnd);
    final symptoms = await _symptomsDao.getRange(rangeStart, rangeEnd);
    final intakes = await _medicationIntakesDao.getRange(rangeStart, rangeEnd);
    final sleepEntries = await _sleepEntriesDao.getRange(
      rangeStart,
      rangeEnd,
    );
    final snapshots = await _environmentDao.getRange(rangeStart, rangeEnd);

    final entries = <DayJournalEntry>[];
    for (
      var day = _dayStartUtc(start);
      !day.isAfter(_dayStartUtc(end));
      day = day.add(const Duration(days: 1))
    ) {
      final dayEnd = day.add(const Duration(days: 1));
      final dayMeals = [
        for (final row in meals)
          if (_inRange(row.meal.timestamp, day, dayEnd))
            JournalMealEntry(
              timestamp: row.meal.timestamp,
              mealType: row.meal.mealType,
              tagLabels: [for (final tag in row.tags) tag.label],
              note: row.meal.note,
            ),
      ];
      final daySymptoms = [
        for (final symptom in symptoms)
          if (_inRange(symptom.dailyDate ?? symptom.timestamp, day, dayEnd))
            JournalSymptomEntry(
              timestamp: symptom.dailyDate ?? symptom.timestamp,
              symptomType: symptom.type,
              intensity: symptom.intensity,
              detail: symptom.detail,
              note: symptom.note,
              isDailyNote: symptom.type != SymptomType.migraine,
            ),
      ];
      final dayMedications = [
        for (final intake in intakes)
          if (_inRange(intake.timestamp, day, dayEnd))
            JournalMedicationEntry(
              timestamp: intake.timestamp,
              name: intake.name,
              dose: intake.dose,
            ),
      ];
      final sleepEntry = sleepEntries
          .where((e) => e.nightDate.isAtSameMomentAs(day))
          .firstOrNull;
      final daySnapshots = [
        for (final snapshot in snapshots)
          if (_inRange(snapshot.timestamp, day, dayEnd)) snapshot,
      ];

      final entry = DayJournalEntry(
        date: day,
        meals: dayMeals,
        symptoms: daySymptoms,
        medications: dayMedications,
        sleep: sleepEntry == null
            ? null
            : SleepSummary(
                id: sleepEntry.id,
                quality: sleepEntry.quality,
                bedTime: sleepEntry.bedTime,
                wakeTime: sleepEntry.wakeTime,
              ),
        weather: daySnapshots.isEmpty
            ? null
            : _toWeatherSummary(daySnapshots.last),
      );
      if (entry.hasData) entries.add(entry);
    }
    return entries;
  }

  static bool _inRange(DateTime timestamp, DateTime start, DateTime end) =>
      !timestamp.isBefore(start) && timestamp.isBefore(end);

  static DateTime _dayStartUtc(DateTime date) =>
      DateTime(date.year, date.month, date.day).toUtc();

  static WeatherSummary _toWeatherSummary(EnvironmentSnapshot snapshot) =>
      WeatherSummary(
        timestamp: snapshot.timestamp,
        pressure: snapshot.pressure,
        pressureDelta: snapshot.pressureDelta,
        temperature: snapshot.temperature,
        humidity: snapshot.humidity,
      );
}
