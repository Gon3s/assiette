// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_intakes_dao.dart';

// ignore_for_file: type=lint
mixin _$MedicationIntakesDaoMixin on DatabaseAccessor<AppDatabase> {
  $SymptomsTable get symptoms => attachedDatabase.symptoms;
  $MedicationIntakesTable get medicationIntakes =>
      attachedDatabase.medicationIntakes;
  MedicationIntakesDaoManager get managers => MedicationIntakesDaoManager(this);
}

class MedicationIntakesDaoManager {
  final _$MedicationIntakesDaoMixin _db;
  MedicationIntakesDaoManager(this._db);
  $$SymptomsTableTableManager get symptoms =>
      $$SymptomsTableTableManager(_db.attachedDatabase, _db.symptoms);
  $$MedicationIntakesTableTableManager get medicationIntakes =>
      $$MedicationIntakesTableTableManager(
        _db.attachedDatabase,
        _db.medicationIntakes,
      );
}
