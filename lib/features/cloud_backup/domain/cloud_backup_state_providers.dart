import 'package:assiette/data/db/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cloud_backup_state_providers.g.dart';

/// Timestamp of the last successful cloud backup run on this device, or
/// `null` if it never ran. Local-only metadata — not part of the
/// exported/restored snapshot.
@riverpod
Stream<DateTime?> lastBackupAt(Ref ref) =>
    ref.watch(appDatabaseProvider).cloudBackupStateDao.watchLastBackupAt();
