// Kept as a class (not a top-level function) to match the repository
// contract pattern used by every other feature: swappable in tests via
// mocktail, implemented in data/.
// ignore_for_file: one_member_abstracts

import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/pdf_export/data/journal_export_repository.dart';
import 'package:assiette/features/pdf_export/domain/day_journal_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'journal_export_repository.g.dart';

/// Read access to the journal data used to build the PDF export (US-17).
abstract class JournalExportRepository {
  /// Loads one [DayJournalEntry] per day in `[start, end]` (both inclusive,
  /// local dates), skipping days with nothing logged.
  Future<List<DayJournalEntry>> loadRange(DateTime start, DateTime end);
}

/// Provides the [JournalExportRepository] implementation.
@riverpod
JournalExportRepository journalExportRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftJournalExportRepository(
    mealsDao: db.mealsDao,
    symptomsDao: db.symptomsDao,
    sleepEntriesDao: db.sleepEntriesDao,
    environmentDao: db.environmentDao,
  );
}
