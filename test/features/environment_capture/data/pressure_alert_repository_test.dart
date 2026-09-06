import 'dart:convert';

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/environment_capture/data/location_reader.dart';
import 'package:assiette/features/environment_capture/data/open_meteo_client.dart';
import 'package:assiette/features/environment_capture/data/pressure_alert_repository.dart';
import 'package:assiette/features/environment_capture/domain/device_location.dart';
import 'package:assiette/features/notifications/data/notifications_service.dart';
import 'package:assiette/features/notifications/domain/notification_preferences.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

class _FakeLocationReader implements LocationReader {
  _FakeLocationReader(this._position);

  final DeviceLocation? _position;

  @override
  Future<bool> ensurePermission() async => _position != null;

  @override
  Future<DeviceLocation?> readPosition() async => _position;
}

class _FakeNotificationsService implements NotificationsService {
  int showPressureDropAlertCalls = 0;

  @override
  Future<void> init({
    required AppStrings strings,
    DidReceiveNotificationResponseCallback? onForegroundResponse,
  }) async {}

  @override
  Future<void> scheduleDailyReminders(
    AppStrings strings,
    NotificationPreferences preferences,
  ) async {}

  @override
  Future<void> requestPermission() async {}

  @override
  Future<void> showPressureDropAlert(AppStrings strings) async {
    showPressureDropAlertCalls++;
  }
}

DeviceLocation _position({double lat = 45.75, double lon = 4.85}) =>
    DeviceLocation(
      latitude: lat,
      longitude: lon,
      timestamp: DateTime.utc(2026, 7, 6),
    );

OpenMeteoClient _openMeteoClientReturning(List<double?> hourlyPressure) =>
    OpenMeteoClient(
      httpClient: MockClient(
        (request) async => http.Response(
          jsonEncode({
            'hourly': {'pressure_msl': hourlyPressure},
          }),
          200,
        ),
      ),
    );

void main() {
  late AppDatabase db;
  final strings = AppStrings.ofLocale(const Locale('en'));

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  group('DriftPressureAlertRepository', () {
    test('returns false when no location is available', () async {
      final notifications = _FakeNotificationsService();
      final repository = DriftPressureAlertRepository(
        appSettingsDao: db.appSettingsDao,
        locationReader: _FakeLocationReader(null),
        openMeteoClient: _openMeteoClientReturning(
          List.filled(25, 1013),
        ),
        notificationsService: notifications,
      );

      final sent = await repository.checkAndNotify(strings);

      expect(sent, isFalse);
      expect(notifications.showPressureDropAlertCalls, 0);
    });

    test('returns false when the predicted drop is below threshold', () async {
      final notifications = _FakeNotificationsService();
      final repository = DriftPressureAlertRepository(
        appSettingsDao: db.appSettingsDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: _openMeteoClientReturning([
          1013,
          for (var i = 0; i < 24; i++) 1010,
        ]),
        notificationsService: notifications,
      );

      final sent = await repository.checkAndNotify(strings);

      expect(sent, isFalse);
      expect(notifications.showPressureDropAlertCalls, 0);
      expect(await db.appSettingsDao.getLastPressureAlertDate(), isNull);
    });

    test('sends an alert and records the date when a significant drop is '
        'predicted', () async {
      final notifications = _FakeNotificationsService();
      final repository = DriftPressureAlertRepository(
        appSettingsDao: db.appSettingsDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: _openMeteoClientReturning([
          1013,
          for (var i = 0; i < 24; i++) 1005,
        ]),
        notificationsService: notifications,
      );

      final sent = await repository.checkAndNotify(strings);

      expect(sent, isTrue);
      expect(notifications.showPressureDropAlertCalls, 1);
      expect(await db.appSettingsDao.getLastPressureAlertDate(), isNotNull);
    });

    test('returns false when weather reminders are disabled', () async {
      await db.appSettingsDao.saveNotificationPreferences(
        mealsEnabled: true,
        breakfastHour: 8,
        breakfastMinute: 30,
        lunchHour: 12,
        lunchMinute: 30,
        dinnerHour: 19,
        dinnerMinute: 30,
        sleepEnabled: true,
        sleepHour: 8,
        sleepMinute: 0,
        weatherEnabled: false,
        symptomsEnabled: false,
        symptomsHour: 20,
        symptomsMinute: 0,
      );
      final notifications = _FakeNotificationsService();
      final repository = DriftPressureAlertRepository(
        appSettingsDao: db.appSettingsDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: _openMeteoClientReturning([
          1013,
          for (var i = 0; i < 24; i++) 1005,
        ]),
        notificationsService: notifications,
      );

      final sent = await repository.checkAndNotify(strings);

      expect(sent, isFalse);
      expect(notifications.showPressureDropAlertCalls, 0);
    });

    test('does not send a second alert the same day', () async {
      final notifications = _FakeNotificationsService();
      final repository = DriftPressureAlertRepository(
        appSettingsDao: db.appSettingsDao,
        locationReader: _FakeLocationReader(_position()),
        openMeteoClient: _openMeteoClientReturning([
          1013,
          for (var i = 0; i < 24; i++) 1005,
        ]),
        notificationsService: notifications,
      );
      await repository.checkAndNotify(strings);

      final sent = await repository.checkAndNotify(strings);

      expect(sent, isFalse);
      expect(notifications.showPressureDropAlertCalls, 1);
    });
  });
}
