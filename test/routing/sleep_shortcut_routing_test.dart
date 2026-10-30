import 'dart:async';

import 'package:assiette/features/onboarding/domain/onboarding_repository.dart';
import 'package:assiette/features/sleep_entry/domain/sleep_entry_repository.dart';
import 'package:assiette/features/sleep_entry/presentation/sleep_shortcut_screen.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:assiette/routing/app_startup.dart';
import 'package:assiette/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSleepEntryRepository extends Mock implements SleepEntryRepository {}

void main() {
  setUpAll(() => registerFallbackValue(DateTime(2026)));

  for (final startNight in [true, false]) {
    testWidgets(
      '${startNight ? 'bedtime' : 'wake'} cold shortcut survives startup '
      'and onboarding loading',
      (tester) async {
        final route = startNight ? AppRouter.sleepStart : AppRouter.sleepWake;
        tester.binding.platformDispatcher.defaultRouteNameTestValue =
            'assiette:/${route.name}';
        addTearDown(
          tester.binding.platformDispatcher.clearDefaultRouteNameTestValue,
        );
        final startup = Completer<AppDependencies>();
        final onboarding = StreamController<bool>();
        addTearDown(onboarding.close);
        final save = Completer<DateTime>();
        final repository = MockSleepEntryRepository();
        when(() => repository.startNight(any())).thenAnswer((_) => save.future);
        when(() => repository.recordWake(any())).thenAnswer((_) => save.future);
        final container = ProviderContainer(
          overrides: [
            appStartupProvider.overrideWith((_) => startup.future),
            onboardingDoneProvider.overrideWith((_) => onboarding.stream),
            sleepEntryRepositoryProvider.overrideWithValue(repository),
          ],
        );
        addTearDown(container.dispose);
        container.listen(goRouterProvider, (_, _) {});
        final router = container.read(goRouterProvider);
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp.router(routerConfig: router),
          ),
        );
        await tester.pump();
        expect(find.byType(AppStartupLoadingWidget), findsOneWidget);

        startup.complete(const AppDependencies());
        await tester.pump();
        await tester.pump();
        expect(container.read(goRouterProvider), same(router));
        verifyNever(() => repository.startNight(any()));
        verifyNever(() => repository.recordWake(any()));

        onboarding.add(true);
        for (var i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        expect(container.read(goRouterProvider), same(router));
        expect(find.byType(SleepShortcutScreen), findsOneWidget);
        expect(find.byType(NotFoundScreen), findsNothing);
        expect(
          router.routeInformationProvider.value.uri.path,
          '/${route.name}',
        );
        expect(router.routeInformationProvider.value.uri.hasScheme, isFalse);
        if (startNight) {
          verify(() => repository.startNight(any())).called(1);
          verifyNever(() => repository.recordWake(any()));
        } else {
          verify(() => repository.recordWake(any())).called(1);
          verifyNever(() => repository.startNight(any()));
        }

        // A second shortcut arrives through the same router in a running app.
        final nextRoute = startNight
            ? AppRouter.sleepWake
            : AppRouter.sleepStart;
        router.go('assiette:/${nextRoute.name}');
        for (var i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        expect(find.byType(NotFoundScreen), findsNothing);
        expect(
          router.routeInformationProvider.value.uri.path,
          '/${nextRoute.name}',
        );
        if (startNight) {
          verify(() => repository.recordWake(any())).called(1);
        } else {
          verify(() => repository.startNight(any())).called(1);
        }
        await tester.pumpWidget(const SizedBox.shrink());
        save.complete(DateTime(2026));
        await tester.pump();
      },
    );
  }
}
