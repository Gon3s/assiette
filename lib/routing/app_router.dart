import 'package:assiette/features/home/presentation/home_screen.dart';
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
            const NoTransitionPage(child: HomeScreen()),
      ),
    ],
    errorPageBuilder: (context, state) =>
        const NoTransitionPage(child: NotFoundScreen()),
  );
}
