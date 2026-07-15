@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/enums/symptom_type.dart';
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

void main() {
  late MockSymptomEntryRepository repository;

  setUpAll(() {
    registerFallbackValue(SymptomType.migraine);
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    repository = MockSymptomEntryRepository();
    when(
      () => repository.saveSymptom(
        timestamp: any(named: 'timestamp'),
        type: any(named: 'type'),
        intensity: any(named: 'intensity'),
        detail: any(named: 'detail'),
        endTime: any(named: 'endTime'),
        note: any(named: 'note'),
      ),
    ).thenAnswer((_) async {});
  });

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
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    // Push the entry screen like the day view does, so pop() can return.
    router.push('/symptom-entry', extra: draft);
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
    expect(find.text('Pain'), findsOneWidget);
    expect(find.text('Nausea'), findsOneWidget);
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

    await tester.ensureVisible(find.text('Save'));
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
