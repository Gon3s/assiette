import 'package:assiette/features/coffee/domain/coffee_entry.dart';
import 'package:assiette/features/coffee/domain/coffee_repository.dart';
import 'package:assiette/features/coffee/presentation/coffee_actions.dart';
import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/favorites/domain/meal_template_option.dart';
import 'package:assiette/features/favorites/domain/quick_favorite_repository.dart';
import 'package:assiette/features/favorites/presentation/quick_action_screen.dart';
import 'package:assiette/features/favorites/presentation/widgets/favorites_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

class MockQuickFavoriteRepository extends Mock
    implements QuickFavoriteRepository {}

void main() {
  late MockCoffeeRepository coffee;
  late MockFavoritesRepository favorites;
  setUpAll(() {
    registerFallbackValue(DateTime(2026));
    registerFallbackValue(
      const MealTemplateOption(id: 'fallback', name: 'Fallback', tags: []),
    );
  });
  setUp(() {
    coffee = MockCoffeeRepository();
    favorites = MockFavoritesRepository();
    when(favorites.watchFavorites).thenAnswer((_) => Stream.value([]));
    when(() => coffee.add(any())).thenAnswer((_) async => 'coffee-1');
    when(() => coffee.setDeleted(any(), deleted: true))
        .thenAnswer((_) async {});
  });

  testWidgets('coffee is available without meal favorites and supports undo', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          coffeeRepositoryProvider.overrideWithValue(coffee),
          favoritesRepositoryProvider.overrideWithValue(favorites),
        ],
        child: const MaterialApp(home: Scaffold(body: FavoritesRow())),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Coffee'));
    await tester.pumpAndSettle();
    expect(find.text('Coffee added'), findsOneWidget);
    verify(() => coffee.add(any())).called(1);
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    verify(() => coffee.setDeleted('coffee-1', deleted: true)).called(1);
    verifyNever(() => favorites.logFavorite(any()));
  });

  testWidgets('summary shows the count and opens manual date selection', (
    tester,
  ) async {
    final day = DateTime(2026, 10, 25);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          coffeeDayProvider(day).overrideWith(
            (_) => Stream.value([
              CoffeeEntry(id: 'one', timestamp: day),
              CoffeeEntry(id: 'two', timestamp: day),
            ]),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(body: CoffeeSummary(date: day)),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('2 coffees'), findsOneWidget);
    await tester.tap(find.byTooltip('Add coffee at another time'));
    await tester.pumpAndSettle();
    expect(find.byType(DatePickerDialog), findsOneWidget);
    expect(
      tester
          .widget<DatePickerDialog>(find.byType(DatePickerDialog))
          .initialDate,
      day,
    );
  });

  for (final isCoffee in [true, false]) {
    testWidgets(
      '${isCoffee ? 'coffee' : 'favorite'} shortcut logs once and can run again',
      (tester) async {
        const template = MealTemplateOption(
          id: 'template',
          name: 'Breakfast',
          tags: [],
        );
        when(favorites.watchFavorites)
            .thenAnswer((_) => Stream.value([template]));
        when(() => favorites.logFavorite(template))
            .thenAnswer((_) async => 'meal-1');
        final router = GoRouter(
          initialLocation: '/quick',
          routes: [
            GoRoute(
              path: '/quick',
              builder: (_, _) => const QuickActionScreen(),
            ),
            GoRoute(
              path: '/',
              name: 'home',
              builder: (_, _) => const Scaffold(body: Text('Journal')),
            ),
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (_, _) => const Scaffold(body: Text('Settings')),
            ),
          ],
        );
        addTearDown(router.dispose);
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              coffeeRepositoryProvider.overrideWithValue(coffee),
              favoritesRepositoryProvider.overrideWithValue(favorites),
              quickFavoriteSelectionProvider.overrideWith(
                (_) => Stream.value(isCoffee ? null : 'template'),
              ),
            ],
            child: MaterialApp.router(routerConfig: router),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('Journal'), findsOneWidget);
        expect(
          find.text(isCoffee ? 'Coffee added' : 'Meal added'),
          findsOneWidget,
        );
        if (isCoffee) {
          verify(() => coffee.add(any())).called(1);
        } else {
          verify(() => favorites.logFavorite(template)).called(1);
        }
        await tester.pump();
        router.go('/quick');
        await tester.pumpAndSettle();
        if (isCoffee) {
          verify(() => coffee.add(any())).called(1);
        } else {
          verify(() => favorites.logFavorite(template)).called(1);
        }
      },
    );
  }

  testWidgets(
    'deleted favorite asks for configuration without logging',
    (tester) async {
      final settings = MockQuickFavoriteRepository();
      when(() => settings.select(coffeeQuickFavoriteId))
          .thenAnswer((_) async {});
      final router = GoRouter(
        initialLocation: '/quick',
        routes: [
          GoRoute(
            path: '/quick',
            builder: (_, _) => const QuickActionScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (_, _) => const Scaffold(body: Text('Settings')),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            coffeeRepositoryProvider.overrideWithValue(coffee),
            favoritesRepositoryProvider.overrideWithValue(favorites),
            quickFavoriteRepositoryProvider.overrideWithValue(settings),
            quickFavoriteSelectionProvider.overrideWith(
              (_) => Stream.value('deleted-template'),
            ),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Choose a favorite'), findsOneWidget);
      await tester.tap(find.text('Coffee'));
      await tester.pumpAndSettle();
      verify(() => settings.select(coffeeQuickFavoriteId)).called(1);
      verifyNever(() => coffee.add(any()));
      verifyNever(() => favorites.logFavorite(any()));
      expect(find.text('Settings'), findsOneWidget);
    },
  );
}
