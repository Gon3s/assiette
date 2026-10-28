import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/sleep_entry/domain/sleep_day.dart';
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
  Future<DateTime> startNight(DateTime startedAt) => _db.transaction(() async {
    final day = sleepDayForBedTime(startedAt);
    final existing = await _db.sleepEntriesDao.watchByDate(day).first;
    if (existing == null) {
      final now = DateTime.now().toUtc();
      await _db.sleepEntriesDao.upsertSleepEntry(
        SleepEntriesCompanion.insert(
          id: _uuid.v4(),
          nightDate: _nightDateKey(day),
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
    return day;
  });

  @override
  Future<DateTime> recordWake(DateTime wokeAt) => _db.transaction(() async {
    final local = wokeAt.toLocal();
    final day = DateTime(local.year, local.month, local.day);
    final existing = await _db.sleepEntriesDao.watchByDate(day).first;
    // Prefer today's entry. An old unfinished night must not steal this wake.
    final openEntry = existing == null
        ? await _db.sleepEntriesDao.getOpenEntry(at: wokeAt)
        : null;
    final now = DateTime.now().toUtc();
    if (openEntry != null) {
      // Repair a recent night created under the old bedtime-day convention
      // only when the destination is empty. Keep other stored keys (travel).
      final bedTime = openEntry.bedTime!.toLocal();
      final storedDay = _dateForEntry(openEntry);
      final isLegacyBedDay =
          storedDay == DateTime(bedTime.year, bedTime.month, bedTime.day) &&
          sleepDayForBedTime(bedTime) == day;
      // Deleted entries still occupy their unique key and may be restored.
      final destination = isLegacyBedDay
          ? await (_db.select(_db.sleepEntries)..where(
                  (t) => t.nightDate.equals(_nightDateKey(day)),
                ))
                .getSingleOrNull()
          : null;
      final moveToWakeDay = isLegacyBedDay && destination == null;
      final night = moveToWakeDay ? day : storedDay;
      await _db.sleepEntriesDao.upsertSleepEntry(
        openEntry
            .toCompanion(true)
            .copyWith(
              nightDate: Value(
                moveToWakeDay ? _nightDateKey(night) : openEntry.nightDate,
              ),
              wakeTime: Value(wokeAt.toUtc()),
              updatedAt: Value(now),
            ),
      );
      return night;
    }

    if (existing?.bedTime?.isAfter(wokeAt) ?? false) return day;
    if (existing != null && existing.wakeTime == null) {
      await _db.sleepEntriesDao.upsertSleepEntry(
        existing
            .toCompanion(true)
            .copyWith(
              wakeTime: Value(wokeAt.toUtc()),
              updatedAt: Value(now),
            ),
      );
    } else if (existing == null) {
      await _db.sleepEntriesDao.upsertSleepEntry(
        SleepEntriesCompanion.insert(
          id: _uuid.v4(),
          nightDate: _nightDateKey(day),
          wakeTime: Value(wokeAt.toUtc()),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    }
    return day;
  });

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
