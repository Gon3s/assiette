import 'package:assiette/features/migraine_stats/domain/migraine_stats.dart';
import 'package:assiette/features/migraine_stats/domain/migraine_stats_repository.dart';
import 'package:assiette/features/migraine_stats/presentation/migraine_stats_screen.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('opens the complete history from the statistics', (tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const MigraineStatsScreen(),
        ),
        GoRoute(
          path: '/history',
          name: AppRouter.migraineHistory.name,
          builder: (context, state) =>
              const Scaffold(body: Text('All episodes')),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          migraineStatsRepositoryProvider.overrideWithValue(
            _FakeMigraineStatsRepository(),
          ),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Migraine history'));
    await tester.pumpAndSettle();
    expect(find.text('All episodes'), findsOneWidget);
  });

  testWidgets('shows the main indicators and treatment summary', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          migraineStatsRepositoryProvider.overrideWithValue(
            _FakeMigraineStatsRepository(),
          ),
        ],
        child: const MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('fr'), Locale('en')],
          home: MigraineStatsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Migraines et traitements'), findsOneWidget);
    expect(find.text('3'), findsWidgets);
    expect(find.text('Crises'), findsOneWidget);
    expect(find.text('3h 30min'), findsOneWidget);
    expect(find.text('Évolution des crises'), findsOneWidget);
    expect(find.text('Ibuprofène'), findsOneWidget);
    expect(find.textContaining('2 prises'), findsWidgets);
  });
}

class _FakeMigraineStatsRepository implements MigraineStatsRepository {
  @override
  Future<MigraineStats> load(MigraineStatsPeriod period, DateTime now) async =>
      MigraineStats(
        start: now.subtract(Duration(days: period.days)),
        end: now,
        migraineCount: 3,
        migraineDays: 2,
        averageDuration: const Duration(hours: 3, minutes: 30),
        averageMaximumIntensity: 7.5,
        medicationIntakeCount: 2,
        medicationDays: 1,
        frequency: [
          MigraineFrequencyBucket(
            start: now.subtract(const Duration(days: 7)),
            end: now,
            count: 3,
          ),
        ],
        medications: const [
          MedicationStats(
            name: 'Ibuprofène',
            intakeCount: 2,
            linkedMigraineCount: 2,
            averageDelayAfterMigraineStart: Duration(hours: 1),
          ),
        ],
      );
}
