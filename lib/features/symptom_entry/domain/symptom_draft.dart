import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'symptom_draft.freezed.dart';

/// A previously logged symptom, loaded for editing.
@freezed
abstract class SymptomDraft with _$SymptomDraft {
  /// Creates a [SymptomDraft].
  const factory SymptomDraft({
    required String id,
    required DateTime timestamp,
    required SymptomType type,
    required int intensity,
    String? detail,
    DateTime? endTime,
    String? note,
  }) = _SymptomDraft;
}
