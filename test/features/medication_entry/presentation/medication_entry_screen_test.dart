@Timeout(Duration(seconds: 5))
library;

import 'dart:async';

import 'package:assiette/features/day_view/domain/active_migraine.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/medication_entry/domain/medication_entry_repository.dart';
import 'package:assiette/features/medication_entry/domain/medication_intake_draft.dart';
import 'package:assiette/features/medication_entry/presentation/medication_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _FakeMedicationRepository repository;

  Future<void> pump(
    WidgetTester tester, {
    ActiveMigraine? activeMigraine,
  }) async {
    repository = _FakeMedicationRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          medicationEntryRepositoryProvider.overrideWithValue(repository),
          activeMigraineProvider.overrideWith(
            (ref) => Stream.value(activeMigraine),
          ),
        ],
        child: const MaterialApp(home: MedicationEntryScreen()),
      ),
    );
    await tester.pump();
  }

  testWidgets('new medication asks for name and time but no dose', (
    tester,
  ) async {
    await pump(tester);

    expect(find.text('Medication'), findsWidgets);
    expect(find.byIcon(Icons.schedule), findsOneWidget);
    expect(find.text('Dose (optional)'), findsNothing);
  });

  testWidgets('recent medication saves in one tap and offers undo', (
    tester,
  ) async {
    await pump(tester);

    expect(find.text('Sumatriptan'), findsOneWidget);
    await tester.tap(find.text('Sumatriptan'));
    await tester.pump();

    expect(repository.savedName, 'Sumatriptan');
    expect(find.text('Intake saved'), findsOneWidget);
    expect(find.text('Undo'), findsOneWidget);
  });

  testWidgets('active migraine association can be removed', (tester) async {
    await pump(
      tester,
      activeMigraine: const ActiveMigraine(
        id: 'migraine',
        startedAt: null,
        lastIntensity: 5,
      ),
    );

    expect(find.text('Link to active migraine'), findsOneWidget);
    await tester.tap(find.byType(CheckboxListTile));
    await tester.pump();
    await tester.tap(find.text('Sumatriptan'));
    await tester.pump();

    expect(repository.savedSymptomId, isNull);
  });

  testWidgets('saving stays disabled until the intake is stored', (
    tester,
  ) async {
    await pump(tester);
    final pendingSave = Completer<String>();
    repository.pendingSave = pendingSave.future;

    await tester.tap(find.text('Sumatriptan'));
    await tester.pump();

    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    expect(
      tester.widget<ActionChip>(find.byType(ActionChip)).onPressed,
      isNull,
    );
    expect(find.text('Intake saved'), findsNothing);

    pendingSave.complete('intake');
    await tester.pump();

    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
    expect(find.text('Intake saved'), findsOneWidget);
  });
}

class _FakeMedicationRepository implements MedicationEntryRepository {
  String? savedName;
  String? savedSymptomId;
  Future<String>? pendingSave;

  @override
  Future<List<String>> recentNames() async => const ['Sumatriptan'];

  @override
  Future<String> saveIntake({
    required DateTime timestamp,
    required String name,
    String? dose,
    String? symptomId,
    String? note,
  }) async {
    savedName = name;
    savedSymptomId = symptomId;
    return pendingSave ?? 'intake';
  }

  @override
  Future<void> deleteIntake(String id) async {}

  @override
  Future<void> detachFromMigraine(String id) async {}

  @override
  Future<List<MedicationIntakeDraft>> loadIntakesForSymptom(
    String symptomId,
  ) async => const [];

  @override
  Future<void> undoDeleteIntake(String id) async {}
}
