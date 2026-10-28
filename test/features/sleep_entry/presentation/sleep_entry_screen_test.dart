@Timeout(Duration(seconds: 5))
library;

import 'dart:async';

import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/features/sleep_entry/domain/sleep_entry_repository.dart';
import 'package:assiette/features/sleep_entry/presentation/sleep_entry_controller.dart';
import 'package:assiette/features/sleep_entry/presentation/sleep_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockDayViewRepository extends Mock implements DayViewRepository {}

class MockSleepEntryRepository extends Mock implements SleepEntryRepository {}

void main() {
  late MockDayViewRepository dayViewRepository;
  late MockSleepEntryRepository sleepEntryRepository;

  setUpAll(() {
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    dayViewRepository = MockDayViewRepository();
    sleepEntryRepository = MockSleepEntryRepository();
    when(() => dayViewRepository.watchSleepForNight(any())).thenAnswer(
      (_) => Stream.value(
        SleepSummary(
          quality: 2,
          bedTime: DateTime(2026, 1, 1, 23),
          wakeTime: DateTime(2026, 1, 1, 7),
        ),
      ),
    );
    when(
      () => sleepEntryRepository.saveSleepEntry(
        day: any(named: 'day'),
        quality: any(named: 'quality'),
        bedTime: any(named: 'bedTime'),
        wakeTime: any(named: 'wakeTime'),
      ),
    ).thenAnswer((_) async {});
  });

  Future<GoRouter> pumpScreen(
    WidgetTester tester, {
    bool preload = true,
  }) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, _) => const Scaffold()),
        GoRoute(
          path: '/sleep-entry',
          builder: (_, _) => const SleepEntryScreen(),
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [
        dayViewRepositoryProvider.overrideWithValue(dayViewRepository),
        sleepEntryRepositoryProvider.overrideWithValue(sleepEntryRepository),
      ],
    );
    addTearDown(container.dispose);
    // Keep daySleepProvider alive (it's auto-dispose) and resolve the sleep
    // before pushing, so the form seeds from it.
    final day = container.read(selectedDateProvider);
    if (preload) {
      container.listen(daySleepProvider(day), (_, _) {});
      await container.read(daySleepProvider(day).future);
    }

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    // Push the entry screen like the day view does, so pop() can return.
    unawaited(router.push('/sleep-entry'));
    await tester.pumpAndSettle();
    return router;
  }

  testWidgets('shows the form seeded with the logged sleep', (tester) async {
    await pumpScreen(tester);

    // English fallback since no localization ancestor.
    expect(find.text('Sleep'), findsOneWidget);
    expect(find.text('Okay'), findsOneWidget);
    // Bed/wake time are pre-filled, so the picker buttons are replaced by
    // chips (exact formatting is locale-dependent).
    expect(find.text('Bed time'), findsNothing);
    expect(find.text('Wake time'), findsNothing);
    expect(find.byIcon(Icons.bedtime_outlined), findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny_outlined), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets('loads the saved night when opened without a cached provider', (
    tester,
  ) async {
    when(() => dayViewRepository.watchSleepForNight(any())).thenAnswer(
      (_) => Stream.value(
        SleepSummary(
          id: 'cold-night',
          bedTime: DateTime(2026, 7, 7, 23),
          wakeTime: DateTime(2026, 7, 8, 7),
          note: 'Woke up once',
        ),
      ),
    );

    await pumpScreen(tester, preload: false);

    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    expect(find.text('Bed time'), findsNothing);
    expect(find.text('Wake time'), findsNothing);
    expect(find.text('Woke up once'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('removing the bed time shows the picker button again', (
    tester,
  ) async {
    await pumpScreen(tester);

    expect(find.text('Bed time'), findsNothing);
    await tester.tap(find.byTooltip('Remove bed time'));
    await tester.pump();

    expect(find.text('Bed time'), findsOneWidget);
  });

  testWidgets('manual evening bedtime belongs to the previous calendar day', (
    tester,
  ) async {
    when(() => dayViewRepository.watchSleepForNight(any()))
        .thenAnswer((_) => Stream.value(null));
    await pumpScreen(tester);
    await tester.tap(find.text('Bed time'));
    await tester.pumpAndSettle();
    final dialog = tester.element(find.byType(TimePickerDialog));
    Navigator.of(dialog).pop(const TimeOfDay(hour: 22, minute: 0));
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(
      tester.element(find.byType(SleepEntryScreen)),
    );
    final day = container.read(selectedDateProvider);
    expect(
      container.read(sleepEntryControllerProvider).bedTime,
      DateTime(day.year, day.month, day.day - 1, 22),
    );

    await tester.tap(find.text('Wake time'));
    await tester.pumpAndSettle();
    Navigator.of(tester.element(find.byType(TimePickerDialog)))
        .pop(const TimeOfDay(hour: 7, minute: 0));
    await tester.pumpAndSettle();
    expect(
      container.read(sleepEntryControllerProvider).wakeTime,
      DateTime(day.year, day.month, day.day, 7),
    );
  });

  testWidgets('saving calls the repository and pops back', (tester) async {
    final router = await pumpScreen(tester);

    await tester.tap(find.text('Good'));
    await tester.pump();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    verify(
      () => sleepEntryRepository.saveSleepEntry(
        day: any(named: 'day'),
        quality: 3,
        bedTime: DateTime(2026, 1, 1, 23),
        wakeTime: DateTime(2026, 1, 1, 7),
      ),
    ).called(1);
    expect(router.routerDelegate.currentConfiguration.uri.toString(), '/');
  });

  testWidgets('no delete action when the sleep has no id yet', (
    tester,
  ) async {
    await pumpScreen(tester);

    expect(find.byIcon(Icons.delete_outline), findsNothing);
  });

  group('deleting a logged night', () {
    setUp(() {
      when(() => dayViewRepository.watchSleepForNight(any())).thenAnswer(
        (_) => Stream.value(
          const SleepSummary(id: 'sleep-1', quality: 2),
        ),
      );
    });

    testWidgets('pops back and shows an undo snackbar', (tester) async {
      when(
        () => dayViewRepository.deleteSleepEntry('sleep-1'),
      ).thenAnswer((_) async {});
      when(
        () => dayViewRepository.undoDeleteSleepEntry('sleep-1'),
      ).thenAnswer((_) async {});

      final router = await pumpScreen(tester);
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      verify(() => dayViewRepository.deleteSleepEntry('sleep-1')).called(1);
      expect(router.routerDelegate.currentConfiguration.uri.toString(), '/');
      expect(find.text('Entry deleted'), findsOneWidget);

      // The SnackBar sits at the viewport edge in the test surface, so
      // invoke the action's callback directly rather than a hit-test tap.
      final action = tester.widget<SnackBarAction>(
        find.byType(SnackBarAction),
      );
      action.onPressed();
      verify(
        () => dayViewRepository.undoDeleteSleepEntry('sleep-1'),
      ).called(1);
    });
  });
}
