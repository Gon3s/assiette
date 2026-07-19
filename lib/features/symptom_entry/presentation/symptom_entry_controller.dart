import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/medication_entry/domain/medication_entry_repository.dart';
import 'package:assiette/features/medication_entry/domain/medication_intake_draft.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_entry_repository.dart';
import 'package:assiette/features/symptom_entry/presentation/symptom_entry_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'symptom_entry_controller.g.dart';

/// Holds and mutates the symptom entry form, and performs the final save.
@riverpod
class SymptomEntryController extends _$SymptomEntryController {
  @override
  SymptomEntryState build() {
    return SymptomEntryState(
      type: SymptomType.migraine,
      timestamp: DateTime.now(),
    );
  }

  /// Changes the symptom type. The detail is cleared since suggestions
  /// differ per type.
  void setType(SymptomType type) =>
      state = state.copyWith(type: type, detail: null);

  /// Changes the intensity (0-10).
  void setIntensity(int intensity) =>
      state = state.copyWith(intensity: intensity);

  /// Selects or clears a suggested detail (tapping the selected one again
  /// clears it).
  void toggleDetail(String detail) => state = state.copyWith(
    detail: state.detail == detail ? null : detail,
  );

  /// Changes the optional note.
  void setNote(String note) => state = state.copyWith(note: note);

  /// Changes the timestamp (kept local; converted to UTC on save).
  void setTimestamp(DateTime timestamp) =>
      state = state.copyWith(timestamp: timestamp);

  /// Sets the optional end time (kept local; converted to UTC on save).
  void setEndTime(DateTime endTime) =>
      state = state.copyWith(endTime: endTime);

  /// Clears the optional end time.
  void clearEndTime() => state = state.copyWith(endTime: null);

  /// Adds a medication intake to the form (persisted on save).
  void addIntake(MedicationIntakeDraft intake) =>
      state = state.copyWith(intakes: [...state.intakes, intake]);

  /// Removes an intake from the form. Already-persisted intakes are
  /// remembered so save() can soft-delete them.
  void removeIntakeAt(int index) {
    final intake = state.intakes[index];
    state = state.copyWith(
      intakes: [...state.intakes]..removeAt(index),
      removedIntakeIds: [
        ...state.removedIntakeIds,
        if (intake.id != null) intake.id!,
      ],
    );
  }

  /// Seeds the form from a previously logged symptom for editing, then
  /// loads its medication intakes.
  Future<void> loadForEdit(SymptomDraft draft) async {
    state = SymptomEntryState(
      id: draft.id,
      type: draft.type,
      timestamp: draft.timestamp,
      intensity: draft.intensity,
      detail: draft.detail,
      endTime: draft.endTime,
      note: draft.note ?? '',
    );
    final intakes = await ref
        .read(medicationEntryRepositoryProvider)
        .loadIntakesForSymptom(draft.id);
    // The user may have started a fresh form meanwhile; only attach the
    // intakes when the edited symptom is still the one on screen.
    if (state.id == draft.id) {
      state = state.copyWith(intakes: intakes);
    }
  }

  /// Persists the symptom (create or update) and its medication intakes.
  /// Returns true on success.
  Future<bool> save() async {
    if (state.isSaving) return false;
    state = state.copyWith(isSaving: true);
    try {
      final repository = ref.read(symptomEntryRepositoryProvider);
      final id = state.id;
      final String symptomId;
      if (id == null) {
        symptomId = await repository.saveSymptom(
          timestamp: state.timestamp,
          type: state.type,
          intensity: state.intensity,
          detail: state.detail,
          endTime: state.endTime,
          note: state.note,
        );
      } else {
        await repository.updateSymptom(
          id: id,
          timestamp: state.timestamp,
          type: state.type,
          intensity: state.intensity,
          detail: state.detail,
          endTime: state.endTime,
          note: state.note,
        );
        symptomId = id;
      }
      final medicationRepository =
          ref.read(medicationEntryRepositoryProvider);
      for (final intake in state.intakes) {
        if (intake.id == null) {
          await medicationRepository.saveIntake(
            timestamp: intake.timestamp,
            name: intake.name,
            dose: intake.dose,
            symptomId: symptomId,
          );
        }
      }
      for (final removedId in state.removedIntakeIds) {
        await medicationRepository.deleteIntake(removedId);
      }
      return true;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }

  /// Soft-deletes the symptom being edited. Returns false when creating
  /// (no id yet) or while another save/delete is in flight.
  Future<bool> delete() async {
    final id = state.id;
    if (id == null || state.isSaving) return false;
    state = state.copyWith(isSaving: true);
    try {
      await ref.read(symptomEntryRepositoryProvider).deleteSymptom(id);
      return true;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}
