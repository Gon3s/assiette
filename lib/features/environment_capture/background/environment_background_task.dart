// The @pragma('vm:entry-point') callback below makes the analyzer treat
// this file as its own executable entry point, so it can't see that
// bootstrap.dart calls registerEnvironmentCaptureTask.
// ignore_for_file: unreachable_from_main
import 'dart:ui';

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/environment_capture/data/environment_capture_repository.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/data/open_meteo_client.dart';
import 'package:assiette/features/environment_capture/data/pressure_alert_repository.dart';
import 'package:assiette/features/environment_capture/domain/environment_capture_policy.dart';
import 'package:assiette/features/notifications/data/notifications_service.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:workmanager/workmanager.dart';

/// Unique name identifying the periodic background capture in WorkManager.
const environmentCaptureUniqueName = 'environment-capture';

/// Task name passed to the background handler for the periodic capture.
const environmentCaptureTaskName = 'environment-capture-task';

/// Entry point invoked by the OS in a separate background isolate.
///
/// This isolate shares no memory with the running app, so it must open its
/// own [AppDatabase] instance rather than reuse one built via Riverpod.
@pragma('vm:entry-point')
void environmentCaptureCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final db = AppDatabase();
    try {
      final locationReader = GeolocatorLocationReader();
      final openMeteoClient = OpenMeteoClient();
      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: locationReader,
        openMeteoClient: openMeteoClient,
      );
      final location = await locationReader.readPosition();
      if (location != null) {
        await repository.captureSnapshot(location: location);

        final strings = AppStrings.ofLocale(
          PlatformDispatcher.instance.locale,
        );
        final notificationsService = LocalNotificationsService();
        await notificationsService.init(strings: strings);
        final pressureAlertRepository = DriftPressureAlertRepository(
          appSettingsDao: db.appSettingsDao,
          locationReader: locationReader,
          openMeteoClient: openMeteoClient,
          notificationsService: notificationsService,
        );
        await pressureAlertRepository.checkAndNotify(
          strings,
          location: location,
        );
      }
    } finally {
      await db.close();
    }
    return true;
  });
}

/// Registers the periodic background weather/pressure capture.
///
/// Safe to call on every app start: [ExistingPeriodicWorkPolicy.update]
/// migrates existing installations from earlier frequencies and constraints.
Future<void> registerEnvironmentCaptureTask() async {
  await Workmanager().initialize(environmentCaptureCallbackDispatcher);
  await Workmanager().registerPeriodicTask(
    environmentCaptureUniqueName,
    environmentCaptureTaskName,
    frequency: environmentCaptureInterval,
    constraints: Constraints(
      networkType: NetworkType.connected,
      requiresBatteryNotLow: true,
    ),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
  );
}

/// Runs a one-off capture right away instead of waiting for the next
/// periodic tick (up to [environmentCaptureInterval] away).
///
/// Call once location permission has just been granted, so the user sees a
/// weather reading without waiting up to three hours for the first one.
Future<void> registerImmediateEnvironmentCaptureTask() async {
  await Workmanager().registerOneOffTask(
    '$environmentCaptureUniqueName-immediate',
    environmentCaptureTaskName,
    constraints: Constraints(
      networkType: NetworkType.connected,
      requiresBatteryNotLow: true,
    ),
    existingWorkPolicy: ExistingWorkPolicy.replace,
  );
}
