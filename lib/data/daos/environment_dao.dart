// Drift DAO files expose infrastructure types, not a user-facing API.
// ignore_for_file: public_member_api_docs
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/environment_snapshots_table.dart';
import 'package:drift/drift.dart';

part 'environment_dao.g.dart';

@DriftAccessor(tables: [EnvironmentSnapshots])
class EnvironmentDao extends DatabaseAccessor<AppDatabase>
    with _$EnvironmentDaoMixin {
  EnvironmentDao(super.attachedDatabase);

  Stream<List<EnvironmentSnapshot>> watchByDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day).toUtc();
    final end = start.add(const Duration(days: 1));
    return (select(environmentSnapshots)
          ..where(
            (t) =>
                t.timestamp.isBiggerOrEqualValue(start) &
                t.timestamp.isSmallerThanValue(end),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .watch();
  }

  Future<void> insertSnapshot(EnvironmentSnapshotsCompanion entry) =>
      into(environmentSnapshots).insert(entry);
}
