// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptoms_dao.dart';

// ignore_for_file: type=lint
mixin _$SymptomsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SymptomsTable get symptoms => attachedDatabase.symptoms;
  SymptomsDaoManager get managers => SymptomsDaoManager(this);
}

class SymptomsDaoManager {
  final _$SymptomsDaoMixin _db;
  SymptomsDaoManager(this._db);
  $$SymptomsTableTableManager get symptoms =>
      $$SymptomsTableTableManager(_db.attachedDatabase, _db.symptoms);
}
