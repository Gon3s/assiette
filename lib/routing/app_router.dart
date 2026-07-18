import 'package:assiette/features/day_view/presentation/day_view_screen.dart';
import 'package:assiette/features/favorites/presentation/favorite_form_screen.dart';
import 'package:assiette/features/favorites/presentation/favorites_manage_screen.dart';
import 'package:assiette/features/meal_entry/domain/meal_draft.dart';
import 'package:assiette/features/meal_entry/presentation/meal_entry_screen.dart';
import 'package:assiette/features/notification_settings/presentation/notification_settings_screen.dart';
import 'package:assiette/features/onboarding/domain/onboarding_repository.dart';
import 'package:assiette/features/onboarding/presentation/onboarding_screen.dart';
import 'package:assiette/features/settings/presentation/settings_screen.dart';
import 'package:assiette/features/sleep_entry/presentation/sleep_entry_screen.dart';
import 'package:assiette/features/symptom_entry/domain/symptom_draft.dart';
import 'package:assiette/features/symptom_entry/presentation/symptom_entry_screen.dart';
import 'package:assiette/routing/app_startup.dart';
import 'package:assiette/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// The navigator key backing the app's [GoRouter], exposed so code with no
/// [BuildContext] (e.g. a notification tap handler) can still navigate.
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// The application router.
enum AppRouter {
  /// The startup screen.
  startup,

  /// The first-launch onboarding screens.
  onboarding,

  /// The home screen.
  home,

  /// The meal entry screen.
  mealEntry,

  /// The symptom entry screen.
  symptomEntry,

  /// The sleep entry detail screen.
  sleepEntry,

  /// The app info / about screen.
  settings,

  /// The notification settings screen.
  notificationSettings,

  /// The favorites management list.
  favoritesManage,

  /// The favorite create/edit form.
  favoriteForm,
}

/// The application router provider.
@riverpod
GoRouter goRouter(Ref ref) {
  final appStartupState = ref.watch(appStartupProvider);
  final onboardingDoneState = ref.watch(onboardingDoneProvider);

  return GoRouter(
    initialLocation: '/',
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      if (appStartupState.isLoading || appStartupState.hasError) {
        return '/${AppRouter.startup.name}';
      }
      if (onboardingDoneState.isLoading || onboardingDoneState.hasError) {
        return '/${AppRouter.startup.name}';
      }

      final onboardingDone = onboardingDoneState.requireValue;
      final isOnboardingRoute =
          state.matchedLocation == '/${AppRouter.onboarding.name}';
      if (!onboardingDone && !isOnboardingRoute) {
        return '/${AppRouter.onboarding.name}';
      }
      if (onboardingDone && isOnboardingRoute) {
        return '/';
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
        path: '/${AppRouter.onboarding.name}',
        name: AppRouter.onboarding.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: OnboardingScreen()),
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
            builder: (context, state) =>
                MealEntryScreen(draft: state.extra as MealDraft?),
          ),
          GoRoute(
            path: 'symptom-entry',
            name: AppRouter.symptomEntry.name,
            builder: (context, state) =>
                SymptomEntryScreen(draft: state.extra as SymptomDraft?),
          ),
          GoRoute(
            path: 'sleep-entry',
            name: AppRouter.sleepEntry.name,
            builder: (context, state) => const SleepEntryScreen(),
          ),
          GoRoute(
            path: 'settings',
            name: AppRouter.settings.name,
            builder: (context, state) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: 'notifications',
                name: AppRouter.notificationSettings.name,
                builder: (context, state) =>
                    const NotificationSettingsScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'favorites',
            name: AppRouter.favoritesManage.name,
            builder: (context, state) => const FavoritesManageScreen(),
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
      ),
    ],
    errorPageBuilder: (context, state) =>
        const NoTransitionPage(child: NotFoundScreen()),
  );
}
