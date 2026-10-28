// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menstrual_days_dao.dart';

// ignore_for_file: type=lint
mixin _$MenstrualDaysDaoMixin on DatabaseAccessor<AppDatabase> {
  $MenstrualDaysTable get menstrualDays => attachedDatabase.menstrualDays;
  MenstrualDaysDaoManager get managers => MenstrualDaysDaoManager(this);
}

class MenstrualDaysDaoManager {
  final _$MenstrualDaysDaoMixin _db;
  MenstrualDaysDaoManager(this._db);
  $$MenstrualDaysTableTableManager get menstrualDays =>
      $$MenstrualDaysTableTableManager(_db.attachedDatabase, _db.menstrualDays);
}
