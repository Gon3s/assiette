import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
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
  Future<void> saveSymptom({
    required DateTime timestamp,
    required SymptomType type,
    required int intensity,
    String? detail,
    DateTime? endTime,
    String? note,
  }) {
    final now = DateTime.now().toUtc();
    return _db.symptomsDao.insertSymptom(
      SymptomsCompanion.insert(
        id: _uuid.v4(),
        timestamp: timestamp.toUtc(),
        type: type,
        intensity: intensity,
        detail: Value((detail?.isEmpty ?? true) ? null : detail),
        endTime: Value(endTime?.toUtc()),
        note: Value((note?.isEmpty ?? true) ? null : note),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }
}
