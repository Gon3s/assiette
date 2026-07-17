---
name: new-dao
description: Scaffold a new Drift table + DAO in this Flutter project (assiette), following the existing table/DAO/AppDatabase registration pattern. Use when the user asks to "add a table", "create a DAO", "add local storage for X", or a new persisted entity.
---

# New Drift table + DAO scaffolding

Generate a new Drift table and its DAO, then wire both into `AppDatabase`.
Ask the user for the entity name (PascalCase singular, e.g. `Reminder`) and
its columns if not provided.

## Steps

1. **Table** (`lib/data/db/tables/<entity_plural_snake>_table.dart`).
   Mirror `lib/data/db/tables/symptoms_table.dart`:
   ```dart
   import 'package:drift/drift.dart';

   @DataClassName('<Entity>')
   class <Entities> extends Table {
     TextColumn get id => text()();
     // ...entity-specific columns...
     DateTimeColumn get createdAt =>
         dateTime().withDefault(currentDateAndTime)();
     DateTimeColumn get updatedAt =>
         dateTime().withDefault(currentDateAndTime)();
     DateTimeColumn get deletedAt => dateTime().nullable()();

     @override
     Set<Column<Object>> get primaryKey => {id};
   }
   ```
   - Use soft delete (`deletedAt` nullable, never a hard `DELETE`) unless the
     user explicitly asks otherwise — every existing table follows this.
   - Add `@TableIndex(name: 'idx_<table>_<col>', columns: {#col})` for any
     column that will be filtered/ordered on (timestamp-like columns
     especially — see `symptoms_table.dart`).
   - If a column is a fixed set of values, add an `IntColumn` with
     `intEnum<TheEnum>()()` and define `TheEnum` in
     `lib/data/db/enums/<enum_snake>.dart` (see `symptom_type.dart`).

2. **DAO** (`lib/data/daos/<entity_plural_snake>_dao.dart`).
   Mirror `lib/data/daos/symptoms_dao.dart`:
   ```dart
   import 'package:assiette/data/db/app_database.dart';
   import 'package:assiette/data/db/tables/<entity_plural_snake>_table.dart';
   import 'package:drift/drift.dart';

   part '<entity_plural_snake>_dao.g.dart';

   @DriftAccessor(tables: [<Entities>])
   class <Entities>Dao extends DatabaseAccessor<AppDatabase>
       with _$<Entities>DaoMixin {
     <Entities>Dao(super.attachedDatabase);

     Future<void> insert<Entity>(<Entities>Companion entry) =>
         into(<entityPluralCamel>).insert(entry);

     Future<<Entity>?> get<Entity>ById(String id) =>
         (select(<entityPluralCamel>)..where((t) => t.id.equals(id)))
             .getSingleOrNull();

     Future<void> update<Entity>(String id, <Entities>Companion entry) =>
         (update(<entityPluralCamel>)..where((t) => t.id.equals(id)))
             .write(entry);

     Future<void> softDelete<Entity>(String id) =>
         (update(<entityPluralCamel>)..where((t) => t.id.equals(id))).write(
           <Entities>Companion(deletedAt: Value(DateTime.now().toUtc())),
         );
   }
   ```
   - Add `watch...` stream methods for any query the presentation layer needs
     to react to live (pattern: `select(...)..where(...)..orderBy(...)).watch()`,
     see `symptoms_dao.dart:watchByDay`).
   - Always filter out `deletedAt.isNull()` in read queries unless the caller
     explicitly wants deleted rows.

3. **Register in `AppDatabase`** (`lib/data/db/app_database.dart`):
   - Add the import for the new table and DAO.
   - Add `<Entities>` to the `tables:` list of `@DriftDatabase(...)`.
   - Add `<Entities>Dao` to the `daos:` list.
   - Bump `schemaVersion` by 1.
   - In `migration.onUpgrade`, add `if (from < <newVersion>) { await m.createTable(<entityPluralCamel>); }`.

4. **Generate code**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. **Repository layer** — a DAO is not exposed directly to `presentation`.
   Add or extend a repository in the owning feature's `domain/`
   (contract) and `data/` (implementation) that calls this DAO. If this
   table belongs to a brand-new feature, use the `new-feature` skill for
   that part instead of hand-rolling it here.

6. **Verify**: run `flutter analyze` and `flutter test`; fix any issues.

## Reminders

- Never edit `.g.dart` files by hand.
- Never modify an existing table's columns without a migration bump —
  Drift will refuse to run against a mismatched on-disk schema.
- The system tag seed lives inline in `AppDatabase._seedSystemTags()` —
  don't touch it unless the task is specifically about seed tags.
