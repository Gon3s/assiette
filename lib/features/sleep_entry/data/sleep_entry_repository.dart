import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/sleep_entry/domain/sleep_entry_repository.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Drift-backed implementation of [SleepEntryRepository].
class DriftSleepEntryRepository implements SleepEntryRepository {
  /// Creates a [DriftSleepEntryRepository].
  DriftSleepEntryRepository({required this._db});

  final AppDatabase _db;

  static const _uuid = Uuid();

  @override
  Future<void> saveSleepEntry({
    required DateTime day,
    int? quality,
    DateTime? bedTime,
    DateTime? wakeTime,
    String? note,
  }) async {
    final nightDate = DateTime.utc(day.year, day.month, day.day);
    final existing = await _db.sleepEntriesDao.watchByDate(day).first;
    final now = DateTime.now().toUtc();
    await _db.sleepEntriesDao.upsertSleepEntry(
      SleepEntriesCompanion.insert(
        id: existing?.id ?? _uuid.v4(),
        nightDate: existing?.nightDate ?? nightDate,
        quality: Value(quality),
        bedTime: Value(bedTime?.toUtc()),
        wakeTime: Value(wakeTime?.toUtc()),
        note: Value((note?.trim().isEmpty ?? true) ? null : note?.trim()),
        createdAt: Value(existing?.createdAt ?? now),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<DateTime> startNight(DateTime startedAt) async {
    final openEntry = await _db.sleepEntriesDao.getOpenEntry();
    if (openEntry != null) return _dateForEntry(openEntry);

    final existing = await _db.sleepEntriesDao.watchByDate(startedAt).first;
    if (existing == null) {
      final now = DateTime.now().toUtc();
      await _db.sleepEntriesDao.upsertSleepEntry(
        SleepEntriesCompanion.insert(
          id: _uuid.v4(),
          nightDate: _nightDateKey(startedAt),
          bedTime: Value(startedAt.toUtc()),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    } else if (existing.bedTime == null && existing.wakeTime == null) {
      await _db.sleepEntriesDao.upsertSleepEntry(
        existing
            .toCompanion(true)
            .copyWith(
              bedTime: Value(startedAt.toUtc()),
              updatedAt: Value(DateTime.now().toUtc()),
            ),
      );
    }
    return DateTime(startedAt.year, startedAt.month, startedAt.day);
  }

  @override
  Future<DateTime> recordWake(DateTime wokeAt) async {
    final openEntry = await _db.sleepEntriesDao.getOpenEntry();
    final now = DateTime.now().toUtc();
    if (openEntry != null) {
      await _db.sleepEntriesDao.upsertSleepEntry(
        openEntry
            .toCompanion(true)
            .copyWith(
              wakeTime: Value(wokeAt.toUtc()),
              updatedAt: Value(now),
            ),
      );
      return _dateForEntry(openEntry);
    }

    final day = DateTime(wokeAt.year, wokeAt.month, wokeAt.day);
    final existing = await _db.sleepEntriesDao.watchByDate(day).first;
    if (existing == null || existing.wakeTime == null) {
      await _db.sleepEntriesDao.upsertSleepEntry(
        SleepEntriesCompanion.insert(
          id: existing?.id ?? _uuid.v4(),
          nightDate: _nightDateKey(wokeAt),
          quality: Value(existing?.quality),
          wakeTime: Value(wokeAt.toUtc()),
          createdAt: Value(existing?.createdAt ?? now),
          updatedAt: Value(now),
        ),
      );
    }
    return day;
  }

  static DateTime _nightDateKey(DateTime date) =>
      DateTime.utc(date.year, date.month, date.day);

  static DateTime _dateForEntry(SleepEntry entry) {
    final key = entry.nightDate.toUtc();
    final canonicalKey = DateTime.utc(key.year, key.month, key.day);
    if (key == canonicalKey) {
      return DateTime(key.year, key.month, key.day);
    }
    final date =
        entry.bedTime?.toLocal() ??
        entry.wakeTime?.toLocal() ??
        entry.nightDate;
    return DateTime(date.year, date.month, date.day);
  }
}
