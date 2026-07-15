@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/features/onboarding/domain/onboarding_repository.dart';
import 'package:assiette/features/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late MockOnboardingRepository repository;

  setUp(() {
    repository = MockOnboardingRepository();
    when(repository.completeOnboarding).thenAnswer((_) async {});
  });

  Future<GoRouter> pumpScreen(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/onboarding',
      routes: [
        GoRoute(path: '/', builder: (_, _) => const Scaffold()),
        GoRoute(
          path: '/onboarding',
          builder: (_, _) => const OnboardingScreen(),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          onboardingRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    return router;
  }

  Future<void> goToLastPage(WidgetTester tester) async {
    // English fallback since no localization ancestor.
    for (var i = 0; i < 3; i++) {
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }
  }

  testWidgets('shows the value proposition first, with a skip action', (
    tester,
  ) async {
    await pumpScreen(tester);

    expect(find.text('Food, symptoms, environment'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('tapping skip completes onboarding and leaves the screen', (
    tester,
  ) async {
    final router = await pumpScreen(tester);

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    verify(repository.completeOnboarding).called(1);
    expect(router.routerDelegate.currentConfiguration.uri.toString(), '/');
  });

  testWidgets('the last page offers a location permission choice', (
    tester,
  ) async {
    await pumpScreen(tester);
    await goToLastPage(tester);

    expect(find.text('Allow location'), findsNWidgets(2));
    expect(find.text('Maybe later'), findsOneWidget);
    // No skip action once on the final page.
    expect(find.text('Skip'), findsNothing);
  });

  testWidgets('tapping "maybe later" completes onboarding without asking', (
    tester,
  ) async {
    final router = await pumpScreen(tester);
    await goToLastPage(tester);

    await tester.tap(find.text('Maybe later'));
    await tester.pumpAndSettle();

    verify(repository.completeOnboarding).called(1);
    expect(router.routerDelegate.currentConfiguration.uri.toString(), '/');
  });

  testWidgets(
    'tapping "allow location" completes onboarding and leaves the screen',
    (tester) async {
      final router = await pumpScreen(tester);
      await goToLastPage(tester);

      await tester.tap(find.widgetWithText(FilledButton, 'Allow location'));
      await tester.pumpAndSettle();

      verify(repository.completeOnboarding).called(1);
      expect(router.routerDelegate.currentConfiguration.uri.toString(), '/');
    },
  );
}
