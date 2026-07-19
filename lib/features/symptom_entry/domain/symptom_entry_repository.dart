import 'package:assiette/data/db/database_provider.dart';
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
    required int intensity,
    String? detail,
    DateTime? endTime,
    String? note,
  });

  /// Loads the symptom for editing, or `null` if it doesn't exist.
  Future<SymptomDraft?> loadSymptom(String id);

  /// Replaces the symptom's fields.
  Future<void> updateSymptom({
    required String id,
    required DateTime timestamp,
    required SymptomType type,
    required int intensity,
    String? detail,
    DateTime? endTime,
    String? note,
  });

  /// Soft-deletes the symptom and the medication intakes linked to it.
  Future<void> deleteSymptom(String id);

  /// Undoes [deleteSymptom], restoring the linked medication intakes too.
  Future<void> undoDeleteSymptom(String id);
}

/// Provides the [SymptomEntryRepository] implementation.
@riverpod
SymptomEntryRepository symptomEntryRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftSymptomEntryRepository(db: db);
}
