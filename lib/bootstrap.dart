import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:assiette/app.dart';
import 'package:assiette/app_env.dart';
import 'package:assiette/constants/app_colors.dart';
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/environment_capture/background/environment_background_task.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/notifications/data/notification_preferences_repository.dart';
import 'package:assiette/features/notifications/data/notifications_service.dart';
import 'package:assiette/features/notifications/presentation/notification_response_handler.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/localization/string_hardcoded.dart';
import 'package:assiette/utils/colored_debug_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
Future<void> bootstrap(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();

  EnvInfo.environment = environment;
  EnvInfo.describe();

  _registerErrorHandlers();
  _setupSystemUIOverlayStyle();
  await _registerBackgroundTasks();
  await _registerNotifications();

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _registerBackgroundTasks() async {
  // assiette targets Android; iOS Info.plist location keys aren't
  // configured yet, so skip registration there.
  if (!Platform.isAndroid) return;
  try {
    await registerEnvironmentCaptureTask();

    // Requested here, in the foreground, because the periodic task above
    // runs headless and can't show the system permission dialog.
    final hasPermission = await GeolocatorLocationReader().ensurePermission();
    if (hasPermission) {
      await registerImmediateEnvironmentCaptureTask();
    }
  } on Exception catch (e) {
    Print.red('DLOG', 'Failed to register background tasks: $e');
  }
}

Future<void> _registerNotifications() async {
  // assiette targets Android; iOS notification setup isn't configured yet,
  // so skip registration there.
  if (!Platform.isAndroid) return;
  try {
    final strings = AppStrings.ofLocale(PlatformDispatcher.instance.locale);
    final service = LocalNotificationsService();
    await service.init(
      strings: strings,
      onForegroundResponse: handleForegroundNotificationResponse,
    );

    // A throwaway connection: at this point in startup the Riverpod
    // ProviderScope isn't up yet, so this can't reuse appDatabaseProvider's
    // instance (mirrors the pattern in environment_background_task.dart).
    final db = AppDatabase();
    try {
      final preferences = await DriftNotificationPreferencesRepository(
        appSettingsDao: db.appSettingsDao,
      ).watchPreferences().first;
      await service.scheduleDailyReminders(strings, preferences);
    } finally {
      await db.close();
    }
  } on Exception catch (e) {
    Print.red('DLOG', 'Failed to register notifications: $e');
  }
}

void _registerErrorHandlers() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    Print.red('DLOG', details.toString());
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    Print.red('DLOG', error.toString());
    return true;
  };
  ErrorWidget.builder = (details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.alert,
        title: Text('An error occurred'.hardcoded),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}

void _setupSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
    ),
  );
}
