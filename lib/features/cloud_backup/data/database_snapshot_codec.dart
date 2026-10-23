import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_exception.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

/// Serializes the Drift tables to/from a plain JSON-able map, and
/// rehydrates the local database from one (US-26). Pure data shuffling —
/// no network or file I/O; the caller owns bundling photos into the backup
/// archive and pointing [restore] at wherever they were extracted to.
class DatabaseSnapshotCodec {
  /// Creates a [DatabaseSnapshotCodec].
  const DatabaseSnapshotCodec();

  /// Snapshot format version, bumped if the shape below ever changes.
  static const formatVersion = 5;

  static const _tables = {
    'tags',
    'mealTemplates',
    'meals',
    'mealTags',
    'templateTags',
    'symptoms',
    'migraineIntensityMeasurements',
    'medicationIntakes',
    'sleepEntries',
    'environmentSnapshots',
    'appSettings',
  };

  /// Checks deserialization, SQLite constraints and references in isolation.
  Future<void> validate(Map<String, dynamic> snapshot) async {
    final validationDb = _SnapshotValidationDatabase();
    try {
      _validateStructure(snapshot);
      await _restore(validationDb, snapshot, 'photos');
      for (final query in _referenceChecks) {
        if ((await validationDb.customSelect(query).get()).isNotEmpty) {
          throw CloudBackupException('Backup contains an invalid reference');
        }
      }
    } on CloudBackupException {
      rethrow;
    } on Object {
      throw CloudBackupException('Backup database is invalid');
    } finally {
      await validationDb.close();
    }
  }

  static const _referenceChecks = [
    '''
       SELECT 1 FROM meals m LEFT JOIN meal_templates t ON t.id = m.template_id
       WHERE m.template_id IS NOT NULL AND t.id IS NULL LIMIT 1''',
    '''
       SELECT 1 FROM meal_tags m LEFT JOIN meals p ON p.id = m.meal_id
       LEFT JOIN tags t ON t.id = m.tag_id
       WHERE p.id IS NULL OR t.id IS NULL LIMIT 1''',
    '''
       SELECT 1 FROM template_tags m
       LEFT JOIN meal_templates p ON p.id = m.template_id
       LEFT JOIN tags t ON t.id = m.tag_id
       WHERE p.id IS NULL OR t.id IS NULL LIMIT 1''',
    '''
       SELECT 1 FROM medication_intakes m
       LEFT JOIN symptoms s ON s.id = m.symptom_id
       WHERE m.symptom_id IS NOT NULL AND s.id IS NULL LIMIT 1''',
    '''
       SELECT 1 FROM migraine_intensity_measurements m
       LEFT JOIN symptoms s ON s.id = m.symptom_id
       WHERE s.id IS NULL OR s.type != 0 LIMIT 1''',
  ];

  void _validateStructure(Map<String, dynamic> snapshot) {
    final version = snapshot['formatVersion'];
    if (version is! int || version < 1 || version > formatVersion) {
      throw CloudBackupException('Unsupported backup format version');
    }
    if (snapshot.keys.any(
      (key) => key != 'formatVersion' && !_tables.contains(key),
    )) {
      throw CloudBackupException('Unexpected backup database field');
    }
    var rowCount = 0;
    for (final table in _tables) {
      if (table == 'migraineIntensityMeasurements' &&
          version < 3 &&
          !snapshot.containsKey(table)) {
        continue;
      }
      final rows = snapshot[table];
      if (rows is! List || rows.any((row) => row is! Map<String, dynamic>)) {
        throw CloudBackupException('Invalid backup table: $table');
      }
      rowCount += rows.length;
      if (rowCount > 100000) {
        throw CloudBackupException('Backup contains too many database rows');
      }
    }
    photoFileNamesIn(snapshot);
  }

  static String photoFileName(String path) {
    final name = p.posix.basename(path.replaceAll(r'\', '/'));
    if (!isPhotoFileName(name)) {
      throw CloudBackupException('Invalid backup photo name');
    }
    return name;
  }

  static bool isPhotoFileName(String name) =>
      name.length <= 255 &&
      RegExp(
        r'^[a-zA-Z0-9][a-zA-Z0-9._-]*\.(jpg|jpeg|png|webp|heic|heif)$',
        caseSensitive: false,
      ).hasMatch(name) &&
      !RegExp(
        r'^(con|prn|aux|nul|com[1-9]|lpt[1-9])\.',
        caseSensitive: false,
      ).hasMatch(name);

  /// Dumps every row of every table as JSON-safe maps, keyed by table name.
  Future<Map<String, dynamic>> export(AppDatabase db) async {
    final tags = await db.select(db.tags).get();
    final mealTemplates = await db.select(db.mealTemplates).get();
    final meals = await db.select(db.meals).get();
    final mealTags = await db.select(db.mealTags).get();
    final templateTags = await db.select(db.templateTags).get();
    final symptoms = await db.select(db.symptoms).get();
    final migraineMeasurements = await db
        .select(db.migraineIntensityMeasurements)
        .get();
    final medicationIntakes = await db.select(db.medicationIntakes).get();
    final sleepEntries = await db.select(db.sleepEntries).get();
    final environmentSnapshots = await db.select(db.environmentSnapshots).get();
    final appSettings = await db.select(db.appSettings).get();

    return {
      'formatVersion': formatVersion,
      'tags': [for (final row in tags) row.toJson()],
      'mealTemplates': [for (final row in mealTemplates) row.toJson()],
      'meals': [for (final row in meals) row.toJson()],
      'mealTags': [for (final row in mealTags) row.toJson()],
      'templateTags': [for (final row in templateTags) row.toJson()],
      'symptoms': [for (final row in symptoms) row.toJson()],
      'migraineIntensityMeasurements': [
        for (final row in migraineMeasurements) row.toJson(),
      ],
      'medicationIntakes': [
        for (final row in medicationIntakes) row.toJson(),
      ],
      'sleepEntries': [for (final row in sleepEntries) row.toJson()],
      'environmentSnapshots': [
        for (final row in environmentSnapshots) row.toJson(),
      ],
      'appSettings': [for (final row in appSettings) row.toJson()],
    };
  }

  /// Basenames of every photo referenced by [snapshot]'s meals and favorite
  /// templates — both point into the same `meal_photos/` directory.
  Set<String> photoFileNamesIn(Map<String, dynamic> snapshot) {
    return photoPathsIn(snapshot).keys.toSet();
  }

  Map<String, String> photoPathsIn(Map<String, dynamic> snapshot) {
    final paths = <String, String>{};
    final names = <String>{};
    void add(String? path) {
      if (path == null) return;
      final name = photoFileName(path);
      final previous = paths[name];
      if (previous != null && previous != path) {
        throw CloudBackupException('Backup photo names collide');
      }
      if (previous == null && !names.add(name.toLowerCase())) {
        throw CloudBackupException('Backup photo names collide');
      }
      paths[name] = path;
    }

    for (final row
        in (snapshot['meals'] as List).cast<Map<String, dynamic>>()) {
      final path = row['photoPath'] as String?;
      add(path);
    }
    for (final row
        in (snapshot['mealTemplates'] as List).cast<Map<String, dynamic>>()) {
      final path = row['defaultPhotoPath'] as String?;
      add(path);
    }
    return paths;
  }

  /// Replaces every row in [db] with the contents of [snapshot], rewriting
  /// `photoPath`/`defaultPhotoPath` to point into [photosDirPath] (photos
  /// are re-extracted there under their original basename before this
  /// runs). The whole thing is one transaction: any failure rolls back and
  /// leaves the previous local data untouched.
  Future<void> restore(
    AppDatabase db,
    Map<String, dynamic> snapshot,
    String photosDirPath,
  ) async {
    await validate(snapshot);
    await _restore(db, snapshot, photosDirPath);
  }

  Future<void> _restore(
    AppDatabase db,
    Map<String, dynamic> snapshot,
    String photosDirPath,
  ) async {
    await db.transaction(() async {
      // Children first, respecting the one real FK (medicationIntakes ->
      // symptoms); the rest have no declared FK but the same ordering
      // keeps things logically consistent.
      await db.delete(db.appSettings).go();
      await db.delete(db.environmentSnapshots).go();
      await db.delete(db.sleepEntries).go();
      await db.delete(db.medicationIntakes).go();
      await db.delete(db.migraineIntensityMeasurements).go();
      await db.delete(db.symptoms).go();
      await db.delete(db.templateTags).go();
      await db.delete(db.mealTags).go();
      await db.delete(db.meals).go();
      await db.delete(db.mealTemplates).go();
      await db.delete(db.tags).go();

      for (final row
          in (snapshot['tags'] as List).cast<Map<String, dynamic>>()) {
        await db.into(db.tags).insert(Tag.fromJson(row));
      }
      for (final row
          in (snapshot['mealTemplates'] as List).cast<Map<String, dynamic>>()) {
        await db
            .into(db.mealTemplates)
            .insert(
              MealTemplate.fromJson(
                _rewritePhoto(row, 'defaultPhotoPath', photosDirPath),
              ),
            );
      }
      for (final row
          in (snapshot['meals'] as List).cast<Map<String, dynamic>>()) {
        await db
            .into(db.meals)
            .insert(
              Meal.fromJson(_rewritePhoto(row, 'photoPath', photosDirPath)),
            );
      }
      for (final row
          in (snapshot['mealTags'] as List).cast<Map<String, dynamic>>()) {
        await db.into(db.mealTags).insert(MealTag.fromJson(row));
      }
      for (final row
          in (snapshot['templateTags'] as List).cast<Map<String, dynamic>>()) {
        await db.into(db.templateTags).insert(TemplateTag.fromJson(row));
      }
      for (final row
          in (snapshot['symptoms'] as List).cast<Map<String, dynamic>>()) {
        await db
            .into(db.symptoms)
            .insert(
              Symptom.fromJson({
                'dailyDate': null,
                'isDailyNote': false,
                ...row,
              }),
            );
      }
      final measurementRows =
          (snapshot['migraineIntensityMeasurements'] as List?)
              ?.cast<Map<String, dynamic>>();
      if (measurementRows != null) {
        for (final row in measurementRows) {
          await db
              .into(db.migraineIntensityMeasurements)
              .insert(
                MigraineIntensityMeasurement.fromJson({
                  'laterality': null,
                  'location': null,
                  'aura': null,
                  'nausea': null,
                  'photophobia': null,
                  'phonophobia': null,
                  'note': null,
                  'updatedAt': row['createdAt'],
                  'deletedAt': null,
                  ...row,
                }),
              );
        }
      } else {
        final migraines = await (db.select(
          db.symptoms,
        )..where((row) => row.type.equalsValue(SymptomType.migraine))).get();
        for (final migraine in migraines) {
          final intensity = migraine.initialIntensity ?? migraine.intensity;
          if (intensity == null) continue;
          await db
              .into(db.migraineIntensityMeasurements)
              .insert(
                MigraineIntensityMeasurementsCompanion.insert(
                  id: 'restore-v3-${migraine.id}',
                  symptomId: migraine.id,
                  timestamp: migraine.startedAt ?? migraine.timestamp,
                  intensity: intensity,
                  createdAt: Value(migraine.createdAt),
                  updatedAt: Value(migraine.updatedAt),
                ),
              );
        }
      }
      for (final row
          in (snapshot['medicationIntakes'] as List)
              .cast<Map<String, dynamic>>()) {
        await db
            .into(db.medicationIntakes)
            .insert(
              MedicationIntake.fromJson(row),
            );
      }
      for (final row
          in (snapshot['sleepEntries'] as List).cast<Map<String, dynamic>>()) {
        await db.into(db.sleepEntries).insert(SleepEntry.fromJson(row));
      }
      for (final row
          in (snapshot['environmentSnapshots'] as List)
              .cast<Map<String, dynamic>>()) {
        await db
            .into(db.environmentSnapshots)
            .insert(
              EnvironmentSnapshot.fromJson(row),
            );
      }
      for (final row
          in (snapshot['appSettings'] as List).cast<Map<String, dynamic>>()) {
        await db.into(db.appSettings).insert(AppSetting.fromJson(row));
      }
    });
  }

  Map<String, dynamic> _rewritePhoto(
    Map<String, dynamic> row,
    String key,
    String photosDirPath,
  ) {
    final path = row[key] as String?;
    if (path == null) return row;
    return {...row, key: p.join(photosDirPath, photoFileName(path))};
  }
}

// A separate type keeps Drift's duplicate-instance diagnostic meaningful for
// the live database. This executor is always private and memory-only.
class _SnapshotValidationDatabase extends AppDatabase {
  _SnapshotValidationDatabase() : super(NativeDatabase.memory());
}
