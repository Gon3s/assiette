import 'package:assiette/data/daos/app_settings_dao.dart';
import 'package:assiette/data/daos/cloud_backup_state_dao.dart';
import 'package:assiette/data/daos/environment_dao.dart';
import 'package:assiette/data/daos/meals_dao.dart';
import 'package:assiette/data/daos/medication_intakes_dao.dart';
import 'package:assiette/data/daos/sleep_entries_dao.dart';
import 'package:assiette/data/daos/symptoms_dao.dart';
import 'package:assiette/data/daos/tags_dao.dart';
import 'package:assiette/data/daos/templates_dao.dart';
import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/data/db/tables/app_settings_table.dart';
import 'package:assiette/data/db/tables/cloud_backup_state_table.dart';
import 'package:assiette/data/db/tables/environment_snapshots_table.dart';
import 'package:assiette/data/db/tables/meal_tags_table.dart';
import 'package:assiette/data/db/tables/meal_templates_table.dart';
import 'package:assiette/data/db/tables/meals_table.dart';
import 'package:assiette/data/db/tables/medication_intakes_table.dart';
import 'package:assiette/data/db/tables/sleep_entries_table.dart';
import 'package:assiette/data/db/tables/symptoms_table.dart';
import 'package:assiette/data/db/tables/tags_table.dart';
import 'package:assiette/data/db/tables/template_tags_table.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Tags,
    Meals,
    MealTags,
    MealTemplates,
    TemplateTags,
    Symptoms,
    MedicationIntakes,
    SleepEntries,
    EnvironmentSnapshots,
    AppSettings,
    CloudBackupStates,
  ],
  daos: [
    TagsDao,
    MealsDao,
    TemplatesDao,
    SymptomsDao,
    MedicationIntakesDao,
    SleepEntriesDao,
    EnvironmentDao,
    AppSettingsDao,
    CloudBackupStateDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'assiette'));

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seedSystemTags();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(appSettings);
      }
      if (from < 3) {
        await m.addColumn(appSettings, appSettings.lastPressureAlertDate);
      }
      if (from < 4) {
        await m.addColumn(appSettings, appSettings.remindersMealsEnabled);
        await m.addColumn(appSettings, appSettings.breakfastHour);
        await m.addColumn(appSettings, appSettings.breakfastMinute);
        await m.addColumn(appSettings, appSettings.lunchHour);
        await m.addColumn(appSettings, appSettings.lunchMinute);
        await m.addColumn(appSettings, appSettings.dinnerHour);
        await m.addColumn(appSettings, appSettings.dinnerMinute);
        await m.addColumn(appSettings, appSettings.remindersSleepEnabled);
        await m.addColumn(appSettings, appSettings.sleepHour);
        await m.addColumn(appSettings, appSettings.sleepMinute);
        await m.addColumn(appSettings, appSettings.remindersWeatherEnabled);
        await m.addColumn(appSettings, appSettings.remindersSymptomsEnabled);
        await m.addColumn(appSettings, appSettings.symptomsHour);
        await m.addColumn(appSettings, appSettings.symptomsMinute);
      }
      if (from < 5) {
        await m.addColumn(
          appSettings,
          appSettings.photoTagSuggestionsEnabled,
        );
      }
      if (from < 6) {
        await m.createTable(medicationIntakes);
        await m.createIndex(idxMedicationIntakesTimestamp);
      }
      if (from < 7) {
        await m.addColumn(
          environmentSnapshots,
          environmentSnapshots.weatherCode,
        );
        await m.addColumn(environmentSnapshots, environmentSnapshots.uvIndex);
        await m.addColumn(environmentSnapshots, environmentSnapshots.pm25);
        await m.addColumn(environmentSnapshots, environmentSnapshots.pm10);
        await m.addColumn(
          environmentSnapshots,
          environmentSnapshots.alderPollen,
        );
        await m.addColumn(
          environmentSnapshots,
          environmentSnapshots.birchPollen,
        );
        await m.addColumn(
          environmentSnapshots,
          environmentSnapshots.grassPollen,
        );
        await m.addColumn(
          environmentSnapshots,
          environmentSnapshots.mugwortPollen,
        );
        await m.addColumn(
          environmentSnapshots,
          environmentSnapshots.olivePollen,
        );
        await m.addColumn(
          environmentSnapshots,
          environmentSnapshots.ragweedPollen,
        );
      }
      if (from < 8) {
        await m.createTable(cloudBackupStates);
      }
    },
  );

  Future<void> _seedSystemTags() async {
    const uuid = Uuid();
    final now = DateTime.now().toUtc();
    for (final (label, category) in _systemTagData) {
      await into(tags).insert(
        TagsCompanion.insert(
          id: uuid.v4(),
          label: label,
          category: Value(category),
          isSystem: const Value(true),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    }
  }

  static const List<(String, String)> _systemTagData = [
    ('café', 'alimentation'),
    ('alcool', 'alimentation'),
    ('vin rouge', 'alimentation'),
    ('fromage affiné', 'alimentation'),
    ('chocolat', 'alimentation'),
    ('charcuterie', 'alimentation'),
    ('gluten', 'alimentation'),
    ('lactose', 'alimentation'),
    ('agrumes', 'alimentation'),
    ('plats épicés', 'alimentation'),
    ('fritures', 'alimentation'),
    ('édulcorant', 'alimentation'),
    ('MSG', 'alimentation'),
    ('thé', 'alimentation'),
    ('eau gazeuse', 'alimentation'),
    ('stress', 'mode_de_vie'),
    ('manque de sommeil', 'mode_de_vie'),
    ('activité physique', 'mode_de_vie'),
    ('jeûne', 'mode_de_vie'),
    ('déshydratation', 'mode_de_vie'),
    ('position écran', 'mode_de_vie'),
    ('lumière vive', 'environnement'),
    ('bruit fort', 'environnement'),
    ('changement météo', 'environnement'),
    ('menstruation', 'médical'),
  ];
}
