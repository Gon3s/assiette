import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/symptom_entry/data/migraine_observation_repository.dart';
import 'package:assiette/features/symptom_entry/domain/migraine_observation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'migraine_observation_repository.g.dart';

/// Persistence contract for timestamped observations within a migraine.
abstract class MigraineObservationRepository {
  /// Watches every non-deleted observation in chronological order.
  Stream<List<MigraineObservation>> watchObservations(String migraineId);

  /// Appends an observation and returns its generated id.
  Future<String> addObservation(
    String migraineId,
    MigraineObservationInput input,
  );

  /// Replaces one observation without modifying its siblings.
  Future<void> updateObservation(
    String id,
    MigraineObservationInput input,
  );

  /// Soft-deletes one observation.
  Future<void> deleteObservation(String id);

  /// Restores a soft-deleted observation.
  Future<void> undoDeleteObservation(String id);
}

/// Provides the Drift implementation.
@riverpod
MigraineObservationRepository migraineObservationRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftMigraineObservationRepository(db);
}

/// Reactive observation list for one migraine episode.
@riverpod
Stream<List<MigraineObservation>> migraineObservations(
  Ref ref,
  String migraineId,
) => ref
    .watch(migraineObservationRepositoryProvider)
    .watchObservations(migraineId);
