import 'dart:async';

import 'package:assiette/features/pdf_export/domain/day_journal_entry.dart';
import 'package:assiette/features/pdf_export/domain/journal_export_repository.dart';
import 'package:assiette/features/pdf_export/presentation/pdf_export_controller.dart';
import 'package:assiette/localization/strings_en.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockJournalExportRepository extends Mock
    implements JournalExportRepository {}

void main() {
  test(
    'changing privacy settings cannot restore a PDF still being generated',
    () async {
      final repository = MockJournalExportRepository();
      final pending = Completer<List<DayJournalEntry>>();
      final date = DateTime(2026, 10);
      when(() => repository.loadRange(date, date))
          .thenAnswer((_) => pending.future);
      final container = ProviderContainer(
        overrides: [
          journalExportRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);
      container.listen(pdfExportControllerProvider, (_, _) {});
      await container.read(pdfExportControllerProvider.future);
      final controller = container.read(pdfExportControllerProvider.notifier);
      final generation = controller.generate(AppStringsEn(), date, date);
      controller.reset();
      pending.complete([]);
      await generation;
      expect(container.read(pdfExportControllerProvider).value, isNull);
      expect(container.read(pdfExportControllerProvider).isLoading, isFalse);
    },
  );
}
