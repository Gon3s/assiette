// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migraine_intensity_measurements_dao.dart';

// ignore_for_file: type=lint
mixin _$MigraineIntensityMeasurementsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SymptomsTable get symptoms => attachedDatabase.symptoms;
  $MigraineIntensityMeasurementsTable get migraineIntensityMeasurements =>
      attachedDatabase.migraineIntensityMeasurements;
  MigraineIntensityMeasurementsDaoManager get managers =>
      MigraineIntensityMeasurementsDaoManager(this);
}

class MigraineIntensityMeasurementsDaoManager {
  final _$MigraineIntensityMeasurementsDaoMixin _db;
  MigraineIntensityMeasurementsDaoManager(this._db);
  $$SymptomsTableTableManager get symptoms =>
      $$SymptomsTableTableManager(_db.attachedDatabase, _db.symptoms);
  $$MigraineIntensityMeasurementsTableTableManager
  get migraineIntensityMeasurements =>
      $$MigraineIntensityMeasurementsTableTableManager(
        _db.attachedDatabase,
        _db.migraineIntensityMeasurements,
      );
}
