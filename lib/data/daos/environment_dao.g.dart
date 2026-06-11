// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment_dao.dart';

// ignore_for_file: type=lint
mixin _$EnvironmentDaoMixin on DatabaseAccessor<AppDatabase> {
  $EnvironmentSnapshotsTable get environmentSnapshots =>
      attachedDatabase.environmentSnapshots;
  EnvironmentDaoManager get managers => EnvironmentDaoManager(this);
}

class EnvironmentDaoManager {
  final _$EnvironmentDaoMixin _db;
  EnvironmentDaoManager(this._db);
  $$EnvironmentSnapshotsTableTableManager get environmentSnapshots =>
      $$EnvironmentSnapshotsTableTableManager(
        _db.attachedDatabase,
        _db.environmentSnapshots,
      );
}
