import 'dart:async';
import 'dart:io';

import 'package:assiette/constants/app_theme.dart';
import 'package:assiette/features/environment_capture/background/environment_background_task.dart';
import 'package:assiette/features/environment_capture/domain/environment_capture_repository.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The main application widget.
class MyApp extends ConsumerStatefulWidget {
  /// Creates a new instance of the [MyApp] widget.
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  bool _capturingEnvironment = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _captureEnvironment());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _captureEnvironment();
  }

  void _captureEnvironment() {
    if (!mounted ||
        !Platform.isAndroid ||
        _capturingEnvironment ||
        WidgetsBinding.instance.lifecycleState != AppLifecycleState.resumed) {
      return;
    }
    _capturingEnvironment = true;
    final repository = ref.read(environmentCaptureRepositoryProvider);
    unawaited(() async {
      try {
        final result = await repository.captureSnapshot();
        if (result != EnvironmentCaptureResult.failed) {
          await registerImmediateEnvironmentCaptureTask();
          await repository.backfillMissingDays();
        }
      } on Exception {
        // Weather must never block the app or request permission implicitly.
      } finally {
        _capturingEnvironment = false;
      }
    }());
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fr'), Locale('en')],
      theme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}
