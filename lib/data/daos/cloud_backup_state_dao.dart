import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/cloud_backup_state_table.dart';
import 'package:drift/drift.dart';

part 'cloud_backup_state_dao.g.dart';

@DriftAccessor(tables: [CloudBackupStates])
class CloudBackupStateDao extends DatabaseAccessor<AppDatabase>
    with _$CloudBackupStateDaoMixin {
  CloudBackupStateDao(super.attachedDatabase);

  static const _rowId = 0;

  Stream<DateTime?> watchLastBackupAt() =>
      (select(cloudBackupStates)..where((t) => t.id.equals(_rowId)))
          .watchSingleOrNull()
          .map((row) => row?.lastBackupAt);

  Future<void> setLastBackupAt(DateTime timestamp) =>
      into(cloudBackupStates).insertOnConflictUpdate(
        CloudBackupStatesCompanion.insert(
          id: const Value(_rowId),
          lastBackupAt: Value(timestamp),
        ),
      );

  Future<bool> getHasRestoredOnThisDevice() async {
    final row = await (select(
      cloudBackupStates,
    )..where((t) => t.id.equals(_rowId))).getSingleOrNull();
    return row?.hasRestoredOnThisDevice ?? false;
  }

  Future<void> setHasRestoredOnThisDevice({required bool value}) =>
      into(cloudBackupStates).insertOnConflictUpdate(
        CloudBackupStatesCompanion.insert(
          id: const Value(_rowId),
          hasRestoredOnThisDevice: Value(value),
        ),
      );
}
