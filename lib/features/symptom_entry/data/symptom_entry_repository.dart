import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_entry_repository.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Drift-backed implementation of [SymptomEntryRepository].
class DriftSymptomEntryRepository implements SymptomEntryRepository {
  /// Creates a [DriftSymptomEntryRepository].
  DriftSymptomEntryRepository({required AppDatabase db}) : _db = db;

  final AppDatabase _db;

  static const _uuid = Uuid();

  @override
  Future<String> saveSymptom({
    required DateTime timestamp,
    required SymptomType type,
    int? intensity,
    String? detail,
    DateTime? endTime,
    DateTime? startedAt,
    MigraineStartPrecision? startPrecision,
    DateTime? endedAt,
    int? initialIntensity,
    int? maximumIntensity,
    String? note,
    DateTime? dailyDate,
    bool isDailyNote = false,
  }) async {
    if (type == SymptomType.migraine &&
        await _db.symptomsDao.getActiveMigraine() != null) {
      throw ActiveMigraineExistsException();
    }
    if (type == SymptomType.mood && isDailyNote && dailyDate != null) {
      final existing = await _db.symptomsDao.getDailyMood(dailyDate);
      if (existing != null) throw DailyMoodExistsException(existing.id);
    }
    final episode = _migraineEpisodeFields(
      timestamp: timestamp,
      type: type,
      intensity: intensity,
      endTime: endTime,
      startedAt: startedAt,
      startPrecision: startPrecision,
      endedAt: endedAt,
      initialIntensity: initialIntensity,
      maximumIntensity: maximumIntensity,
    );
    final now = DateTime.now().toUtc();
    final id = _uuid.v4();
    await _db.transaction(() async {
      await _db.symptomsDao.insertSymptom(
        SymptomsCompanion.insert(
          id: id,
          timestamp: episode?.startedAt ?? timestamp.toUtc(),
          type: type,
          intensity: Value(episode?.initialIntensity ?? intensity),
          detail: Value((detail?.isEmpty ?? true) ? null : detail),
          endTime: Value(episode?.endedAt ?? endTime?.toUtc()),
          startedAt: Value(episode?.startedAt),
          startPrecision: Value(episode?.startPrecision),
          endedAt: Value(episode?.endedAt),
          initialIntensity: Value(episode?.initialIntensity),
          maximumIntensity: Value(episode?.maximumIntensity),
          note: Value((note?.isEmpty ?? true) ? null : note),
          dailyDate: Value(dailyDate == null ? null : _dayKey(dailyDate)),
          isDailyNote: Value(isDailyNote),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      if (episode != null) {
        await _db.migraineIntensityMeasurementsDao.insertMeasurement(
          MigraineIntensityMeasurementsCompanion.insert(
            id: _uuid.v4(),
            symptomId: id,
            timestamp: episode.startedAt ?? now,
            intensity: episode.initialIntensity,
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
      }
    });
    return id;
  }

  @override
  Future<SymptomDraft?> loadSymptom(String id) async {
    final symptom = await _db.symptomsDao.getSymptomById(id);
    if (symptom == null) return null;
    return _toDraft(symptom);
  }

  @override
  Future<SymptomDraft?> loadDailyMood(DateTime day) async {
    final symptom = await _db.symptomsDao.getDailyMood(day);
    return symptom == null ? null : _toDraft(symptom);
  }

  SymptomDraft _toDraft(Symptom symptom) => SymptomDraft(
    id: symptom.id,
    timestamp: symptom.timestamp,
    type: symptom.type,
    intensity: symptom.intensity,
    detail: symptom.detail,
    endTime: symptom.endTime,
    startedAt: symptom.startedAt,
    startPrecision: symptom.startPrecision,
    endedAt: symptom.endedAt,
    initialIntensity: symptom.initialIntensity,
    maximumIntensity: symptom.maximumIntensity,
    note: symptom.note,
    dailyDate: symptom.dailyDate,
    isDailyNote: symptom.isDailyNote,
  );

  @override
  Future<void> updateSymptom({
    required String id,
    required DateTime timestamp,
    required SymptomType type,
    int? intensity,
    String? detail,
    DateTime? endTime,
    DateTime? startedAt,
    MigraineStartPrecision? startPrecision,
    DateTime? endedAt,
    int? initialIntensity,
    int? maximumIntensity,
    String? note,
    DateTime? dailyDate,
    bool isDailyNote = false,
  }) {
    final episode = _migraineEpisodeFields(
      timestamp: timestamp,
      type: type,
      intensity: intensity,
      endTime: endTime,
      startedAt: startedAt,
      startPrecision: startPrecision,
      endedAt: endedAt,
      initialIntensity: initialIntensity,
      maximumIntensity: maximumIntensity,
    );
    return _db.symptomsDao.updateSymptom(
      id,
      SymptomsCompanion(
        timestamp: Value(episode?.startedAt ?? timestamp.toUtc()),
        type: Value(type),
        intensity: Value(episode?.initialIntensity ?? intensity),
        detail: Value((detail?.isEmpty ?? true) ? null : detail),
        endTime: Value(episode?.endedAt ?? endTime?.toUtc()),
        startedAt: Value(episode?.startedAt),
        startPrecision: Value(episode?.startPrecision),
        endedAt: Value(episode?.endedAt),
        initialIntensity: Value(episode?.initialIntensity),
        maximumIntensity: Value(episode?.maximumIntensity),
        note: Value((note?.isEmpty ?? true) ? null : note),
        dailyDate: Value(dailyDate == null ? null : _dayKey(dailyDate)),
        isDailyNote: Value(isDailyNote),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  @override
  Future<void> deleteSymptom(String id) async {
    await _db.symptomsDao.softDeleteSymptom(id);
  }

  @override
  Future<void> undoDeleteSymptom(String id) async {
    await _db.symptomsDao.restoreSymptom(id);
  }
}

_MigraineEpisodeFields? _migraineEpisodeFields({
  required DateTime timestamp,
  required SymptomType type,
  required int? intensity,
  required DateTime? endTime,
  required DateTime? startedAt,
  required MigraineStartPrecision? startPrecision,
  required DateTime? endedAt,
  required int? initialIntensity,
  required int? maximumIntensity,
}) {
  if (type != SymptomType.migraine) return null;

  final precision = startPrecision ?? MigraineStartPrecision.approximate;
  final start = precision == MigraineStartPrecision.unknown
      ? startedAt?.toUtc()
      : (startedAt ?? timestamp).toUtc();
  final end = (endedAt ?? endTime)?.toUtc();
  final initial = initialIntensity ?? intensity;

  if (initial == null) {
    throw ArgumentError.notNull('intensity');
  }

  if (initial < 0 || initial > 10) {
    throw ArgumentError.value(
      initial,
      'initialIntensity',
      'must be between 0 and 10',
    );
  }
  if (maximumIntensity != null &&
      (maximumIntensity < initial || maximumIntensity > 10)) {
    throw ArgumentError.value(
      maximumIntensity,
      'maximumIntensity',
      'must be between initialIntensity and 10',
    );
  }
  if (end != null && (start == null || end.isBefore(start))) {
    throw ArgumentError.value(
      endedAt ?? endTime,
      'endedAt',
      'must not be before startedAt',
    );
  }

  return _MigraineEpisodeFields(
    startedAt: start,
    startPrecision: precision,
    endedAt: end,
    initialIntensity: initial,
    maximumIntensity: maximumIntensity,
  );
}

DateTime _dayKey(DateTime date) =>
    DateTime(date.year, date.month, date.day).toUtc();

class _MigraineEpisodeFields {
  const _MigraineEpisodeFields({
    required this.startedAt,
    required this.startPrecision,
    required this.endedAt,
    required this.initialIntensity,
    required this.maximumIntensity,
  });

  final DateTime? startedAt;
  final MigraineStartPrecision startPrecision;
  final DateTime? endedAt;
  final int initialIntensity;
  final int? maximumIntensity;
}
