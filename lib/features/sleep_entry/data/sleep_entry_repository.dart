import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/sleep_entry/domain/sleep_entry_repository.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Drift-backed implementation of [SleepEntryRepository].
class DriftSleepEntryRepository implements SleepEntryRepository {
  /// Creates a [DriftSleepEntryRepository].
  DriftSleepEntryRepository({required AppDatabase db}) : _db = db;

  final AppDatabase _db;

  static const _uuid = Uuid();

  @override
  Future<void> saveSleepEntry({
    required DateTime day,
    required int quality,
    DateTime? bedTime,
    DateTime? wakeTime,
  }) async {
    final nightDate = DateTime(day.year, day.month, day.day).toUtc();
    final existing = await _db.sleepEntriesDao.watchByDate(day).first;
    final now = DateTime.now().toUtc();
    await _db.sleepEntriesDao.upsertSleepEntry(
      SleepEntriesCompanion.insert(
        id: existing?.id ?? _uuid.v4(),
        nightDate: nightDate,
        quality: quality,
        bedTime: Value(bedTime?.toUtc()),
        wakeTime: Value(wakeTime?.toUtc()),
        createdAt: Value(existing?.createdAt ?? now),
        updatedAt: Value(now),
      ),
    );
  }
}
