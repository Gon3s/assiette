import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/sleep_entries_table.dart';
import 'package:drift/drift.dart';

part 'sleep_entries_dao.g.dart';

@DriftAccessor(tables: [SleepEntries])
class SleepEntriesDao extends DatabaseAccessor<AppDatabase>
    with _$SleepEntriesDaoMixin {
  SleepEntriesDao(super.attachedDatabase);

  Stream<SleepEntry?> watchByDate(DateTime date) {
    final localDay = DateTime(date.year, date.month, date.day);
    final nightDate = DateTime.utc(date.year, date.month, date.day);
    final legacyNightDate = localDay.toUtc();
    final nextDay = DateTime(date.year, date.month, date.day + 1);
    final bedTimeStart = localDay.toUtc();
    final bedTimeEnd = nextDay.toUtc();
    return (select(sleepEntries)
          ..where(
            (t) =>
                t.nightDate.equals(nightDate) |
                t.nightDate.equals(legacyNightDate) |
                (t.bedTime.isBiggerOrEqualValue(bedTimeStart) &
                    t.bedTime.isSmallerThanValue(bedTimeEnd)),
          )
          ..where((t) => t.deletedAt.isNull()))
        .watch()
        .map((entries) {
          SleepEntry? legacyEntry;
          for (final entry in entries) {
            final key = entry.nightDate.toUtc();
            if (key == nightDate) return entry;
            if (key != DateTime.utc(key.year, key.month, key.day)) {
              legacyEntry ??= entry;
            }
          }
          return legacyEntry;
        });
  }

  /// One-shot fetch of sleep entries whose night falls in `[start, end)`.
  Future<List<SleepEntry>> getRange(DateTime start, DateTime end) {
    // Include both canonical UTC date keys and legacy local-midnight keys.
    final lowerBound = start.subtract(const Duration(days: 1));
    final upperBound = end.add(const Duration(days: 1));
    return (select(sleepEntries)
          ..where((t) => t.deletedAt.isNull())
          ..where(
            (t) =>
                t.nightDate.isBiggerOrEqualValue(lowerBound) &
                t.nightDate.isSmallerThanValue(upperBound),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.nightDate)]))
        .get();
  }

  Future<void> upsertSleepEntry(SleepEntriesCompanion entry) =>
      into(sleepEntries).insertOnConflictUpdate(entry);

  Future<SleepEntry?> getOpenEntry() =>
      (select(sleepEntries)
            ..where((t) => t.deletedAt.isNull())
            ..where((t) => t.bedTime.isNotNull())
            ..where((t) => t.wakeTime.isNull())
            ..orderBy([(t) => OrderingTerm.desc(t.bedTime)])
            ..limit(1))
          .getSingleOrNull();

  Future<void> softDeleteSleepEntry(String id) =>
      (update(sleepEntries)..where((t) => t.id.equals(id))).write(
        SleepEntriesCompanion(deletedAt: Value(DateTime.now().toUtc())),
      );

  /// Clears `deletedAt`, undoing a soft delete.
  Future<void> restoreSleepEntry(String id) =>
      (update(sleepEntries)..where((t) => t.id.equals(id))).write(
        const SleepEntriesCompanion(deletedAt: Value(null)),
      );
}
