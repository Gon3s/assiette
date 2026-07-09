import 'package:assiette/data/db/enums/symptom_type.dart';
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

  /// Persists the symptom. Returns true on success.
  Future<bool> save() async {
    if (state.isSaving) return false;
    state = state.copyWith(isSaving: true);
    try {
      await ref
          .read(symptomEntryRepositoryProvider)
          .saveSymptom(
            timestamp: state.timestamp,
            type: state.type,
            intensity: state.intensity,
            detail: state.detail,
            endTime: state.endTime,
            note: state.note,
          );
      return true;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}
