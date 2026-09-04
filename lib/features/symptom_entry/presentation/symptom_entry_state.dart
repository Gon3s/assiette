import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/medication_entry/domain/medication_intake_draft.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'symptom_entry_state.freezed.dart';

/// Form state of the symptom entry screen.
@freezed
abstract class SymptomEntryState with _$SymptomEntryState {
  /// Creates a [SymptomEntryState].
  const factory SymptomEntryState({
    required SymptomType type,
    required DateTime timestamp,
    @Default(5) int intensity,
    String? detail,
    @Default('') String note,
    DateTime? endTime,
    int? maximumIntensity,
    DateTime? dailyDate,
    @Default(MigraineStartPrecision.exact)
    MigraineStartPrecision startPrecision,
    @Default(false) bool isDailyNote,
    int? previousIntensity,
    @Default(<MedicationIntakeDraft>[]) List<MedicationIntakeDraft> intakes,
    @Default(<String>[]) List<String> removedIntakeIds,
    @Default(false) bool isSaving,
    String? id,
  }) = _SymptomEntryState;
}
