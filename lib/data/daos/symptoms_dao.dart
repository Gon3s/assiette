import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/symptoms_table.dart';
import 'package:drift/drift.dart';

part 'symptoms_dao.g.dart';

@DriftAccessor(tables: [Symptoms])
class SymptomsDao extends DatabaseAccessor<AppDatabase>
    with _$SymptomsDaoMixin {
  SymptomsDao(super.attachedDatabase);

  Stream<List<Symptom>> watchByDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day).toUtc();
    final end = start.add(const Duration(days: 1));
    return (select(symptoms)
          ..where((t) => t.deletedAt.isNull())
          ..where(
            (t) =>
                t.timestamp.isBiggerOrEqualValue(start) &
                t.timestamp.isSmallerThanValue(end),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .watch();
  }

  /// One-shot fetch of symptoms timestamped in `[start, end)`.
  Future<List<Symptom>> getRange(DateTime start, DateTime end) =>
      (select(symptoms)
            ..where((t) => t.deletedAt.isNull())
            ..where(
              (t) =>
                  t.timestamp.isBiggerOrEqualValue(start) &
                  t.timestamp.isSmallerThanValue(end),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
          .get();

  Future<void> insertSymptom(SymptomsCompanion entry) =>
      into(symptoms).insert(entry);

  /// Loads a single symptom, or `null` if it doesn't exist.
  Future<Symptom?> getSymptomById(String id) =>
      (select(symptoms)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> updateSymptom(String id, SymptomsCompanion entry) =>
      (update(symptoms)..where((t) => t.id.equals(id))).write(entry);

  Future<void> softDeleteSymptom(String id) =>
      (update(symptoms)..where((t) => t.id.equals(id))).write(
        SymptomsCompanion(deletedAt: Value(DateTime.now().toUtc())),
      );

  /// Clears `deletedAt`, undoing a soft delete.
  Future<void> restoreSymptom(String id) =>
      (update(symptoms)..where((t) => t.id.equals(id)))
          .write(const SymptomsCompanion(deletedAt: Value(null)));
}
