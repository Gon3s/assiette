import 'dart:async';

import 'package:assiette/features/menstrual_tracking/domain/menstrual_observation.dart';
import 'package:assiette/features/menstrual_tracking/domain/menstrual_tracking_repository.dart';
import 'package:assiette/features/menstrual_tracking/presentation/menstrual_day_card.dart';
import 'package:assiette/features/menstrual_tracking/presentation/menstrual_entry_screen.dart';
import 'package:assiette/features/menstrual_tracking/presentation/menstrual_providers.dart';
import 'package:assiette/features/menstrual_tracking/presentation/menstrual_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockMenstrualRepository extends Mock
    implements MenstrualTrackingRepository {}

void main() {
  late MockMenstrualRepository repository;
  final date = DateTime(2026, 10);
  const existing = MenstrualObservation(
    localDate: '2026-10-01',
    status: BleedingStatus.period,
    flow: MenstrualFlow.heavy,
    isPeriodStart: true,
    note: 'previous note',
  );

  setUp(() {
    repository = MockMenstrualRepository();
    registerFallbackValue(existing);
    registerFallbackValue(const MenstrualPreferences());
    when(() => repository.watchPreferences()).thenAnswer(
      (_) => Stream.value(const MenstrualPreferences(enabled: true)),
    );
    when(() => repository.watchDay(any()))
        .thenAnswer((_) => Stream.value(null));
    when(() => repository.save(any())).thenAnswer((_) async {});
    when(() => repository.delete(any())).thenAnswer((_) async {});
    when(() => repository.purge()).thenAnswer((_) async {});
    when(() => repository.setPreferences(any())).thenAnswer((_) async {});
  });

  Future<void> pump(
    WidgetTester tester,
    Widget screen, {
    Locale locale = const Locale('en'),
    double textScale = 1,
  }) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => Scaffold(
            body: TextButton(
              onPressed: () {},
              child: const Text('home'),
            ),
          ),
          routes: [
            GoRoute(path: 'entry', builder: (_, _) => screen),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          menstrualTrackingRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          locale: locale,
          supportedLocales: const [Locale('en'), Locale('fr')],
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(textScale),
            ),
            child: child!,
          ),
        ),
      ),
    );
    unawaited(router.push<void>('/entry'));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'new entry has no assumed status, saves the selected civil date',
    (tester) async {
      await pump(tester, MenstrualEntryScreen(date: date));
      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, 'Save'))
            .onPressed,
        isNull,
      );
      await tester.tap(find.widgetWithText(ChoiceChip, 'Period'));
      await tester.pumpAndSettle();
      expect(find.byType(CheckboxListTile), findsOneWidget);
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();
      final saved =
          verify(() => repository.save(captureAny())).captured.single
              as MenstrualObservation;
      expect(saved.localDate, '2026-10-01');
      expect(saved.status, BleedingStatus.period);
      expect(saved.flow, isNull);
      expect(saved.isPeriodStart, isFalse);
      expect(find.text('home'), findsOneWidget);
    },
  );

  testWidgets(
    'changing to spotting clears incompatible fields and keeps the note',
    (tester) async {
      when(() => repository.watchDay(any()))
          .thenAnswer((_) => Stream.value(existing));
      await pump(tester, MenstrualEntryScreen(date: date));
      await tester.tap(find.widgetWithText(ChoiceChip, 'Spotting'));
      await tester.pumpAndSettle();
      expect(find.byType(CheckboxListTile), findsNothing);
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();
      final saved =
          verify(() => repository.save(captureAny())).captured.single
              as MenstrualObservation;
      expect(saved.status, BleedingStatus.spotting);
      expect(saved.flow, isNull);
      expect(saved.isPeriodStart, isFalse);
      expect(saved.note, 'previous note');
    },
  );

  testWidgets('deletion requires confirmation and leaves the day unlogged', (
    tester,
  ) async {
    when(() => repository.watchDay(any()))
        .thenAnswer((_) => Stream.value(existing));
    await pump(tester, MenstrualEntryScreen(date: date));
    await tester.ensureVisible(find.text('Delete'));
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    verifyNever(() => repository.delete(any()));
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();
    verify(() => repository.delete('2026-10-01')).called(1);
  });

  testWidgets('French form supports enlarged text without an overflow', (
    tester,
  ) async {
    await pump(
      tester,
      MenstrualEntryScreen(date: date),
      locale: const Locale('fr'),
      textScale: 2,
    );
    await tester.ensureVisible(find.widgetWithText(ChoiceChip, 'Règles'));
    await tester.tap(find.widgetWithText(ChoiceChip, 'Règles'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Enregistrer'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    verify(() => repository.save(any())).called(1);
  });

  testWidgets('future dates cannot be saved', (tester) async {
    await pump(
      tester,
      MenstrualEntryScreen(
        date: DateTime.now().add(const Duration(days: 2)),
      ),
    );
    expect(find.byType(ChoiceChip), findsNothing);
    verifyNever(() => repository.save(any()));
  });

  testWidgets('enabled card distinguishes an unknown day from no bleeding', (
    tester,
  ) async {
    await pump(tester, Scaffold(body: MenstrualDayCard(date: date)));
    expect(find.text('Not logged'), findsOneWidget);
    expect(find.text('No bleeding'), findsNothing);
  });

  testWidgets('disabled module hides the daily card', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          menstrualPreferencesProvider.overrideWith(
            (_) => Stream.value(const MenstrualPreferences()),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(body: MenstrualDayCard(date: date)),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('save error is visible and form remains editable', (
    tester,
  ) async {
    when(() => repository.save(any())).thenThrow(StateError('failure'));
    await pump(tester, MenstrualEntryScreen(date: date));
    await tester.tap(find.widgetWithText(ChoiceChip, 'No bleeding'));
    await tester.pump();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Something went wrong'), findsOneWidget);
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, isTrue);
  });

  testWidgets(
    'settings keep all choices explicit and confirm permanent erasure',
    (tester) async {
      when(() => repository.watchPreferences()).thenAnswer(
        (_) => Stream.value(const MenstrualPreferences()),
      );
      await pump(tester, const MenstrualSettingsScreen());
      expect(
        tester
            .widgetList<SwitchListTile>(find.byType(SwitchListTile))
            .every((tile) => !tile.value),
        isTrue,
      );
      await tester.tap(find.byType(Switch).first);
      await tester.pumpAndSettle();
      verify(
        () => repository.setPreferences(
          const MenstrualPreferences(enabled: true),
        ),
      ).called(1);
      await tester.ensureVisible(find.text('Permanently erase period data'));
      await tester.tap(find.text('Permanently erase period data'));
      await tester.pumpAndSettle();
      verifyNever(() => repository.purge());
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      verify(() => repository.purge()).called(1);
    },
  );
}
