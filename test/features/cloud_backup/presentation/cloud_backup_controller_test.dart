import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_exception.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_repository.dart';
import 'package:assiette/features/cloud_backup/presentation/cloud_backup_controller.dart';
import 'package:assiette/features/cloud_backup/presentation/cloud_backup_state.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockBackupRepository extends Mock implements CloudBackupRepository {}

void main() {
  for (final notFound in [false, true]) {
    test(
      'failed restore preserves the restore offer (not found: $notFound)',
      () async {
        final db = AppDatabase(NativeDatabase.memory());
        addTearDown(db.close);
        final repository = _MockBackupRepository();
        when(
          repository.signInSilently,
        ).thenAnswer((_) async => 'user@example.test');
        when(repository.restoreLatest).thenThrow(
          CloudBackupException('Invalid backup', isNotFound: notFound),
        );
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            cloudBackupRepositoryProvider.overrideWithValue(repository),
          ],
        );
        addTearDown(container.dispose);
        container.listen(cloudBackupControllerProvider, (_, _) {});
        await container.read(cloudBackupControllerProvider.future);
        final outcome = await container
            .read(cloudBackupControllerProvider.notifier)
            .restoreLatest();

        expect(
          outcome,
          notFound ? RestoreOutcome.notFound : RestoreOutcome.failure,
        );
        expect(
          await db.cloudBackupStateDao.getHasRestoredOnThisDevice(),
          isFalse,
        );
        expect(
          container.read(cloudBackupControllerProvider).requireValue.isBusy,
          isFalse,
        );
      },
    );
  }
}
