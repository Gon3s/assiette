import 'dart:async';

import 'package:assiette/features/coffee/domain/coffee_repository.dart';
import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/favorites/domain/quick_favorite_repository.dart';
import 'package:assiette/features/favorites/presentation/quick_action_screen.dart';
import 'package:assiette/features/onboarding/domain/onboarding_repository.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:assiette/routing/app_startup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  setUpAll(() => registerFallbackValue(DateTime(2026)));

  testWidgets(
    'cold favorite shortcut defaults to coffee and waits for startup',
    (tester) async {
      tester.binding.platformDispatcher.defaultRouteNameTestValue =
          'assiette:/favoriteQuick';
      addTearDown(
        tester.binding.platformDispatcher.clearDefaultRouteNameTestValue,
      );
      final startup = Completer<AppDependencies>();
      final onboarding = StreamController<bool>();
      addTearDown(onboarding.close);
      final save = Completer<String>();
      final coffee = MockCoffeeRepository();
      final favorites = MockFavoritesRepository();
      when(() => coffee.add(any())).thenAnswer((_) => save.future);
      final container = ProviderContainer(
        overrides: [
          appStartupProvider.overrideWith((_) => startup.future),
          onboardingDoneProvider.overrideWith((_) => onboarding.stream),
          coffeeRepositoryProvider.overrideWithValue(coffee),
          favoritesRepositoryProvider.overrideWithValue(favorites),
          quickFavoriteSelectionProvider.overrideWith(
            (_) => Stream.value(null),
          ),
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
      verifyNever(() => coffee.add(any()));
      startup.complete(const AppDependencies());
      await tester.pump();
      verifyNever(() => coffee.add(any()));
      onboarding.add(true);
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(find.byType(QuickActionScreen), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.path, '/favoriteQuick');
      verify(() => coffee.add(any())).called(1);
      await tester.pump();
      verifyNever(() => coffee.add(any()));
      // Coffee does not depend on the meal favorites stream.
      verifyNever(favorites.watchFavorites);
      await tester.pumpWidget(const SizedBox.shrink());
      save.complete('coffee-1');
      await tester.pump();
    },
  );
}
