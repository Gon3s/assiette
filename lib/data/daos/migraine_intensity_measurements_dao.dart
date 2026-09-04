import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/migraine_intensity_measurements_table.dart';
import 'package:drift/drift.dart';

part 'migraine_intensity_measurements_dao.g.dart';

@DriftAccessor(tables: [MigraineIntensityMeasurements])
class MigraineIntensityMeasurementsDao extends DatabaseAccessor<AppDatabase>
    with _$MigraineIntensityMeasurementsDaoMixin {
  MigraineIntensityMeasurementsDao(super.attachedDatabase);

  Stream<List<MigraineIntensityMeasurement>> watchForMigraine(String id) =>
      (select(migraineIntensityMeasurements)
            ..where((row) => row.symptomId.equals(id))
            ..orderBy([(row) => OrderingTerm.asc(row.timestamp)]))
          .watch();

  Future<void> insertMeasurement(
    MigraineIntensityMeasurementsCompanion entry,
  ) => into(migraineIntensityMeasurements).insert(entry);
}
