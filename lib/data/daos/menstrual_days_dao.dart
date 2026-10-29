import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/menstrual_days_table.dart';
import 'package:drift/drift.dart';

part 'menstrual_days_dao.g.dart';

@DriftAccessor(tables: [MenstrualDays])
class MenstrualDaysDao extends DatabaseAccessor<AppDatabase>
    with _$MenstrualDaysDaoMixin {
  MenstrualDaysDao(super.attachedDatabase);

  Stream<MenstrualDay?> watchDay(String date) =>
      (select(menstrualDays)..where(
            (t) => t.localDate.equals(date) & t.deletedAt.isNull(),
          ))
          .watchSingleOrNull();

  Future<List<MenstrualDay>> getRange(String start, String end) =>
      (select(menstrualDays)
            ..where(
              (t) =>
                  t.localDate.isBiggerOrEqualValue(start) &
                  t.localDate.isSmallerOrEqualValue(end) &
                  t.deletedAt.isNull(),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.localDate)]))
          .get();

  Future<MenstrualDay?> getIncludingDeleted(String date) => (select(
    menstrualDays,
  )..where((t) => t.localDate.equals(date))).getSingleOrNull();

  Future<void> upsert(MenstrualDaysCompanion row) =>
      into(menstrualDays).insertOnConflictUpdate(row);

  Future<void> softDelete(String date, DateTime now) async {
    await (update(menstrualDays)..where((t) => t.localDate.equals(date))).write(
      MenstrualDaysCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }

  // Explicitly confirmed, permanent erasure is distinct from entry deletion.
  Future<void> purge() async => delete(menstrualDays).go();
}
