import 'package:assiette/data/db/app_database.dart';
import 'package:path/path.dart' as p;

/// Serializes the 10 Drift tables to/from a plain JSON-able map, and
/// rehydrates the local database from one (US-26). Pure data shuffling —
/// no network or file I/O; the caller owns bundling photos into the backup
/// archive and pointing [restore] at wherever they were extracted to.
class DatabaseSnapshotCodec {
  /// Creates a [DatabaseSnapshotCodec].
  const DatabaseSnapshotCodec();

  /// Snapshot format version, bumped if the shape below ever changes.
  static const formatVersion = 1;

  /// Dumps every row of every table as JSON-safe maps, keyed by table name.
  Future<Map<String, dynamic>> export(AppDatabase db) async {
    final tags = await db.select(db.tags).get();
    final mealTemplates = await db.select(db.mealTemplates).get();
    final meals = await db.select(db.meals).get();
    final mealTags = await db.select(db.mealTags).get();
    final templateTags = await db.select(db.templateTags).get();
    final symptoms = await db.select(db.symptoms).get();
    final medicationIntakes = await db.select(db.medicationIntakes).get();
    final sleepEntries = await db.select(db.sleepEntries).get();
    final environmentSnapshots =
        await db.select(db.environmentSnapshots).get();
    final appSettings = await db.select(db.appSettings).get();

    return {
      'formatVersion': formatVersion,
      'tags': [for (final row in tags) row.toJson()],
      'mealTemplates': [for (final row in mealTemplates) row.toJson()],
      'meals': [for (final row in meals) row.toJson()],
      'mealTags': [for (final row in mealTags) row.toJson()],
      'templateTags': [for (final row in templateTags) row.toJson()],
      'symptoms': [for (final row in symptoms) row.toJson()],
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
    final names = <String>{};
    for (final row in (snapshot['meals'] as List).cast<Map<String, dynamic>>()) {
      final path = row['photoPath'] as String?;
      if (path != null) names.add(p.basename(path));
    }
    for (final row
        in (snapshot['mealTemplates'] as List).cast<Map<String, dynamic>>()) {
      final path = row['defaultPhotoPath'] as String?;
      if (path != null) names.add(p.basename(path));
    }
    return names;
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
    await db.transaction(() async {
      // Children first, respecting the one real FK (medicationIntakes ->
      // symptoms); the rest have no declared FK but the same ordering
      // keeps things logically consistent.
      await db.delete(db.appSettings).go();
      await db.delete(db.environmentSnapshots).go();
      await db.delete(db.sleepEntries).go();
      await db.delete(db.medicationIntakes).go();
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
      for (final row in (snapshot['mealTemplates'] as List)
          .cast<Map<String, dynamic>>()) {
        await db.into(db.mealTemplates).insert(
              MealTemplate.fromJson(
                _rewritePhoto(row, 'defaultPhotoPath', photosDirPath),
              ),
            );
      }
      for (final row
          in (snapshot['meals'] as List).cast<Map<String, dynamic>>()) {
        await db.into(db.meals).insert(
              Meal.fromJson(_rewritePhoto(row, 'photoPath', photosDirPath)),
            );
      }
      for (final row
          in (snapshot['mealTags'] as List).cast<Map<String, dynamic>>()) {
        await db.into(db.mealTags).insert(MealTag.fromJson(row));
      }
      for (final row in (snapshot['templateTags'] as List)
          .cast<Map<String, dynamic>>()) {
        await db.into(db.templateTags).insert(TemplateTag.fromJson(row));
      }
      for (final row
          in (snapshot['symptoms'] as List).cast<Map<String, dynamic>>()) {
        await db.into(db.symptoms).insert(Symptom.fromJson(row));
      }
      for (final row in (snapshot['medicationIntakes'] as List)
          .cast<Map<String, dynamic>>()) {
        await db.into(db.medicationIntakes).insert(
              MedicationIntake.fromJson(row),
            );
      }
      for (final row in (snapshot['sleepEntries'] as List)
          .cast<Map<String, dynamic>>()) {
        await db.into(db.sleepEntries).insert(SleepEntry.fromJson(row));
      }
      for (final row in (snapshot['environmentSnapshots'] as List)
          .cast<Map<String, dynamic>>()) {
        await db.into(db.environmentSnapshots).insert(
              EnvironmentSnapshot.fromJson(row),
            );
      }
      for (final row in (snapshot['appSettings'] as List)
          .cast<Map<String, dynamic>>()) {
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
    return {...row, key: p.join(photosDirPath, p.basename(path))};
  }
}
