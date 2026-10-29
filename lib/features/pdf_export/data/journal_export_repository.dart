import 'package:assiette/data/daos/environment_dao.dart';
import 'package:assiette/data/daos/meals_dao.dart';
import 'package:assiette/data/daos/medication_intakes_dao.dart';
import 'package:assiette/data/daos/sleep_entries_dao.dart';
import 'package:assiette/data/daos/symptoms_dao.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:assiette/features/menstrual_tracking/domain/menstrual_observation.dart';
import 'package:assiette/features/menstrual_tracking/domain/menstrual_tracking_repository.dart';
import 'package:assiette/features/pdf_export/domain/day_journal_entry.dart';
import 'package:assiette/features/pdf_export/domain/journal_export_repository.dart';
import 'package:collection/collection.dart';

/// Drift-backed implementation of [JournalExportRepository].
class DriftJournalExportRepository implements JournalExportRepository {
  /// Creates a [DriftJournalExportRepository] backed by the given DAOs.
  DriftJournalExportRepository({
    required this._mealsDao,
    required this._symptomsDao,
    required this._medicationIntakesDao,
    required this._sleepEntriesDao,
    required this._environmentDao,
    this._menstrualRepository,
  });

  final MealsDao _mealsDao;
  final SymptomsDao _symptomsDao;
  final MedicationIntakesDao _medicationIntakesDao;
  final SleepEntriesDao _sleepEntriesDao;
  final EnvironmentDao _environmentDao;
  final MenstrualTrackingRepository? _menstrualRepository;

  @override
  Future<List<DayJournalEntry>> loadRange(DateTime start, DateTime end) async {
    final rangeStart = _dayStartUtc(start);
    final rangeEnd = DateTime(end.year, end.month, end.day + 1).toUtc();

    final meals = await _mealsDao.getRangeWithTags(rangeStart, rangeEnd);
    final symptoms = await _symptomsDao.getRange(rangeStart, rangeEnd);
    final intakes = await _medicationIntakesDao.getRange(rangeStart, rangeEnd);
    final sleepEntries = await _sleepEntriesDao.getRange(
      rangeStart,
      rangeEnd,
    );
    final snapshots = await _environmentDao.getRange(rangeStart, rangeEnd);
    final menstrualRepository = _menstrualRepository;
    final menstrual =
        menstrualRepository != null &&
            (await menstrualRepository.getPreferences()).includeInPdf
        ? await menstrualRepository.getRange(
            menstrualDateKey(start),
            menstrualDateKey(end),
          )
        : <MenstrualObservation>[];

    final entries = <DayJournalEntry>[];
    for (
      var localDay = DateTime(start.year, start.month, start.day);
      !localDay.isAfter(DateTime(end.year, end.month, end.day));
      localDay = DateTime(localDay.year, localDay.month, localDay.day + 1)
    ) {
      final day = localDay.toUtc();
      final dayEnd = DateTime(
        localDay.year,
        localDay.month,
        localDay.day + 1,
      ).toUtc();
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
      final localDate = localDay;
      final utcNightDate = DateTime.utc(
        localDate.year,
        localDate.month,
        localDate.day,
      );
      final canonicalSleep = sleepEntries
          .where((entry) => entry.nightDate.isAtSameMomentAs(utcNightDate))
          .firstOrNull;
      final sleepEntry =
          canonicalSleep ??
          sleepEntries
              .where(
                (entry) =>
                    entry.nightDate.isAtSameMomentAs(day) ||
                    (_hasLegacySleepKey(entry) &&
                        entry.bedTime != null &&
                        _inRange(
                          entry.bedTime!,
                          day,
                          day.add(const Duration(days: 1)),
                        )),
              )
              .firstOrNull;
      final daySnapshots = [
        for (final snapshot in snapshots)
          if (_inRange(snapshot.timestamp, day, dayEnd)) snapshot,
      ];

      final entry = DayJournalEntry(
        menstrual: menstrual
            .where(
              (row) => row.localDate == menstrualDateKey(localDate),
            )
            .firstOrNull,
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
                note: sleepEntry.note,
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

  static bool _hasLegacySleepKey(SleepEntry entry) {
    final key = entry.nightDate.toUtc();
    return key != DateTime.utc(key.year, key.month, key.day);
  }

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
