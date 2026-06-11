// Drift table definitions are infrastructure — no public API docs needed.
// ignore_for_file: public_member_api_docs
import 'package:drift/drift.dart';

@DataClassName('TemplateTag')
class TemplateTags extends Table {
  TextColumn get templateId => text()();
  TextColumn get tagId => text()();

  @override
  Set<Column<Object>> get primaryKey => {templateId, tagId};
}
