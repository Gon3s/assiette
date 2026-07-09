import 'package:assiette/features/day_view/presentation/day_view_screen.dart';
import 'package:assiette/features/meal_entry/presentation/meal_entry_screen.dart';
import 'package:assiette/features/symptom_entry/presentation/symptom_entry_screen.dart';
import 'package:assiette/routing/app_startup.dart';
import 'package:assiette/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// The application router.
enum AppRouter {
  /// The startup screen.
  startup,

  /// The home screen.
  home,

  /// The meal entry screen.
  mealEntry,

  /// The symptom entry screen.
  symptomEntry,
}

/// The application router provider.
@riverpod
GoRouter goRouter(Ref ref) {
  final appStartupState = ref.watch(appStartupProvider);

  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      if (appStartupState.isLoading || appStartupState.hasError) {
        return '/${AppRouter.startup.name}';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/${AppRouter.startup.name}',
        pageBuilder: (context, state) => NoTransitionPage(
          child: AppStartupWidget(onLoaded: (_) => const SizedBox.shrink()),
        ),
      ),
      GoRoute(
        path: '/',
        name: AppRouter.home.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: DayViewScreen()),
        routes: [
          GoRoute(
            path: 'meal-entry',
            name: AppRouter.mealEntry.name,
            builder: (context, state) => const MealEntryScreen(),
          ),
          GoRoute(
            path: 'symptom-entry',
            name: AppRouter.symptomEntry.name,
            builder: (context, state) => const SymptomEntryScreen(),
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) =>
        const NoTransitionPage(child: NotFoundScreen()),
  );
}
