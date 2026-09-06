import 'dart:math';

import 'package:assiette/data/daos/app_settings_dao.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/data/open_meteo_client.dart';
import 'package:assiette/features/environment_capture/domain/device_location.dart';
import 'package:assiette/features/environment_capture/domain/pressure_alert_repository.dart';
import 'package:assiette/features/notifications/data/notifications_service.dart';
import 'package:assiette/localization/app_strings.dart';

/// Drift-backed implementation of [PressureAlertRepository].
class DriftPressureAlertRepository implements PressureAlertRepository {
  /// Creates a [DriftPressureAlertRepository] backed by the given
  /// collaborators.
  DriftPressureAlertRepository({
    required AppSettingsDao appSettingsDao,
    required LocationReader locationReader,
    required OpenMeteoClient openMeteoClient,
    required NotificationsService notificationsService,
  }) : _appSettingsDao = appSettingsDao,
       _locationReader = locationReader,
       _openMeteoClient = openMeteoClient,
       _notificationsService = notificationsService;

  final AppSettingsDao _appSettingsDao;
  final LocationReader _locationReader;
  final OpenMeteoClient _openMeteoClient;
  final NotificationsService _notificationsService;

  /// Minimum predicted drop (hPa) over the next 24h to trigger an alert.
  static const _dropThresholdHpa = 6.0;

  @override
  Future<bool> checkAndNotify(
    AppStrings strings, {
    DeviceLocation? location,
  }) async {
    try {
      final weatherEnabled = await _appSettingsDao.getRemindersWeatherEnabled();
      if (!weatherEnabled) return false;

      final today = _dateOnly(DateTime.now().toUtc());
      final lastAlert = await _appSettingsDao.getLastPressureAlertDate();
      if (lastAlert != null && _dateOnly(lastAlert) == today) return false;

      final resolvedLocation = location ?? await _locationReader.readPosition();
      if (resolvedLocation == null) return false;

      final hourlyPressure = await _openMeteoClient.fetchPressureForecast(
        latitude: resolvedLocation.latitude,
        longitude: resolvedLocation.longitude,
      );
      if (hourlyPressure.length < 2) return false;

      final current = hourlyPressure.first;
      final next24h = hourlyPressure.sublist(
        1,
        min(25, hourlyPressure.length),
      );
      final minNext24h = next24h.reduce(min);
      if (current - minNext24h <= _dropThresholdHpa) return false;

      await _notificationsService.showPressureDropAlert(strings);
      await _appSettingsDao.setLastPressureAlertDate(today);
      return true;
    } on Exception {
      return false;
    }
  }

  DateTime _dateOnly(DateTime date) =>
      DateTime.utc(date.year, date.month, date.day);
}
