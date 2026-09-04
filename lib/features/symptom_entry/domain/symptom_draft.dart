import 'package:assiette/data/db/enums/migraine_start_precision.dart';
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
    @Default(false) bool isDailyNote,
  }) = _SymptomDraft;
}
