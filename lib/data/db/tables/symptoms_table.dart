// Drift table definitions are infrastructure — no public API docs needed.
// ignore_for_file: public_member_api_docs
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:drift/drift.dart';

@DataClassName('Symptom')
@TableIndex(name: 'idx_symptoms_timestamp', columns: {#timestamp})
class Symptoms extends Table {
  TextColumn get id => text()();
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get type => intEnum<SymptomType>()();
  IntColumn get intensity => integer()();
  TextColumn get detail => text().nullable()();
  DateTimeColumn get endTime => dateTime().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
