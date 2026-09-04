import 'package:assiette/data/db/tables/symptoms_table.dart';
import 'package:drift/drift.dart';

@DataClassName('MigraineIntensityMeasurement')
@TableIndex(
  name: 'idx_migraine_measurements_symptom_timestamp',
  columns: {#symptomId, #timestamp},
)
class MigraineIntensityMeasurements extends Table {
  TextColumn get id => text()();
  TextColumn get symptomId => text().references(Symptoms, #id)();
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get intensity => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
