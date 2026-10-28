@Timeout(Duration(seconds: 5))
library;

import 'dart:async';

import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/features/sleep_entry/domain/sleep_entry_repository.dart';
import 'package:assiette/features/sleep_entry/presentation/sleep_entry_controller.dart';
import 'package:assiette/features/sleep_entry/presentation/sleep_entry_screen.dart';
import 'package:assiette/features/sleep_entry/presentation/sleep_shortcut_screen.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockSleepEntryRepository extends Mock implements SleepEntryRepository {}

void main() {
  setUpAll(() => registerFallbackValue(DateTime(2026)));

  testWidgets(
    'wake shortcut refreshes the real form from a cached open night',
    (
      tester,
    ) async {
      final night = DateTime(2026, 7, 8);
      final bedtime = DateTime(2026, 7, 7, 22);
      final repository = MockSleepEntryRepository();
      when(() => repository.recordWake(any())).thenAnswer((_) async => night);
      final updates = StreamController<SleepSummary?>.broadcast();
      addTearDown(updates.close);
      final container = ProviderContainer(
        overrides: [
          sleepEntryRepositoryProvider.overrideWithValue(repository),
          daySleepProvider(night).overrideWith((_) async* {
            yield SleepSummary(id: 'night', bedTime: bedtime);
            yield* updates.stream;
          }),
        ],
      );
      addTearDown(container.dispose);
      container.read(selectedDateProvider.notifier).select(night);
      container.listen(daySleepProvider(night), (_, _) {});
      await container.read(daySleepProvider(night).future);
      container.listen(sleepEntryControllerProvider, (_, _) {});
      expect(container.read(sleepEntryControllerProvider).wakeTime, isNull);
      final router = GoRouter(
        initialLocation: '/wake',
        routes: [
          GoRoute(
            path: '/wake',
            builder: (_, _) => const SleepShortcutScreen(startNight: false),
          ),
          GoRoute(
            path: '/sleep-entry',
            name: AppRouter.sleepEntry.name,
            builder: (_, _) => const SleepEntryScreen(),
          ),
        ],
      );
      addTearDown(router.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Good'));
      await tester.pump();

      updates.add(
        SleepSummary(
          id: 'night',
          bedTime: bedtime,
          wakeTime: DateTime(2026, 7, 8, 7, 20),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('07:20'), findsOneWidget);
      expect(find.text('22:00'), findsOneWidget);
      expect(find.text('Wake time'), findsNothing);
      expect(container.read(sleepEntryControllerProvider).quality, 3);
      expect(container.read(selectedDateProvider), night);
    },
  );

  for (final startNight in [true, false]) {
    testWidgets(
      '${startNight ? 'bedtime' : 'wake'} navigates after saving '
      'without waiting for the journal stream',
      (tester) async {
        final night = DateTime(2026, 7, 7);
        final repository = MockSleepEntryRepository();
        when(() => repository.startNight(any())).thenAnswer((_) async => night);
        when(() => repository.recordWake(any())).thenAnswer((_) async => night);
        final pendingSleep = StreamController<SleepSummary?>.broadcast();
        addTearDown(pendingSleep.close);
        final container = ProviderContainer(
          overrides: [
            sleepEntryRepositoryProvider.overrideWithValue(repository),
            daySleepProvider(night).overrideWith((_) => pendingSleep.stream),
          ],
        );
        addTearDown(container.dispose);
        container.listen(selectedDateProvider, (_, _) {});
        final router = GoRouter(
          initialLocation: '/shortcut',
          routes: [
            GoRoute(
              path: '/',
              name: AppRouter.home.name,
              builder: (_, _) => const Scaffold(body: Text('Journal')),
            ),
            GoRoute(
              path: '/sleep-entry',
              name: AppRouter.sleepEntry.name,
              builder: (_, _) => const Scaffold(body: Text('Sleep form')),
            ),
            GoRoute(
              path: '/shortcut',
              builder: (_, _) => SleepShortcutScreen(startNight: startNight),
            ),
          ],
        );
        addTearDown(router.dispose);

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp.router(routerConfig: router),
          ),
        );
        await tester.pumpAndSettle(
          const Duration(milliseconds: 100),
          EnginePhase.sendSemanticsUpdate,
          const Duration(seconds: 1),
        );

        expect(
          find.text(startNight ? 'Journal' : 'Sleep form'),
          findsOneWidget,
        );
        expect(container.read(selectedDateProvider), night);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        if (startNight) {
          verify(() => repository.startNight(any())).called(1);
          verifyNever(() => repository.recordWake(any()));
        } else {
          verify(() => repository.recordWake(any())).called(1);
          verifyNever(() => repository.startNight(any()));
        }
      },
    );
  }
}
