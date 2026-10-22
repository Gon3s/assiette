@Timeout(Duration(seconds: 5))
library;

import 'dart:async';

import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/features/sleep_entry/domain/sleep_entry_repository.dart';
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
