import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/medication_entry/data/medication_entry_repository.dart';
import 'package:assiette/features/medication_entry/domain/medication_intake_draft.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medication_entry_repository.g.dart';

/// Persistence for medication intakes: save, list, delete.
///
/// Intakes are generic: a free-text name (no hardcoded drug list) and an
/// optional link to the symptom (crisis) they were taken for.
abstract class MedicationEntryRepository {
  /// Inserts an intake, optionally linked to a symptom.
  Future<void> saveIntake({
    required DateTime timestamp,
    required String name,
    String? dose,
    String? symptomId,
    String? note,
  });

  /// Loads the intakes linked to [symptomId], oldest first.
  Future<List<MedicationIntakeDraft>> loadIntakesForSymptom(String symptomId);

  /// Soft-deletes the intake.
  Future<void> deleteIntake(String id);

  /// Undoes [deleteIntake].
  Future<void> undoDeleteIntake(String id);

  /// Distinct medication names already used, most recent first, for
  /// suggestion chips. Empty until the user logs a first intake.
  Future<List<String>> recentNames();
}

/// Provides the [MedicationEntryRepository] implementation.
@riverpod
MedicationEntryRepository medicationEntryRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftMedicationEntryRepository(db: db);
}

/// Recent medication names, for the suggestion chips of the symptom form.
@riverpod
Future<List<String>> recentMedicationNames(Ref ref) =>
    ref.watch(medicationEntryRepositoryProvider).recentNames();
