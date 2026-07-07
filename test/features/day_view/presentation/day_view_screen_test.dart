@Timeout(Duration(seconds: 5))
library;

import 'package:assiette/data/db/enums/meal_type.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/day_view/domain/day_view_repository.dart';
import 'package:assiette/features/day_view/domain/sleep_summary.dart';
import 'package:assiette/features/day_view/domain/timeline_item.dart';
import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:assiette/features/day_view/presentation/day_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDayViewRepository extends Mock implements DayViewRepository {}

void main() {
  late MockDayViewRepository repository;

  setUp(() {
    repository = MockDayViewRepository();
    when(() => repository.watchTimeline(any()))
        .thenAnswer((_) => Stream.value([]));
    when(() => repository.watchSleepForNight(any()))
        .thenAnswer((_) => Stream.value(null));
    when(() => repository.watchLatestWeather(any()))
        .thenAnswer((_) => Stream.value(null));
  });

  Future<void> pumpScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dayViewRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(home: DayViewScreen()),
      ),
    );
    await tester.pump();
  }

  testWidgets('shows the empty state when nothing is logged', (tester) async {
    await pumpScreen(tester);

    // English fallback since no localization ancestor.
    expect(find.text('Nothing logged this day.'), findsOneWidget);
    expect(find.text('Night not logged'), findsOneWidget);
    expect(find.text('Weather unavailable'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
  });

  testWidgets('shows both action buttons', (tester) async {
    await pumpScreen(tester);

    expect(find.text('Meal photo'), findsOneWidget);
    expect(find.text('Symptom'), findsOneWidget);
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

  testWidgets('shows sleep quality and weather when available',
      (tester) async {
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
}
