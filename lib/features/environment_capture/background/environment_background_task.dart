// The @pragma('vm:entry-point') callback below makes the analyzer treat
// this file as its own executable entry point, so it can't see that
// bootstrap.dart calls registerEnvironmentCaptureTask.
// ignore_for_file: unreachable_from_main
import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/environment_capture/data/environment_capture_repository.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/data/open_meteo_client.dart';
import 'package:workmanager/workmanager.dart';

/// Unique name identifying the periodic background capture in WorkManager.
const environmentCaptureUniqueName = 'environment-capture';

/// Task name passed to the background handler for the periodic capture.
const environmentCaptureTaskName = 'environment-capture-task';

/// How often the background capture runs. WorkManager enforces an Android
/// minimum of 15 minutes; this sits within the 1-3h window from the spec.
const environmentCaptureFrequency = Duration(hours: 1);

/// Entry point invoked by the OS in a separate background isolate.
///
/// This isolate shares no memory with the running app, so it must open its
/// own [AppDatabase] instance rather than reuse one built via Riverpod.
@pragma('vm:entry-point')
void environmentCaptureCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final db = AppDatabase();
    try {
      final repository = DriftEnvironmentCaptureRepository(
        environmentDao: db.environmentDao,
        locationReader: GeolocatorLocationReader(),
        openMeteoClient: OpenMeteoClient(),
      );
      await repository.captureSnapshot();
    } finally {
      await db.close();
    }
    return true;
  });
}

/// Registers the periodic background weather/pressure capture.
///
/// Safe to call on every app start: [ExistingPeriodicWorkPolicy.keep] leaves
/// an already-scheduled task untouched.
Future<void> registerEnvironmentCaptureTask() async {
  await Workmanager().initialize(environmentCaptureCallbackDispatcher);
  await Workmanager().registerPeriodicTask(
    environmentCaptureUniqueName,
    environmentCaptureTaskName,
    frequency: environmentCaptureFrequency,
    constraints: Constraints(networkType: NetworkType.connected),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
  );
}

/// Runs a one-off capture right away instead of waiting for the next
/// periodic tick (up to [environmentCaptureFrequency] away).
///
/// Call once location permission has just been granted, so the user sees a
/// weather reading without waiting up to an hour for the first one.
Future<void> registerImmediateEnvironmentCaptureTask() async {
  await Workmanager().registerOneOffTask(
    '$environmentCaptureUniqueName-immediate',
    environmentCaptureTaskName,
    constraints: Constraints(networkType: NetworkType.connected),
    existingWorkPolicy: ExistingWorkPolicy.replace,
  );
}
