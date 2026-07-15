@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/meal_entry/domain/meal_entry_repository.dart';
import 'package:assiette/features/meal_entry/domain/meal_photo_service.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:assiette/features/meal_entry/presentation/meal_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockMealEntryRepository extends Mock implements MealEntryRepository {}

class MockMealPhotoService extends Mock implements MealPhotoService {}

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  late MockMealEntryRepository repository;
  late MockMealPhotoService photoService;
  late MockFavoritesRepository favoritesRepository;

  const seededTags = [
    TagOption(id: 'tag-1', label: 'café', isSystem: true),
    TagOption(id: 'tag-2', label: 'gluten', isSystem: true),
  ];

  setUpAll(() {
    registerFallbackValue(MealType.lunch);
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    repository = MockMealEntryRepository();
    photoService = MockMealPhotoService();
    favoritesRepository = MockFavoritesRepository();
    when(repository.watchTags).thenAnswer((_) => Stream.value(seededTags));
    when(
      () => repository.saveMeal(
        timestamp: any(named: 'timestamp'),
        mealType: any(named: 'mealType'),
        tagIds: any(named: 'tagIds'),
        photoPath: any(named: 'photoPath'),
        note: any(named: 'note'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => favoritesRepository.createFavorite(
        name: any(named: 'name'),
        tagIds: any(named: 'tagIds'),
        defaultMealType: any(named: 'defaultMealType'),
        defaultPhotoPath: any(named: 'defaultPhotoPath'),
      ),
    ).thenAnswer((_) async {});
  });

  Future<GoRouter> pumpScreen(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, _) => const Scaffold()),
        GoRoute(
          path: '/meal-entry',
          builder: (_, _) => const MealEntryScreen(),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          mealEntryRepositoryProvider.overrideWithValue(repository),
          mealPhotoServiceProvider.overrideWithValue(photoService),
          favoritesRepositoryProvider.overrideWithValue(favoritesRepository),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    // Push the entry screen like the day view does, so pop() can return.
    router.push('/meal-entry');
    await tester.pumpAndSettle();
    return router;
  }

  testWidgets('shows the form with a photo button and meal types', (
    tester,
  ) async {
    await pumpScreen(tester);

    // English fallback since no localization ancestor.
    expect(find.text('New meal'), findsOneWidget);
    expect(find.text('Take a photo'), findsOneWidget);
    expect(find.text('Breakfast'), findsOneWidget);
    expect(find.text('Lunch'), findsOneWidget);
    expect(find.text('Dinner'), findsOneWidget);
    expect(find.text('Snack'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Save as favorite'), findsOneWidget);
  });

  testWidgets('searching a tag suggests it and selects it on tap', (
    tester,
  ) async {
    await pumpScreen(tester);

    await tester.enterText(
      find.widgetWithText(TextField, 'Search or create a tag'),
      'caf',
    );
    await tester.pump();

    await tester.tap(find.text('café'));
    await tester.pump();

    expect(find.byType(InputChip), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(InputChip),
        matching: find.text('café'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('typing an unknown tag offers to create it', (tester) async {
    when(() => repository.createTag('pizza')).thenAnswer(
      (_) async =>
          const TagOption(id: 'tag-3', label: 'pizza', isSystem: false),
    );

    await pumpScreen(tester);

    await tester.enterText(
      find.widgetWithText(TextField, 'Search or create a tag'),
      'pizza',
    );
    await tester.pump();

    await tester.tap(find.text('Create "pizza"'));
    await tester.pump();

    verify(() => repository.createTag('pizza')).called(1);
    expect(find.byType(InputChip), findsOneWidget);
  });

  testWidgets('saving calls the repository and pops back', (tester) async {
    final router = await pumpScreen(tester);

    await tester.tap(find.text('Dinner'));
    await tester.pump();

    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    verify(
      () => repository.saveMeal(
        timestamp: any(named: 'timestamp'),
        mealType: MealType.dinner,
        tagIds: [],
        note: '',
      ),
    ).called(1);
    expect(
      router.routerDelegate.currentConfiguration.uri.toString(),
      '/',
    );
  });

  testWidgets('saving as favorite prompts for a name then calls the '
      'favorites repository', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.text('Dinner'));
    await tester.pump();
    await tester.enterText(
      find.widgetWithText(TextField, 'Search or create a tag'),
      'caf',
    );
    await tester.pump();
    await tester.tap(find.text('café'));
    await tester.pump();

    // Selecting a tag pushes the button below the sliver's cache extent, so
    // it isn't built yet: drag until it is, instead of ensureVisible.
    await tester.dragUntilVisible(
      find.text('Save as favorite'),
      find.byType(ListView),
      const Offset(0, -100),
    );
    await tester.tap(find.text('Save as favorite'));
    await tester.pumpAndSettle();

    expect(find.text('Favorite name'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, 'E.g. Caesar salad'),
      'Pizza du vendredi',
    );
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    verify(
      () => favoritesRepository.createFavorite(
        name: 'Pizza du vendredi',
        tagIds: ['tag-1'],
        defaultMealType: MealType.dinner,
      ),
    ).called(1);
    expect(find.text('Favorite saved'), findsOneWidget);
  });

  testWidgets('canceling the favorite dialog does not save', (tester) async {
    await pumpScreen(tester);

    await tester.ensureVisible(find.text('Save as favorite'));
    await tester.tap(find.text('Save as favorite'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    verifyNever(
      () => favoritesRepository.createFavorite(
        name: any(named: 'name'),
        tagIds: any(named: 'tagIds'),
      ),
    );
  });
}
