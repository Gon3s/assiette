// Drift DAO files expose infrastructure types, not a user-facing API.
// ignore_for_file: public_member_api_docs
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
