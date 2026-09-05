import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/symptom_entry/domain/migraine_observation.dart';
import 'package:assiette/features/symptom_entry/domain/migraine_observation_repository.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Drift-backed migraine observation storage.
class DriftMigraineObservationRepository
    implements MigraineObservationRepository {
  /// Creates a repository backed by the local database.
  DriftMigraineObservationRepository(this._db);

  final AppDatabase _db;

  static const _uuid = Uuid();

  @override
  Stream<List<MigraineObservation>> watchObservations(String migraineId) => _db
      .migraineIntensityMeasurementsDao
      .watchForMigraine(migraineId)
      .map((rows) => rows.map(_toDomain).toList(growable: false));

  @override
  Future<String> addObservation(
    String migraineId,
    MigraineObservationInput input,
  ) async {
    _validate(input);
    final id = _uuid.v4();
    final now = DateTime.now().toUtc();
    await _db.transaction(() async {
      await _db.migraineIntensityMeasurementsDao.insertMeasurement(
        MigraineIntensityMeasurementsCompanion.insert(
          id: id,
          symptomId: migraineId,
          timestamp: input.timestamp.toUtc(),
          intensity: input.intensity,
          laterality: Value(input.laterality),
          location: Value(input.location),
          aura: Value(input.aura),
          nausea: Value(input.nausea),
          photophobia: Value(input.photophobia),
          phonophobia: Value(input.phonophobia),
          note: Value(_normalizedNote(input.note)),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      await _refreshEpisodeIntensities(migraineId, now);
    });
    return id;
  }

  @override
  Future<void> updateObservation(
    String id,
    MigraineObservationInput input,
  ) async {
    _validate(input);
    final row = await (_db.select(
      _db.migraineIntensityMeasurements,
    )..where((item) => item.id.equals(id))).getSingleOrNull();
    if (row == null) return;
    final now = DateTime.now().toUtc();
    await _db.transaction(() async {
      await _db.migraineIntensityMeasurementsDao.updateMeasurement(
        id,
        MigraineIntensityMeasurementsCompanion(
          timestamp: Value(input.timestamp.toUtc()),
          intensity: Value(input.intensity),
          laterality: Value(input.laterality),
          location: Value(input.location),
          aura: Value(input.aura),
          nausea: Value(input.nausea),
          photophobia: Value(input.photophobia),
          phonophobia: Value(input.phonophobia),
          note: Value(_normalizedNote(input.note)),
          updatedAt: Value(now),
        ),
      );
      await _refreshEpisodeIntensities(row.symptomId, now);
    });
  }

  @override
  Future<void> deleteObservation(String id) async {
    final row = await (_db.select(
      _db.migraineIntensityMeasurements,
    )..where((item) => item.id.equals(id))).getSingleOrNull();
    if (row == null) return;
    final now = DateTime.now().toUtc();
    await _db.transaction(() async {
      await _db.migraineIntensityMeasurementsDao.softDeleteMeasurement(id);
      await _refreshEpisodeIntensities(row.symptomId, now);
    });
  }

  @override
  Future<void> undoDeleteObservation(String id) async {
    final row = await (_db.select(
      _db.migraineIntensityMeasurements,
    )..where((item) => item.id.equals(id))).getSingleOrNull();
    if (row == null) return;
    final now = DateTime.now().toUtc();
    await _db.transaction(() async {
      await _db.migraineIntensityMeasurementsDao.restoreMeasurement(id);
      await _refreshEpisodeIntensities(row.symptomId, now);
    });
  }

  Future<void> _refreshEpisodeIntensities(
    String migraineId,
    DateTime now,
  ) async {
    final rows = await _db.migraineIntensityMeasurementsDao.getForMigraine(
      migraineId,
    );
    final initial = rows.firstOrNull?.intensity;
    final maximum = rows.isEmpty
        ? null
        : rows
              .map((row) => row.intensity)
              .reduce(
                (current, value) => value > current ? value : current,
              );
    await _db.symptomsDao.updateSymptom(
      migraineId,
      SymptomsCompanion(
        intensity: Value(initial),
        initialIntensity: Value(initial),
        maximumIntensity: Value(maximum),
        updatedAt: Value(now),
      ),
    );
  }

  static MigraineObservation _toDomain(MigraineIntensityMeasurement row) =>
      MigraineObservation(
        id: row.id,
        migraineId: row.symptomId,
        timestamp: row.timestamp,
        intensity: row.intensity,
        laterality: row.laterality,
        location: row.location,
        aura: row.aura,
        nausea: row.nausea,
        photophobia: row.photophobia,
        phonophobia: row.phonophobia,
        note: row.note,
      );

  static void _validate(MigraineObservationInput input) {
    if (input.intensity < 0 || input.intensity > 10) {
      throw ArgumentError.value(
        input.intensity,
        'intensity',
        'must be between 0 and 10',
      );
    }
  }

  static String? _normalizedNote(String? note) {
    final value = note?.trim();
    return value == null || value.isEmpty ? null : value;
  }
}
