import 'package:assiette/data/db/enums/migraine_laterality.dart';
import 'package:assiette/data/db/enums/migraine_location.dart';
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
  IntColumn get laterality => intEnum<MigraineLaterality>().nullable()();
  IntColumn get location => intEnum<MigraineLocation>().nullable()();
  BoolColumn get aura => boolean().nullable()();
  BoolColumn get nausea => boolean().nullable()();
  BoolColumn get photophobia => boolean().nullable()();
  BoolColumn get phonophobia => boolean().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
