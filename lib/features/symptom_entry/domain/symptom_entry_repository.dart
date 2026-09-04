import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/symptom_entry/data/symptom_entry_repository.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'symptom_entry_repository.g.dart';

/// Persistence for the symptom entry form: save, edit and delete.
abstract class SymptomEntryRepository {
  /// Inserts the symptom entry and returns its generated id, so callers
  /// can link related records (e.g. medication intakes) to it.
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
  });

  /// Loads the symptom for editing, or `null` if it doesn't exist.
  Future<SymptomDraft?> loadSymptom(String id);

  /// Loads the new-style mood attached to [day], if one exists.
  Future<SymptomDraft?> loadDailyMood(DateTime day);

  /// Replaces the symptom's fields.
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
  });

  /// Soft-deletes the symptom. Linked medication intakes are preserved.
  Future<void> deleteSymptom(String id);

  /// Undoes [deleteSymptom].
  Future<void> undoDeleteSymptom(String id);
}

/// Raised when attempting to create a second unfinished migraine.
class ActiveMigraineExistsException implements Exception {}

/// Raised when attempting to create a second new-style mood for one day.
class DailyMoodExistsException implements Exception {
  DailyMoodExistsException(this.existingId);

  final String existingId;
}

/// Provides the [SymptomEntryRepository] implementation.
@riverpod
SymptomEntryRepository symptomEntryRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftSymptomEntryRepository(db: db);
}
