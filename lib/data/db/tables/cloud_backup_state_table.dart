import 'package:drift/drift.dart';

/// Per-device metadata for the Google Drive backup feature (US-26). Single
/// row (id 0), never part of the exported/restored snapshot itself.
@DataClassName('CloudBackupState')
class CloudBackupStates extends Table {
  IntColumn get id => integer()();
  DateTimeColumn get lastBackupAt => dateTime().nullable()();
  BoolColumn get hasRestoredOnThisDevice =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
