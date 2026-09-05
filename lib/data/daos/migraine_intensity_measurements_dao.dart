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
            ..where((row) => row.deletedAt.isNull())
            ..orderBy([(row) => OrderingTerm.asc(row.timestamp)]))
          .watch();

  Future<List<MigraineIntensityMeasurement>> getForMigraine(String id) =>
      (select(migraineIntensityMeasurements)
            ..where((row) => row.symptomId.equals(id))
            ..where((row) => row.deletedAt.isNull())
            ..orderBy([(row) => OrderingTerm.asc(row.timestamp)]))
          .get();

  Future<void> insertMeasurement(
    MigraineIntensityMeasurementsCompanion entry,
  ) => into(migraineIntensityMeasurements).insert(entry);

  Future<void> updateMeasurement(
    String id,
    MigraineIntensityMeasurementsCompanion entry,
  ) => (update(
    migraineIntensityMeasurements,
  )..where((row) => row.id.equals(id))).write(entry);

  Future<void> softDeleteMeasurement(String id) {
    final now = DateTime.now().toUtc();
    return updateMeasurement(
      id,
      MigraineIntensityMeasurementsCompanion(
        updatedAt: Value(now),
        deletedAt: Value(now),
      ),
    );
  }

  Future<void> restoreMeasurement(String id) => updateMeasurement(
    id,
    MigraineIntensityMeasurementsCompanion(
      updatedAt: Value(DateTime.now().toUtc()),
      deletedAt: const Value(null),
    ),
  );
}
