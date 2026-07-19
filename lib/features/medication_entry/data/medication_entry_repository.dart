import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/medication_entry/domain/medication_entry_repository.dart';
import 'package:assiette/features/medication_entry/domain/medication_intake_draft.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Drift-backed implementation of [MedicationEntryRepository].
class DriftMedicationEntryRepository implements MedicationEntryRepository {
  /// Creates a [DriftMedicationEntryRepository].
  DriftMedicationEntryRepository({required AppDatabase db}) : _db = db;

  final AppDatabase _db;

  static const _uuid = Uuid();

  @override
  Future<void> saveIntake({
    required DateTime timestamp,
    required String name,
    String? dose,
    String? symptomId,
    String? note,
  }) {
    final now = DateTime.now().toUtc();
    return _db.medicationIntakesDao.insertIntake(
      MedicationIntakesCompanion.insert(
        id: _uuid.v4(),
        timestamp: timestamp.toUtc(),
        name: name.trim(),
        dose: Value((dose?.trim().isEmpty ?? true) ? null : dose!.trim()),
        symptomId: Value(symptomId),
        note: Value((note?.isEmpty ?? true) ? null : note),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<List<MedicationIntakeDraft>> loadIntakesForSymptom(
    String symptomId,
  ) async {
    final intakes =
        await _db.medicationIntakesDao.getBySymptomId(symptomId);
    return [
      for (final intake in intakes)
        MedicationIntakeDraft(
          id: intake.id,
          timestamp: intake.timestamp,
          name: intake.name,
          dose: intake.dose,
          symptomId: intake.symptomId,
        ),
    ];
  }

  @override
  Future<void> deleteIntake(String id) =>
      _db.medicationIntakesDao.softDeleteIntake(id);

  @override
  Future<void> undoDeleteIntake(String id) =>
      _db.medicationIntakesDao.restoreIntake(id);

  @override
  Future<List<String>> recentNames() =>
      _db.medicationIntakesDao.getDistinctNames();
}
