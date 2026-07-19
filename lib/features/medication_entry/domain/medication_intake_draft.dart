import 'package:freezed_annotation/freezed_annotation.dart';

part 'medication_intake_draft.freezed.dart';

/// A medication intake attached to the symptom form: either already
/// persisted ([id] set) or newly added and pending save ([id] null).
@freezed
abstract class MedicationIntakeDraft with _$MedicationIntakeDraft {
  /// Creates a [MedicationIntakeDraft].
  const factory MedicationIntakeDraft({
    required DateTime timestamp,
    required String name,
    String? dose,
    String? id,
    String? symptomId,
  }) = _MedicationIntakeDraft;
}
