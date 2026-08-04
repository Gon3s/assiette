// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_backup_state_dao.dart';

// ignore_for_file: type=lint
mixin _$CloudBackupStateDaoMixin on DatabaseAccessor<AppDatabase> {
  $CloudBackupStatesTable get cloudBackupStates =>
      attachedDatabase.cloudBackupStates;
  CloudBackupStateDaoManager get managers => CloudBackupStateDaoManager(this);
}

class CloudBackupStateDaoManager {
  final _$CloudBackupStateDaoMixin _db;
  CloudBackupStateDaoManager(this._db);
  $$CloudBackupStatesTableTableManager get cloudBackupStates =>
      $$CloudBackupStatesTableTableManager(
        _db.attachedDatabase,
        _db.cloudBackupStates,
      );
}
