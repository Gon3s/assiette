import 'package:drift/drift.dart';

@DataClassName('EnvironmentSnapshot')
@TableIndex(name: 'idx_env_timestamp', columns: {#timestamp})
class EnvironmentSnapshots extends Table {
  TextColumn get id => text()();
  DateTimeColumn get timestamp => dateTime()();
  RealColumn get pressure => real().nullable()();
  RealColumn get pressureDelta => real().nullable()();
  RealColumn get temperature => real().nullable()();
  RealColumn get humidity => real().nullable()();
  RealColumn get lat => real().nullable()();
  RealColumn get lon => real().nullable()();

  /// WMO weather interpretation code (0 = clear sky, 61 = rain, ...).
  IntColumn get weatherCode => integer().nullable()();
  RealColumn get uvIndex => real().nullable()();

  /// Air quality (µg/m³) from the Open-Meteo air-quality API.
  RealColumn get pm25 => real().nullable()();
  RealColumn get pm10 => real().nullable()();

  /// Pollen concentrations (grains/m³), European coverage only.
  RealColumn get alderPollen => real().nullable()();
  RealColumn get birchPollen => real().nullable()();
  RealColumn get grassPollen => real().nullable()();
  RealColumn get mugwortPollen => real().nullable()();
  RealColumn get olivePollen => real().nullable()();
  RealColumn get ragweedPollen => real().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
