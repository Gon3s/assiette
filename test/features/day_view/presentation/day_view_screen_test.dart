@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_repository.dart';
import 'package:assiette/features/day_view/domain/active_migraine.dart';
import 'package:assiette/features/day_view/domain/daily_feeling.dart';
import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/domain/timeline_item.dart';
import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:assiette/features/day_view/presentation/day_view_screen.dart';
import 'package:assiette/features/favorites/domain/favorites_repository.dart';
import 'package:assiette/features/favorites/domain/meal_template_option.dart';
import 'package:assiette/features/meal_entry/domain/meal_draft.dart';
import 'package:assiette/features/meal_entry/domain/meal_entry_repository.dart';
import 'package:assiette/features/meal_entry/domain/tag_option.dart';
import 'package:assiette/features/meal_entry/presentation/meal_entry_screen.dart';
import 'package:assiette/features/sleep_entry/presentation/sleep_entry_screen.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_entry_repository.dart';
import 'package:assiette/features/symptom_entry/presentation/symptom_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockDayViewRepository extends Mock implements DayViewRepository {}

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

class MockMealEntryRepository extends Mock implements MealEntryRepository {}

class MockSymptomEntryRepository extends Mock
    implements SymptomEntryRepository {}

void main() {
  late MockDayViewRepository repository;
  late MockFavoritesRepository favoritesRepository;
  late MockMealEntryRepository mealEntryRepository;
  late MockSymptomEntryRepository symptomEntryRepository;

  setUp(() {
    repository = MockDayViewRepository();
    favoritesRepository = MockFavoritesRepository();
    mealEntryRepository = MockMealEntryRepository();
    symptomEntryRepository = MockSymptomEntryRepository();
    when(
      () => repository.watchTimeline(any()),
    ).thenAnswer((_) => Stream.value([]));
    when(
      () => repository.watchSleepForNight(any()),
    ).thenAnswer((_) => Stream.value(null));
    when(
      () => repository.watchDailyFeelings(any()),
    ).thenAnswer((_) => Stream.value([]));
    when(
      () => repository.watchActiveMigraine(),
    ).thenAnswer((_) => Stream.value(null));
    when(
      () => repository.watchLatestWeather(any()),
    ).thenAnswer((_) => Stream.value(null));
    when(
      favoritesRepository.watchFavorites,
    ).thenAnswer((_) => Stream.value([]));
  });

  Future<GoRouter> pumpScreen(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, _) => const DayViewScreen()),
        GoRoute(
          path: '/sleep-entry',
          name: 'sleepEntry',
          builder: (_, _) => const SleepEntryScreen(),
        ),
        GoRoute(
          path: '/meal-entry',
          name: 'mealEntry',
          builder: (_, state) =>
              MealEntryScreen(draft: state.extra as MealDraft?),
        ),
        GoRoute(
          path: '/symptom-entry',
          name: 'symptomEntry',
          builder: (_, state) =>
              SymptomEntryScreen(draft: state.extra as SymptomDraft?),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dayViewRepositoryProvider.overrideWithValue(repository),
          favoritesRepositoryProvider.overrideWithValue(favoritesRepository),
          mealEntryRepositoryProvider.overrideWithValue(mealEntryRepository),
          symptomEntryRepositoryProvider.overrideWithValue(
            symptomEntryRepository,
          ),
          // Avoids touching Google Sign-In / the real DB for the US-26
          // startup restore-offer check, which this screen now watches.
          shouldOfferRestoreProvider.overrideWith((ref) async => false),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();
    return router;
  }

  testWidgets('shows the empty state when nothing is logged', (tester) async {
    await pumpScreen(tester);

    // English fallback since no localization ancestor.
    expect(find.text('Nothing logged this day.'), findsOneWidget);
    expect(find.text('How did you sleep?'), findsOneWidget);
    expect(find.text('Weather unavailable'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
  });

  testWidgets('logs sleep quality with a single tap', (tester) async {
    when(
      () => repository.logSleepQuality(any(), any()),
    ).thenAnswer((_) async {});

    await pumpScreen(tester);
    await tester.tap(find.text('Good'));
    await tester.pump();

    verify(() => repository.logSleepQuality(any(), 3)).called(1);
  });

  testWidgets('tapping the logged sleep card opens the edit screen', (
    tester,
  ) async {
    when(() => repository.watchSleepForNight(any())).thenAnswer(
      (_) => Stream.value(const SleepSummary(quality: 3)),
    );

    await pumpScreen(tester);
    await tester.pump();
    expect(find.text('Sleep'), findsOneWidget);
    await tester.tap(find.text('Sleep'));
    await tester.pumpAndSettle();

    expect(find.byType(SleepEntryScreen), findsOneWidget);
  });

  testWidgets('shows both action buttons', (tester) async {
    await pumpScreen(tester);

    expect(find.text('Meal photo'), findsOneWidget);
    expect(find.text('Add'), findsOneWidget);
  });

  testWidgets('Add menu offers the four health entry paths', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(find.text('Migraine'), findsOneWidget);
    expect(find.text('Feeling'), findsOneWidget);
    expect(find.text('Mood of the day'), findsOneWidget);
    expect(find.text('Medication'), findsOneWidget);
  });

  testWidgets('swiping left moves to the next day', (tester) async {
    await pumpScreen(tester);

    expect(find.byIcon(Icons.today), findsNothing);

    await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.today), findsOneWidget);
    expect(find.text('Today'), findsNothing);
  });

  testWidgets('tapping the today shortcut returns to today', (tester) async {
    await pumpScreen(tester);

    await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.today), findsOneWidget);

    await tester.tap(find.byIcon(Icons.today));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.today), findsNothing);
    expect(find.text('Today'), findsOneWidget);
  });

  testWidgets('tapping the calendar icon opens a date picker', (
    tester,
  ) async {
    await pumpScreen(tester);

    await tester.tap(find.byIcon(Icons.calendar_month));
    await tester.pumpAndSettle();

    expect(find.byType(DatePickerDialog), findsOneWidget);
  });

  testWidgets('renders meals and symptoms on the timeline', (tester) async {
    when(() => repository.watchTimeline(any())).thenAnswer(
      (_) => Stream.value([
        TimelineItem.symptom(
          id: 'symptom-1',
          timestamp: DateTime.utc(2026, 7, 6, 9),
          symptomType: SymptomType.migraine,
          intensity: 7,
        ),
        TimelineItem.meal(
          id: 'meal-1',
          timestamp: DateTime.utc(2026, 7, 6, 12),
          mealType: MealType.lunch,
          tagLabels: const ['gluten', 'café'],
        ),
      ]),
    );

    await pumpScreen(tester);

    expect(find.text('Migraine'), findsOneWidget);
    expect(find.text('7'), findsOneWidget);
    expect(find.text('Lunch'), findsOneWidget);
    expect(find.text('gluten'), findsOneWidget);
    expect(find.text('café'), findsOneWidget);
    expect(find.text('Nothing logged this day.'), findsNothing);
  });

  testWidgets('shows the active migraine card with quick actions', (
    tester,
  ) async {
    when(() => repository.watchActiveMigraine()).thenAnswer(
      (_) => Stream.value(
        ActiveMigraine(
          id: 'migraine',
          startedAt: DateTime.now().subtract(const Duration(hours: 2)),
          lastIntensity: 8,
        ),
      ),
    );

    await pumpScreen(tester);

    expect(find.text('Active migraine'), findsOneWidget);
    expect(find.text('Update intensity'), findsOneWidget);
    expect(find.text('End'), findsOneWidget);
    expect(find.textContaining('8/10'), findsOneWidget);
  });

  testWidgets('shows daily feelings outside the timeline', (tester) async {
    when(() => repository.watchDailyFeelings(any())).thenAnswer(
      (_) => Stream.value(
        const [
          DailyFeeling(
            id: 'feeling',
            type: SymptomType.eczema,
            text: 'itchy arm',
          ),
        ],
      ),
    );

    await pumpScreen(tester);

    expect(find.text("Today's feelings"), findsOneWidget);
    expect(find.text('Eczema'), findsOneWidget);
    expect(find.text('itchy arm'), findsOneWidget);
    final feelingsCard = tester.widget<Card>(
      find.ancestor(
        of: find.text("Today's feelings"),
        matching: find.byType(Card),
      ),
    );
    expect(feelingsCard.margin?.bottom, 8);
  });

  testWidgets('scrolls the whole day instead of only the timeline', (
    tester,
  ) async {
    when(() => repository.watchTimeline(any())).thenAnswer(
      (_) => Stream.value([
        for (var index = 0; index < 10; index++)
          TimelineItem.meal(
            id: 'meal-$index',
            timestamp: DateTime.utc(2026, 7, 6, 12, index),
            mealType: MealType.lunch,
            tagLabels: const ['gluten'],
          ),
      ]),
    );

    await pumpScreen(tester);

    final header = find.text('Weather unavailable');
    final initialHeaderTop = tester.getTopLeft(header).dy;

    await tester.drag(
      find.byKey(const Key('day-view-scroll')),
      const Offset(0, -40),
    );
    await tester.pump();

    expect(tester.getTopLeft(header).dy, lessThan(initialHeaderTop));
  });

  testWidgets('shows sleep quality and weather when available', (tester) async {
    when(() => repository.watchSleepForNight(any())).thenAnswer(
      (_) => Stream.value(const SleepSummary(quality: 3)),
    );
    when(() => repository.watchLatestWeather(any())).thenAnswer(
      (_) => Stream.value(
        WeatherSummary(
          timestamp: DateTime.utc(2026, 7, 6, 14),
          pressure: 1009,
          pressureDelta: -4,
          temperature: 21.4,
        ),
      ),
    );

    await pumpScreen(tester);

    expect(find.text('Good'), findsOneWidget);
    expect(find.text('21°C'), findsOneWidget);
    expect(find.text('1009 hPa'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
  });

  group('favorites row', () {
    const template = MealTemplateOption(
      id: 'template-1',
      name: 'Salade César',
      tags: [TagOption(id: 'tag-1', label: 'gluten', isSystem: true)],
    );

    testWidgets('hides when there are no favorites', (tester) async {
      await pumpScreen(tester);

      expect(find.text('Salade César'), findsNothing);
    });

    testWidgets(
      'tapping a favorite logs it and shows a confirmation with undo',
      (tester) async {
        when(
          () => favoritesRepository.watchFavorites(),
        ).thenAnswer((_) => Stream.value([template]));
        when(
          () => favoritesRepository.logFavorite(template),
        ).thenAnswer((_) async => 'meal-1');

        await pumpScreen(tester);
        await tester.tap(find.text('Salade César'));
        await tester.pump();

        verify(() => favoritesRepository.logFavorite(template)).called(1);
        expect(find.text('Meal added'), findsOneWidget);
        expect(find.text('Undo'), findsOneWidget);
      },
    );

    testWidgets('tapping Undo removes the logged meal', (tester) async {
      when(
        () => favoritesRepository.watchFavorites(),
      ).thenAnswer((_) => Stream.value([template]));
      when(
        () => favoritesRepository.logFavorite(template),
      ).thenAnswer((_) async => 'meal-1');
      when(
        () => favoritesRepository.undoLogFavorite('meal-1'),
      ).thenAnswer((_) async {});

      await pumpScreen(tester);
      await tester.tap(find.text('Salade César'));
      await tester.pump();

      // The SnackBar sits at the viewport edge in the test surface, so
      // invoke the action's callback directly rather than a hit-test tap.
      final action = tester.widget<SnackBarAction>(
        find.byType(SnackBarAction),
      );
      action.onPressed();

      verify(() => favoritesRepository.undoLogFavorite('meal-1')).called(1);
    });
  });

  group('tapping a timeline entry', () {
    testWidgets('opens the meal for editing', (tester) async {
      when(() => repository.watchTimeline(any())).thenAnswer(
        (_) => Stream.value([
          TimelineItem.meal(
            id: 'meal-1',
            timestamp: DateTime.utc(2026, 7, 6, 12),
            mealType: MealType.lunch,
            tagLabels: const ['gluten'],
          ),
        ]),
      );
      when(() => mealEntryRepository.loadMeal('meal-1')).thenAnswer(
        (_) async => MealDraft(
          id: 'meal-1',
          timestamp: DateTime(2026, 7, 6, 12),
          mealType: MealType.lunch,
          tags: const [
            TagOption(id: 'tag-1', label: 'gluten', isSystem: true),
          ],
        ),
      );

      await pumpScreen(tester);
      await tester.tap(find.text('Lunch'));
      await tester.pumpAndSettle();

      expect(find.byType(MealEntryScreen), findsOneWidget);
      expect(find.text('Edit meal'), findsOneWidget);
    });

    testWidgets('opens the symptom for editing', (tester) async {
      when(() => repository.watchTimeline(any())).thenAnswer(
        (_) => Stream.value([
          TimelineItem.symptom(
            id: 'symptom-1',
            timestamp: DateTime.utc(2026, 7, 6, 9),
            symptomType: SymptomType.migraine,
            intensity: 7,
          ),
        ]),
      );
      when(() => symptomEntryRepository.loadSymptom('symptom-1')).thenAnswer(
        (_) async => SymptomDraft(
          id: 'symptom-1',
          timestamp: DateTime(2026, 7, 6, 9),
          type: SymptomType.migraine,
          intensity: 7,
        ),
      );

      await pumpScreen(tester);
      await tester.tap(find.text('Migraine'));
      await tester.pumpAndSettle();

      expect(find.byType(SymptomEntryScreen), findsOneWidget);
      expect(find.text('Edit symptom'), findsOneWidget);
    });
  });
}
