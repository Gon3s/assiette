import 'dart:async';

import 'package:assiette/data/db/enums/migraine_start_precision.dart';
import 'package:assiette/data/db/enums/symptom_type.dart';
import 'package:assiette/features/migraine_history/domain/migraine_history_entry.dart';
import 'package:assiette/features/migraine_history/presentation/migraine_history_controller.dart';
import 'package:assiette/features/migraine_history/presentation/migraine_history_screen.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets(
    'shows loading, unknown starts, linked intakes and live updates',
    (
      tester,
    ) async {
      final stream = StreamController<List<MigraineHistoryEntry>>();
      addTearDown(stream.close);
      await tester.pumpWidget(_app(stream.stream));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      stream.add([
        _entry(
          'unknown',
          intakes: [
            MigraineHistoryIntake(
              id: 'intake',
              name: 'Ibuprofène',
              timestamp: DateTime(2026, 10, 27, 13, 45),
              dose: '400 mg',
            ),
          ],
        ),
      ]);
      await tester.pumpAndSettle();
      expect(find.text('Crise en cours'), findsOneWidget);
      expect(find.textContaining('Début : Inconnu'), findsOneWidget);
      expect(find.textContaining('08:23'), findsNothing);
      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();
      expect(find.text('Ibuprofène'), findsOneWidget);
      expect(find.textContaining('400 mg'), findsOneWidget);
      expect(find.textContaining('13:45'), findsOneWidget);

      stream.add([]);
      await tester.pumpAndSettle();
      expect(find.text('Aucune migraine enregistrée.'), findsOneWidget);
    },
  );

  testWidgets('labels approximate starts and known ends', (tester) async {
    final entry = _entry('ended');
    await tester.pumpWidget(
      _app(
        Stream.value([
          entry.copyWith(
            migraine: entry.migraine.copyWith(
              startedAt: DateTime(2020, 1, 2, 9),
              startPrecision: MigraineStartPrecision.approximate,
              endedAt: DateTime(2020, 1, 2, 12),
            ),
          ),
        ]),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Crise terminée'), findsOneWidget);
    expect(find.textContaining('Début approximatif :'), findsOneWidget);
    expect(find.textContaining('Fin :'), findsOneWidget);
    await tester.tap(find.byType(ExpansionTile));
    await tester.pumpAndSettle();
    expect(find.text('Aucune prise associée à cette crise.'), findsOneWidget);
  });

  testWidgets('shows an error and retries the history subscription', (
    tester,
  ) async {
    var attempts = 0;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          migraineHistoryProvider.overrideWith((ref) {
            attempts++;
            return attempts == 1
                ? Stream.error(StateError('load failed'))
                : Stream.value([]);
          }),
        ],
        child: _materialApp(const MigraineHistoryScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Impossible de charger les migraines.'), findsOneWidget);
    await tester.tap(find.text('Réessayer'));
    await tester.pumpAndSettle();
    expect(find.text('Aucune migraine enregistrée.'), findsOneWidget);
  });

  testWidgets('opens the existing editor and keeps the scroll position', (
    tester,
  ) async {
    final entries = List.generate(30, (index) => _entry('migraine-$index'));
    SymptomDraft? openedDraft;
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const MigraineHistoryScreen(),
        ),
        GoRoute(
          path: '/edit',
          name: AppRouter.symptomEntry.name,
          builder: (context, state) {
            openedDraft = state.extra! as SymptomDraft;
            return Scaffold(
              appBar: AppBar(
                leading: BackButton(onPressed: () => context.pop()),
              ),
              body: const Text('Existing editor'),
            );
          },
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          migraineHistoryProvider.overrideWith((ref) => Stream.value(entries)),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          locale: const Locale('fr'),
          localizationsDelegates: _delegates,
          supportedLocales: const [Locale('fr'), Locale('en')],
        ),
      ),
    );
    await tester.pumpAndSettle();
    final target = find.byKey(const ValueKey('migraine-20'));
    await tester.scrollUntilVisible(target, 300);
    await tester.tap(
      find.descendant(of: target, matching: find.byType(ExpansionTile)),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Modifier la migraine'));
    await tester.pumpAndSettle();
    final position = tester.getTopLeft(target);
    await tester.tap(find.text('Modifier la migraine'));
    await tester.pumpAndSettle();
    expect(openedDraft, entries[20].migraine);
    expect(find.text('Existing editor'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(target), position);
    expect(find.text('Modifier la migraine'), findsOneWidget);
  });
}

MigraineHistoryEntry _entry(
  String id, {
  List<MigraineHistoryIntake> intakes = const [],
}) => MigraineHistoryEntry(
  migraine: SymptomDraft(
    id: id,
    timestamp: DateTime(2026, 10, 27, 8, 23),
    type: SymptomType.migraine,
    intensity: 5,
    startPrecision: MigraineStartPrecision.unknown,
  ),
  intakes: intakes,
);

const List<LocalizationsDelegate<dynamic>> _delegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

Widget _materialApp(Widget home) => MaterialApp(
  locale: const Locale('fr'),
  localizationsDelegates: _delegates,
  supportedLocales: const [Locale('fr'), Locale('en')],
  home: home,
);

Widget _app(Stream<List<MigraineHistoryEntry>> stream) => ProviderScope(
  overrides: [migraineHistoryProvider.overrideWith((ref) => stream)],
  child: _materialApp(const MigraineHistoryScreen()),
);
