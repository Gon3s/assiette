import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/medication_intakes_table.dart';
import 'package:drift/drift.dart';

part 'medication_intakes_dao.g.dart';

@DriftAccessor(tables: [MedicationIntakes])
class MedicationIntakesDao extends DatabaseAccessor<AppDatabase>
    with _$MedicationIntakesDaoMixin {
  MedicationIntakesDao(super.attachedDatabase);

  Stream<List<MedicationIntake>> watchByDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day).toUtc();
    final end = start.add(const Duration(days: 1));
    return (select(medicationIntakes)
          ..where((t) => t.deletedAt.isNull())
          ..where(
            (t) =>
                t.timestamp.isBiggerOrEqualValue(start) &
                t.timestamp.isSmallerThanValue(end),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .watch();
  }

  /// One-shot fetch of intakes timestamped in `[start, end)`.
  Future<List<MedicationIntake>> getRange(DateTime start, DateTime end) =>
      (select(medicationIntakes)
            ..where((t) => t.deletedAt.isNull())
            ..where(
              (t) =>
                  t.timestamp.isBiggerOrEqualValue(start) &
                  t.timestamp.isSmallerThanValue(end),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
          .get();

  /// Intakes linked to a symptom, oldest first.
  Future<List<MedicationIntake>> getBySymptomId(String symptomId) =>
      (select(medicationIntakes)
            ..where((t) => t.deletedAt.isNull())
            ..where((t) => t.symptomId.equals(symptomId))
            ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
          .get();

  /// Distinct medication names already used, most recent first, for
  /// autocompletion. No hardcoded drug list: history is the only source.
  Future<List<String>> getDistinctNames({int limit = 10}) async {
    final rows =
        await (selectOnly(medicationIntakes)
              ..addColumns([medicationIntakes.name])
              ..where(medicationIntakes.deletedAt.isNull())
              ..orderBy([
                OrderingTerm.desc(medicationIntakes.timestamp.max()),
              ])
              ..groupBy([medicationIntakes.name])
              ..limit(limit))
            .get();
    return rows
        .map((row) => row.read(medicationIntakes.name))
        .whereType<String>()
        .toList();
  }

  Future<void> insertIntake(MedicationIntakesCompanion entry) =>
      into(medicationIntakes).insert(entry);

  Future<MedicationIntake?> getIntakeById(String id) =>
      (select(medicationIntakes)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<void> updateIntake(String id, MedicationIntakesCompanion entry) =>
      (update(medicationIntakes)..where((t) => t.id.equals(id))).write(entry);

  Future<void> softDeleteIntake(String id) =>
      (update(medicationIntakes)..where((t) => t.id.equals(id))).write(
        MedicationIntakesCompanion(deletedAt: Value(DateTime.now().toUtc())),
      );

  /// Clears `deletedAt`, undoing a soft delete.
  Future<void> restoreIntake(String id) =>
      (update(medicationIntakes)..where((t) => t.id.equals(id)))
          .write(const MedicationIntakesCompanion(deletedAt: Value(null)));

  /// Soft-deletes every intake linked to [symptomId] (crisis deleted).
  Future<void> softDeleteBySymptomId(String symptomId) =>
      (update(medicationIntakes)
            ..where((t) => t.symptomId.equals(symptomId))
            ..where((t) => t.deletedAt.isNull()))
          .write(
        MedicationIntakesCompanion(deletedAt: Value(DateTime.now().toUtc())),
      );

  /// Restores every intake linked to [symptomId] (crisis restore/undo).
  Future<void> restoreBySymptomId(String symptomId) =>
      (update(medicationIntakes)..where((t) => t.symptomId.equals(symptomId)))
          .write(const MedicationIntakesCompanion(deletedAt: Value(null)));
}
