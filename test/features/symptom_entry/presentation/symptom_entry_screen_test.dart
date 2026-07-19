@Timeout(Duration(seconds: 5))
library;

import 'dart:async';

import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/medication_entry/domain/medication_entry_repository.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_entry_repository.dart';
import 'package:assiette/features/symptom_entry/presentation/symptom_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockSymptomEntryRepository extends Mock
    implements SymptomEntryRepository {}

class MockMedicationEntryRepository extends Mock
    implements MedicationEntryRepository {}

void main() {
  late MockSymptomEntryRepository repository;
  late MockMedicationEntryRepository medicationRepository;

  setUpAll(() {
    registerFallbackValue(SymptomType.migraine);
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    repository = MockSymptomEntryRepository();
    medicationRepository = MockMedicationEntryRepository();
    when(
      () => repository.saveSymptom(
        timestamp: any(named: 'timestamp'),
        type: any(named: 'type'),
        intensity: any(named: 'intensity'),
        detail: any(named: 'detail'),
        endTime: any(named: 'endTime'),
        note: any(named: 'note'),
      ),
    ).thenAnswer((_) async => 'symptom-new');
    when(() => medicationRepository.recentNames())
        .thenAnswer((_) async => []);
    when(() => medicationRepository.loadIntakesForSymptom(any()))
        .thenAnswer((_) async => []);
    when(
      () => medicationRepository.saveIntake(
        timestamp: any(named: 'timestamp'),
        name: any(named: 'name'),
        dose: any(named: 'dose'),
        symptomId: any(named: 'symptomId'),
      ),
    ).thenAnswer((_) async {});
  });

  // The form ListView builds lazily: scroll until the target is built,
  // then make sure it is actually on screen before tapping it.
  Future<void> scrollTo(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(
      finder,
      100,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
  }

  Future<GoRouter> pumpScreen(
    WidgetTester tester, {
    SymptomDraft? draft,
  }) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, _) => const Scaffold()),
        GoRoute(
          path: '/symptom-entry',
          builder: (_, state) =>
              SymptomEntryScreen(draft: state.extra as SymptomDraft?),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          symptomEntryRepositoryProvider.overrideWithValue(repository),
          medicationEntryRepositoryProvider
              .overrideWithValue(medicationRepository),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    // Push the entry screen like the day view does, so pop() can return.
    unawaited(router.push('/symptom-entry', extra: draft));
    await tester.pumpAndSettle();
    return router;
  }

  testWidgets('shows the form with symptom types and default intensity', (
    tester,
  ) async {
    await pumpScreen(tester);

    // English fallback since no localization ancestor.
    expect(find.text('New symptom'), findsOneWidget);
    expect(find.text('Migraine'), findsOneWidget);
    expect(find.text('Digestive'), findsOneWidget);
    expect(find.text('Mood'), findsOneWidget);
    expect(find.text('Pain'), findsOneWidget);
    expect(find.text('Intensity: 5'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets('migraine has no detail suggestions', (tester) async {
    await pumpScreen(tester);

    expect(find.text('Detail (optional)'), findsNothing);
  });

  testWidgets('selecting digestive shows its detail chips', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.text('Digestive'));
    await tester.pump();

    expect(find.text('Detail (optional)'), findsOneWidget);
    expect(find.text('Bloating'), findsOneWidget);
    // 'Pain' also labels the type segment, so target the chip widget.
    expect(find.widgetWithText(ChoiceChip, 'Pain'), findsOneWidget);
    expect(find.text('Nausea'), findsOneWidget);
  });

  testWidgets('selecting pain shows its detail chips', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.text('Pain'));
    await tester.pump();

    expect(find.text('Detail (optional)'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
    expect(find.text('Joint'), findsOneWidget);
    expect(find.text('Muscle'), findsOneWidget);
  });

  testWidgets('tapping a detail chip selects it, tapping again clears it', (
    tester,
  ) async {
    await pumpScreen(tester);
    await tester.tap(find.text('Digestive'));
    await tester.pump();

    ChoiceChip chipFor(String label) =>
        tester.widget<ChoiceChip>(find.widgetWithText(ChoiceChip, label));

    expect(chipFor('Bloating').selected, isFalse);

    await tester.tap(find.text('Bloating'));
    await tester.pump();
    expect(chipFor('Bloating').selected, isTrue);

    await tester.tap(find.text('Bloating'));
    await tester.pump();
    expect(chipFor('Bloating').selected, isFalse);
  });

  testWidgets('changing type back to migraine hides the chips again', (
    tester,
  ) async {
    await pumpScreen(tester);
    await tester.tap(find.text('Digestive'));
    await tester.pump();
    await tester.tap(find.text('Migraine'));
    await tester.pump();

    expect(find.text('Detail (optional)'), findsNothing);
  });

  testWidgets('saving calls the repository and pops back', (tester) async {
    final router = await pumpScreen(tester);

    await tester.tap(find.text('Digestive'));
    await tester.pump();
    await tester.tap(find.text('Bloating'));
    await tester.pump();

    await scrollTo(tester, find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    verify(
      () => repository.saveSymptom(
        timestamp: any(named: 'timestamp'),
        type: SymptomType.digestive,
        intensity: 5,
        detail: 'Bloating',
        note: '',
      ),
    ).called(1);
    expect(
      router.routerDelegate.currentConfiguration.uri.toString(),
      '/',
    );
  });

  testWidgets('adding an end time shows it and can be removed', (
    tester,
  ) async {
    await pumpScreen(tester);

    expect(find.text('Add an end time'), findsOneWidget);

    await tester.tap(find.text('Add an end time'));
    await tester.pumpAndSettle();
    // Confirm the default-selected time on the Material time picker.
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Add an end time'), findsNothing);
    expect(find.byIcon(Icons.timer_outlined), findsOneWidget);

    await tester.tap(find.byTooltip('Remove end time'));
    await tester.pump();

    expect(find.text('Add an end time'), findsOneWidget);
  });

  testWidgets('adding a medication intake shows a chip and saves it', (
    tester,
  ) async {
    await pumpScreen(tester);

    await scrollTo(tester, find.text('Add an intake'));
    await tester.tap(find.text('Add an intake'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Medication'),
      'Bi-Profenid',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Dose (optional)'),
      '100 mg',
    );
    // The dialog's confirm button (the form's Save sits behind the dialog).
    await tester.tap(find.widgetWithText(FilledButton, 'Save').last);
    await tester.pumpAndSettle();

    expect(find.textContaining('Bi-Profenid'), findsOneWidget);

    await scrollTo(tester, find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    verify(
      () => medicationRepository.saveIntake(
        timestamp: any(named: 'timestamp'),
        name: 'Bi-Profenid',
        dose: '100 mg',
        symptomId: 'symptom-new',
      ),
    ).called(1);
  });

  testWidgets('a recent medication name is offered as a one-tap chip', (
    tester,
  ) async {
    when(() => medicationRepository.recentNames())
        .thenAnswer((_) async => ['Sumatriptan']);

    await pumpScreen(tester);

    await scrollTo(tester, find.text('Sumatriptan'));
    await tester.tap(find.text('Sumatriptan'));
    await tester.pump();

    // The chip moved from suggestion (ActionChip) to added intake
    // (InputChip, labeled with the intake time).
    expect(find.widgetWithText(ActionChip, 'Sumatriptan'), findsNothing);
    expect(find.textContaining('Sumatriptan'), findsOneWidget);

    await scrollTo(tester, find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    verify(
      () => medicationRepository.saveIntake(
        timestamp: any(named: 'timestamp'),
        name: 'Sumatriptan',
        dose: any(named: 'dose'),
        symptomId: 'symptom-new',
      ),
    ).called(1);
  });

  group('editing an existing symptom', () {
    final draft = SymptomDraft(
      id: 'symptom-1',
      timestamp: DateTime(2026, 7, 7, 9),
      type: SymptomType.migraine,
      intensity: 7,
    );

    testWidgets('shows the edit title and a delete action', (tester) async {
      await pumpScreen(tester, draft: draft);

      expect(find.text('Edit symptom'), findsOneWidget);
      expect(find.text('Intensity: 7'), findsOneWidget);
      expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    });

    testWidgets('saving calls updateSymptom, not saveSymptom', (tester) async {
      when(
        () => repository.updateSymptom(
          id: any(named: 'id'),
          timestamp: any(named: 'timestamp'),
          type: any(named: 'type'),
          intensity: any(named: 'intensity'),
          detail: any(named: 'detail'),
          endTime: any(named: 'endTime'),
          note: any(named: 'note'),
        ),
      ).thenAnswer((_) async {});

      await pumpScreen(tester, draft: draft);
      await tester.ensureVisible(find.text('Save'));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      verify(
        () => repository.updateSymptom(
          id: 'symptom-1',
          timestamp: any(named: 'timestamp'),
          type: SymptomType.migraine,
          intensity: 7,
          detail: any(named: 'detail'),
          endTime: any(named: 'endTime'),
          note: any(named: 'note'),
        ),
      ).called(1);
      verifyNever(
        () => repository.saveSymptom(
          timestamp: any(named: 'timestamp'),
          type: any(named: 'type'),
          intensity: any(named: 'intensity'),
          detail: any(named: 'detail'),
          endTime: any(named: 'endTime'),
          note: any(named: 'note'),
        ),
      );
    });

    testWidgets('deleting pops back and shows an undo snackbar', (
      tester,
    ) async {
      when(
        () => repository.deleteSymptom('symptom-1'),
      ).thenAnswer((_) async {});
      when(
        () => repository.undoDeleteSymptom('symptom-1'),
      ).thenAnswer((_) async {});

      final router = await pumpScreen(tester, draft: draft);
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      verify(() => repository.deleteSymptom('symptom-1')).called(1);
      expect(
        router.routerDelegate.currentConfiguration.uri.toString(),
        '/',
      );
      expect(find.text('Entry deleted'), findsOneWidget);

      // The SnackBar sits at the viewport edge in the test surface, so
      // invoke the action's callback directly rather than a hit-test tap.
      final action = tester.widget<SnackBarAction>(
        find.byType(SnackBarAction),
      );
      action.onPressed();
      verify(() => repository.undoDeleteSymptom('symptom-1')).called(1);
    });
  });
}
