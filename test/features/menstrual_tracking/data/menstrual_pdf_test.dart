import 'dart:convert';
import 'dart:io';

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/menstrual_tracking/data/drift_menstrual_tracking_repository.dart';
import 'package:assiette/features/menstrual_tracking/domain/menstrual_observation.dart';
import 'package:assiette/features/pdf_export/data/journal_export_repository.dart';
import 'package:assiette/features/pdf_export/data/journal_pdf_builder.dart';
import 'package:assiette/localization/strings_en.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'PDF opt-in exports a menstrual-only day without an invented time',
    () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final menstrual = DriftMenstrualTrackingRepository(db);
      final repository = DriftJournalExportRepository(
        mealsDao: db.mealsDao,
        symptomsDao: db.symptomsDao,
        medicationIntakesDao: db.medicationIntakesDao,
        sleepEntriesDao: db.sleepEntriesDao,
        environmentDao: db.environmentDao,
        menstrualRepository: menstrual,
      );
      await menstrual.setPreferences(const MenstrualPreferences(enabled: true));
      const observation = MenstrualObservation(
        localDate: '2026-10-01',
        status: BleedingStatus.spotting,
        note: 'private note',
      );
      await menstrual.save(observation);
      final date = DateTime(2026, 10);
      expect(await repository.loadRange(date, DateTime(2026, 10, 2)), isEmpty);
      await menstrual.setPreferences(
        const MenstrualPreferences(
          enabled: true,
          includeInPdf: true,
        ),
      );
      final entries = await repository.loadRange(date, DateTime(2026, 10, 2));
      expect(entries, hasLength(1));
      expect(entries.single.hasData, isTrue);
      expect(entries.single.menstrual, observation);
      final bytes = await JournalPdfBuilder().build(AppStringsEn(), entries);
      final pdf = latin1.decode(bytes);
      final streams = RegExp(r'stream\r?\n([\s\S]*?)\r?\nendstream')
          .allMatches(pdf)
          .map((match) {
            final bytes = latin1.encode(match[1]!);
            try {
              return latin1.decode(zlib.decode(bytes));
            } on Object {
              return match[1]!;
            }
          })
          .join('\n');
      expect(streams, contains('Spotting'));
      expect(streams, contains('(private)'));
      expect(streams, contains('(note)'));
      expect(streams, isNot(contains('00:00')));
      await menstrual.delete(observation.localDate);
      expect(await repository.loadRange(date, date), isEmpty);
    },
  );
}
