// Drift DAO files expose infrastructure types, not a user-facing API.
// ignore_for_file: public_member_api_docs
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

  Future<void> insertSymptom(SymptomsCompanion entry) =>
      into(symptoms).insert(entry);

  Future<void> softDeleteSymptom(String id) =>
      (update(symptoms)..where((t) => t.id.equals(id))).write(
        SymptomsCompanion(deletedAt: Value(DateTime.now().toUtc())),
      );
}
