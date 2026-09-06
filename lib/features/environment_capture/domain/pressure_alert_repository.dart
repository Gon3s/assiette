import 'package:assiette/data/db/database_provider.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/data/open_meteo_client.dart';
import 'package:assiette/features/environment_capture/data/pressure_alert_repository.dart';
import 'package:assiette/features/environment_capture/domain/device_location.dart';
import 'package:assiette/features/notifications/data/notifications_service.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pressure_alert_repository.g.dart';

/// Detects an upcoming significant pressure drop from the Open-Meteo
/// forecast and sends at most one proactive alert per day (US-15).
///
/// Repository contracts in this codebase are always abstract classes, even
/// with a single method, to keep dependency injection and testing consistent
/// with the rest of the domain layer.
// ignore: one_member_abstracts
abstract class PressureAlertRepository {
  /// Checks the forecast and, if a significant drop is predicted and no
  /// alert has been sent today, shows a notification and records today as
  /// the last alert date.
  ///
  /// Returns `true` if an alert was sent. Never throws.
  Future<bool> checkAndNotify(
    AppStrings strings, {
    DeviceLocation? location,
  });
}

/// Provides the [PressureAlertRepository] implementation.
@riverpod
PressureAlertRepository pressureAlertRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftPressureAlertRepository(
    appSettingsDao: db.appSettingsDao,
    locationReader: GeolocatorLocationReader(),
    openMeteoClient: OpenMeteoClient(),
    notificationsService: LocalNotificationsService(),
  );
}
