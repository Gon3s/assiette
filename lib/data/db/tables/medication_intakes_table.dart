import 'package:assiette/data/db/tables/symptoms_table.dart';
import 'package:drift/drift.dart';

@DataClassName('MedicationIntake')
@TableIndex(name: 'idx_medication_intakes_timestamp', columns: {#timestamp})
class MedicationIntakes extends Table {
  TextColumn get id => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get name => text()();
  TextColumn get dose => text().nullable()();
  TextColumn get symptomId => text().nullable().references(Symptoms, #id)();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
