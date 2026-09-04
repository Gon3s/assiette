import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:drift/drift.dart';

@DataClassName('Symptom')
@TableIndex(name: 'idx_symptoms_timestamp', columns: {#timestamp})
class Symptoms extends Table {
  TextColumn get id => text()();
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get type => intEnum<SymptomType>()();
  IntColumn get intensity => integer().nullable()();
  TextColumn get detail => text().nullable()();
  DateTimeColumn get endTime => dateTime().nullable()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  IntColumn get startPrecision =>
      intEnum<MigraineStartPrecision>().nullable()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  IntColumn get initialIntensity => integer().nullable()();
  IntColumn get maximumIntensity => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get dailyDate => dateTime().nullable()();
  BoolColumn get isDailyNote => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
