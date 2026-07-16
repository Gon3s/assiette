import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/tags_table.dart';
import 'package:drift/drift.dart';

part 'tags_dao.g.dart';

@DriftAccessor(tables: [Tags])
class TagsDao extends DatabaseAccessor<AppDatabase> with _$TagsDaoMixin {
  TagsDao(super.attachedDatabase);

  Stream<List<Tag>> watchAll() {
    return (select(tags)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.label)]))
        .watch();
  }

  Future<void> insertTag(TagsCompanion entry) =>
      into(tags).insert(entry);
}
