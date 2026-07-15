@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/favorites/domain/meal_template_option.dart';
import 'package:assiette/features/favorites/presentation/favorite_form_screen.dart';
import 'package:assiette/features/favorites/presentation/favorites_manage_screen.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  late MockFavoritesRepository repository;

  const template = MealTemplateOption(
    id: 'template-1',
    name: 'Salade César',
    defaultMealType: MealType.lunch,
    tags: [TagOption(id: 'tag-1', label: 'gluten', isSystem: true)],
  );

  setUp(() {
    repository = MockFavoritesRepository();
  });

  Future<GoRouter> pumpScreen(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/favorites',
      routes: [
        GoRoute(path: '/', builder: (_, _) => const Scaffold()),
        GoRoute(
          path: '/favorites',
          name: AppRouter.favoritesManage.name,
          builder: (_, _) => const FavoritesManageScreen(),
          routes: [
            GoRoute(
              path: 'form',
              name: AppRouter.favoriteForm.name,
              builder: (context, state) => FavoriteFormScreen(
                templateId: state.uri.queryParameters['id'],
              ),
            ),
          ],
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [favoritesRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();
    return router;
  }

  testWidgets('shows the empty state message', (tester) async {
    when(repository.watchFavorites).thenAnswer((_) => Stream.value([]));

    await pumpScreen(tester);

    expect(find.text('No favorites yet.'), findsOneWidget);
  });

  testWidgets('lists favorites with their meal type and tags', (
    tester,
  ) async {
    when(
      repository.watchFavorites,
    ).thenAnswer((_) => Stream.value([template]));

    await pumpScreen(tester);

    expect(find.text('Salade César'), findsOneWidget);
    expect(find.text('Lunch · gluten'), findsOneWidget);
  });

  testWidgets('tapping the add FAB opens the create form', (tester) async {
    when(repository.watchFavorites).thenAnswer((_) => Stream.value([]));

    await pumpScreen(tester);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.byType(FavoriteFormScreen), findsOneWidget);
    expect(find.text('New favorite'), findsOneWidget);
  });

  testWidgets('tapping a favorite opens the edit form', (tester) async {
    when(
      repository.watchFavorites,
    ).thenAnswer((_) => Stream.value([template]));

    await pumpScreen(tester);
    await tester.tap(find.text('Salade César'));
    await tester.pumpAndSettle();

    expect(find.byType(FavoriteFormScreen), findsOneWidget);
    expect(find.text('Edit favorite'), findsOneWidget);
  });

  testWidgets('deleting a favorite asks for confirmation, then calls the '
      'repository', (tester) async {
    when(
      repository.watchFavorites,
    ).thenAnswer((_) => Stream.value([template]));
    when(
      () => repository.deleteFavorite('template-1'),
    ).thenAnswer((_) async {});

    await pumpScreen(tester);
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    expect(find.text('Delete this favorite?'), findsOneWidget);
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    verify(() => repository.deleteFavorite('template-1')).called(1);
    expect(find.text('Favorite deleted'), findsOneWidget);
  });

  testWidgets('canceling the delete confirmation keeps the favorite', (
    tester,
  ) async {
    when(
      repository.watchFavorites,
    ).thenAnswer((_) => Stream.value([template]));

    await pumpScreen(tester);
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    verifyNever(() => repository.deleteFavorite(any()));
    expect(find.text('Salade César'), findsOneWidget);
  });
}
