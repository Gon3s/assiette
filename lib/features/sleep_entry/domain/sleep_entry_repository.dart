import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/sleep_entry/data/sleep_entry_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sleep_entry_repository.g.dart';

/// Persistence for the sleep entry detail form. A single-method contract by
/// design, kept as a class to match this project's repository convention.
abstract class SleepEntryRepository {
  /// Upserts the sleep entry for the night of [day].
  Future<void> saveSleepEntry({
    required DateTime day,
    int? quality,
    DateTime? bedTime,
    DateTime? wakeTime,
    String? note,
  });

  Future<DateTime> startNight(DateTime startedAt);

  Future<DateTime> recordWake(DateTime wokeAt);
}

/// Provides the [SleepEntryRepository] implementation.
@riverpod
SleepEntryRepository sleepEntryRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftSleepEntryRepository(db: db);
}
