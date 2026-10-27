import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'migraine_history_entry.freezed.dart';

@freezed
abstract class MigraineHistoryEntry with _$MigraineHistoryEntry {
  const factory MigraineHistoryEntry({
    required SymptomDraft migraine,
    required List<MigraineHistoryIntake> intakes,
  }) = _MigraineHistoryEntry;
}

@freezed
abstract class MigraineHistoryIntake with _$MigraineHistoryIntake {
  const factory MigraineHistoryIntake({
    required String id,
    required String name,
    required DateTime timestamp,
    String? dose,
  }) = _MigraineHistoryIntake;
}
