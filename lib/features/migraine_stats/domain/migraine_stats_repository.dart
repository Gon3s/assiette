// Kept as a class to match the repository contracts used across the project
// and to make the storage boundary replaceable in tests.
// ignore_for_file: one_member_abstracts

import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/migraine_stats/data/drift_migraine_stats_repository.dart';
import 'package:assiette/features/migraine_stats/domain/migraine_stats.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'migraine_stats_repository.g.dart';

/// Read access to the data used by the migraine statistics screen.
abstract class MigraineStatsRepository {
  /// Loads statistics ending on the calendar day containing [now].
  Future<MigraineStats> load(MigraineStatsPeriod period, DateTime now);
}

/// Provides the Drift-backed migraine statistics repository.
@riverpod
MigraineStatsRepository migraineStatsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftMigraineStatsRepository(
    symptomsDao: db.symptomsDao,
    medicationIntakesDao: db.medicationIntakesDao,
  );
}
