import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/migraine_history/data/drift_migraine_history_repository.dart';
import 'package:assiette/features/migraine_history/domain/migraine_history_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'migraine_history_repository.g.dart';

// Keeps the read-only storage boundary injectable for presentation.
// ignore: one_member_abstracts
abstract class MigraineHistoryRepository {
  Stream<List<MigraineHistoryEntry>> watchHistory();
}

@riverpod
MigraineHistoryRepository migraineHistoryRepository(Ref ref) =>
    DriftMigraineHistoryRepository(
      symptomsDao: ref.watch(appDatabaseProvider).symptomsDao,
    );
