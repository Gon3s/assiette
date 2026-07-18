import 'dart:typed_data';

import 'package:assiette/features/pdf_export/data/journal_pdf_builder.dart';
import 'package:assiette/features/pdf_export/domain/journal_export_repository.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pdf_export_controller.g.dart';

/// Generates the journal PDF for a chosen date range (US-17). Idle until
/// [generate] is called.
@riverpod
class PdfExportController extends _$PdfExportController {
  @override
  Future<Uint8List?> build() async => null;

  /// Loads the journal entries for `[start, end]` (inclusive) and renders
  /// the PDF, using [locale] for date/time formatting.
  Future<void> generate(
    AppStrings strings,
    DateTime start,
    DateTime end, {
    String? locale,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final entries = await ref
          .read(journalExportRepositoryProvider)
          .loadRange(start, end);
      return JournalPdfBuilder().build(strings, entries, locale: locale);
    });
  }

  /// Clears the generated PDF, e.g. after the range selection changes.
  void reset() => state = const AsyncData(null);
}
