import 'package:assiette/data/daos/symptoms_dao.dart';
import 'package:assiette/features/migraine_history/domain/migraine_history_entry.dart';
import 'package:assiette/features/migraine_history/domain/migraine_history_repository.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';

class DriftMigraineHistoryRepository implements MigraineHistoryRepository {
  DriftMigraineHistoryRepository({required this._symptomsDao});

  final SymptomsDao _symptomsDao;

  @override
  Stream<List<MigraineHistoryEntry>> watchHistory() =>
      _symptomsDao.watchMigrainesWithIntakes().map((rows) {
        final entries = <String, MigraineHistoryEntry>{};
        final intakes = <String, List<MigraineHistoryIntake>>{};
        for (final row in rows) {
          final symptom = row.migraine;
          entries.putIfAbsent(
            symptom.id,
            () => MigraineHistoryEntry(
              migraine: SymptomDraft(
                id: symptom.id,
                timestamp: symptom.timestamp,
                type: symptom.type,
                intensity: symptom.intensity,
                detail: symptom.detail,
                endTime: symptom.endTime,
                startedAt: symptom.startedAt,
                startPrecision: symptom.startPrecision,
                endedAt: symptom.endedAt,
                initialIntensity: symptom.initialIntensity,
                maximumIntensity: symptom.maximumIntensity,
                note: symptom.note,
                dailyDate: symptom.dailyDate,
                isDailyNote: symptom.isDailyNote,
              ),
              intakes: const [],
            ),
          );
          if (row.intake case final intake?) {
            intakes
                .putIfAbsent(symptom.id, () => [])
                .add(
                  MigraineHistoryIntake(
                    id: intake.id,
                    name: intake.name,
                    timestamp: intake.timestamp,
                    dose: intake.dose,
                  ),
                );
          }
        }
        return [
          for (final entry in entries.values)
            entry.copyWith(intakes: intakes[entry.migraine.id] ?? const []),
        ];
      });
}
