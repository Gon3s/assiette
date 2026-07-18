import 'dart:io';
import 'dart:typed_data';

import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/pdf_export/presentation/pdf_export_controller.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

/// Date-range PDF export of the journal, to share with a doctor (US-17).
class PdfExportScreen extends ConsumerStatefulWidget {
  /// Creates a [PdfExportScreen].
  const PdfExportScreen({super.key});

  @override
  ConsumerState<PdfExportScreen> createState() => _PdfExportScreenState();
}

class _PdfExportScreenState extends ConsumerState<PdfExportScreen> {
  DateTimeRange? _range;

  Future<void> _pickRange(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 2),
      lastDate: now,
      initialDateRange: _range,
    );
    if (picked == null) return;
    setState(() => _range = picked);
    ref.read(pdfExportControllerProvider.notifier).reset();
  }

  Future<void> _generate(BuildContext context, AppStrings s) async {
    final range = _range;
    if (range == null) return;
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    await ref
        .read(pdfExportControllerProvider.notifier)
        .generate(s, range.start, range.end, locale: locale);
  }

  Future<void> _share(Uint8List bytes) async {
    final directory = await getTemporaryDirectory();
    final range = _range!;
    final fileName =
        'journal_${_fileDate(range.start)}_${_fileDate(range.end)}.pdf';
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes);
    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)]),
    );
  }

  String _fileDate(DateTime date) => DateFormat('yyyyMMdd').format(date);

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    final dateFormat = DateFormat.yMd(locale);
    final pdfState = ref.watch(pdfExportControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(s.pdfExportScreenTitle)),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.date_range_outlined),
              title: Text(s.pdfExportRangeLabel),
              subtitle: Text(
                _range == null
                    ? s.pdfExportChooseRange
                    : '${dateFormat.format(_range!.start)} – '
                        '${dateFormat.format(_range!.end)}',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _pickRange(context),
            ),
            gapH16,
            FilledButton(
              onPressed: _range == null || pdfState.isLoading
                  ? null
                  : () => _generate(context, s),
              child: pdfState.isLoading
                  ? const SizedBox(
                      height: Sizes.p20,
                      width: Sizes.p20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(s.pdfExportGenerate),
            ),
            gapH16,
            Expanded(child: _preview(s, pdfState)),
          ],
        ),
      ),
    );
  }

  Widget _preview(AppStrings s, AsyncValue<Uint8List?> pdfState) {
    return pdfState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text(s.errorGeneric)),
      data: (bytes) {
        if (bytes == null) return const SizedBox.shrink();
        if (bytes.isEmpty) return Center(child: Text(s.pdfExportEmptyRange));
        return Column(
          children: [
            Expanded(
              child: PdfPreview(
                build: (format) async => bytes,
                allowSharing: false,
                canChangePageFormat: false,
                canChangeOrientation: false,
                canDebug: false,
              ),
            ),
            gapH8,
            OutlinedButton.icon(
              onPressed: () => _share(bytes),
              icon: const Icon(Icons.ios_share),
              label: Text(s.pdfExportShare),
            ),
          ],
        );
      },
    );
  }
}
