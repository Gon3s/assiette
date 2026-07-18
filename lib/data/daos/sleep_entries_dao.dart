import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/sleep_entries_table.dart';
import 'package:drift/drift.dart';

part 'sleep_entries_dao.g.dart';

@DriftAccessor(tables: [SleepEntries])
class SleepEntriesDao extends DatabaseAccessor<AppDatabase>
    with _$SleepEntriesDaoMixin {
  SleepEntriesDao(super.attachedDatabase);

  Stream<SleepEntry?> watchByDate(DateTime date) {
    final nightDate = DateTime(date.year, date.month, date.day).toUtc();
    return (select(sleepEntries)
          ..where((t) => t.nightDate.equals(nightDate))
          ..where((t) => t.deletedAt.isNull()))
        .watchSingleOrNull();
  }

  /// One-shot fetch of sleep entries whose night falls in `[start, end)`.
  Future<List<SleepEntry>> getRange(DateTime start, DateTime end) =>
      (select(sleepEntries)
            ..where((t) => t.deletedAt.isNull())
            ..where(
              (t) =>
                  t.nightDate.isBiggerOrEqualValue(start) &
                  t.nightDate.isSmallerThanValue(end),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.nightDate)]))
          .get();

  Future<void> upsertSleepEntry(SleepEntriesCompanion entry) =>
      into(sleepEntries).insertOnConflictUpdate(entry);

  Future<void> softDeleteSleepEntry(String id) =>
      (update(sleepEntries)..where((t) => t.id.equals(id))).write(
        SleepEntriesCompanion(deletedAt: Value(DateTime.now().toUtc())),
      );

  /// Clears `deletedAt`, undoing a soft delete.
  Future<void> restoreSleepEntry(String id) =>
      (update(sleepEntries)..where((t) => t.id.equals(id)))
          .write(const SleepEntriesCompanion(deletedAt: Value(null)));
}
