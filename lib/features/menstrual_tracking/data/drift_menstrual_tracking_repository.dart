import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/menstrual_tracking/domain/menstrual_observation.dart';
import 'package:assiette/features/menstrual_tracking/domain/menstrual_tracking_repository.dart';
import 'package:drift/drift.dart';

class DriftMenstrualTrackingRepository implements MenstrualTrackingRepository {
  DriftMenstrualTrackingRepository(this._db, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _now;

  static MenstrualPreferences _preferences(AppSetting? row) =>
      MenstrualPreferences(
        enabled: row?.menstrualTrackingEnabled ?? false,
        includeInBackup: row?.menstrualBackupEnabled ?? false,
        includeInPdf: row?.menstrualPdfEnabled ?? false,
      );

  @override
  Stream<MenstrualPreferences> watchPreferences() =>
      _db.appSettingsDao.watchNotificationSettingsRow().map(_preferences);

  @override
  Future<MenstrualPreferences> getPreferences() => watchPreferences().first;

  @override
  Future<void> setPreferences(MenstrualPreferences preferences) async {
    await _db
        .into(_db.appSettings)
        .insertOnConflictUpdate(
          AppSettingsCompanion.insert(
            id: const Value(0),
            menstrualTrackingEnabled: Value(preferences.enabled),
            menstrualBackupEnabled: Value(preferences.includeInBackup),
            menstrualPdfEnabled: Value(preferences.includeInPdf),
          ),
        );
  }

  static MenstrualObservation observationFromRow(MenstrualDay row) =>
      MenstrualObservation(
        localDate: row.localDate,
        status: BleedingStatus.values.byName(row.bleedingStatus),
        flow: row.flow == null ? null : MenstrualFlow.values.byName(row.flow!),
        isPeriodStart: row.isPeriodStart,
        note: row.note,
      );

  @override
  Stream<MenstrualObservation?> watchDay(String date) {
    parseMenstrualDate(date);
    return _db.menstrualDaysDao
        .watchDay(date)
        .map(
          (row) => row == null ? null : observationFromRow(row),
        );
  }

  @override
  Future<List<MenstrualObservation>> getRange(String start, String end) async {
    parseMenstrualDate(start);
    parseMenstrualDate(end);
    return (await _db.menstrualDaysDao.getRange(
      start,
      end,
    )).map(observationFromRow).toList();
  }

  @override
  Future<void> save(MenstrualObservation observation) =>
      _db.transaction(() async {
        validateMenstrualObservation(observation);
        if (observation.localDate.compareTo(menstrualDateKey(_now())) > 0) {
          throw const FormatException('Future observation');
        }
        if (!(await getPreferences()).enabled) {
          throw StateError('Menstrual tracking is disabled');
        }
        final existing = await _db.menstrualDaysDao.getIncludingDeleted(
          observation.localDate,
        );
        final now = _now().toUtc();
        final note = observation.note?.trim();
        await _db.menstrualDaysDao.upsert(
          MenstrualDaysCompanion.insert(
            localDate: observation.localDate,
            bleedingStatus: observation.status.name,
            flow: Value(observation.flow?.name),
            isPeriodStart: Value(observation.isPeriodStart),
            note: Value(note == null || note.isEmpty ? null : note),
            createdAt: Value(existing?.createdAt ?? now),
            updatedAt: Value(now),
            deletedAt: const Value(null),
          ),
        );
      });

  @override
  Future<void> delete(String date) {
    parseMenstrualDate(date);
    return _db.menstrualDaysDao.softDelete(date, _now().toUtc());
  }

  @override
  Future<void> purge() => _db.transaction(() async {
    await _db.menstrualDaysDao.purge();
    await setPreferences(const MenstrualPreferences());
  });
}
