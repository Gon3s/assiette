import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/tables/app_settings_table.dart';
import 'package:drift/drift.dart';

part 'app_settings_dao.g.dart';

@DriftAccessor(tables: [AppSettings])
class AppSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$AppSettingsDaoMixin {
  AppSettingsDao(super.attachedDatabase);

  static const _rowId = 0;

  Stream<bool> watchOnboardingDone() =>
      (select(appSettings)..where((t) => t.id.equals(_rowId)))
          .watchSingleOrNull()
          .map((row) => row?.onboardingDone ?? false);

  Future<void> setOnboardingDone({required bool done}) => into(appSettings)
      .insertOnConflictUpdate(
        AppSettingsCompanion.insert(
          id: const Value(_rowId),
          onboardingDone: Value(done),
        ),
      );
}
