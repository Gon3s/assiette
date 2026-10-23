import 'package:assiette/features/notifications/data/notifications_service.dart';
import 'package:assiette/features/notifications/domain/notification_preferences.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class _MockPlugin extends Mock implements FlutterLocalNotificationsPlugin {}

void main() {
  setUpAll(() {
    tz_data.initializeTimeZones();
    registerFallbackValue(tz.TZDateTime.now(tz.UTC));
    registerFallbackValue(const NotificationDetails());
    registerFallbackValue(AndroidScheduleMode.inexactAllowWhileIdle);
  });

  test('all five daily reminders use inexact scheduling', () async {
    final plugin = _MockPlugin();
    when(
      () => plugin.zonedSchedule(
        id: any(named: 'id'),
        title: any(named: 'title'),
        scheduledDate: any(named: 'scheduledDate'),
        notificationDetails: any(named: 'notificationDetails'),
        androidScheduleMode: any(named: 'androidScheduleMode'),
        matchDateTimeComponents: DateTimeComponents.time,
      ),
    ).thenAnswer((_) async {});
    final service = LocalNotificationsService(plugin: plugin);
    await service.scheduleDailyReminders(
      AppStrings.ofLocale(const Locale('en')),
      NotificationPreferences.defaults().copyWith(symptomsEnabled: true),
    );
    final modes = verify(
      () => plugin.zonedSchedule(
        id: any(named: 'id'),
        title: any(named: 'title'),
        scheduledDate: any(named: 'scheduledDate'),
        notificationDetails: any(named: 'notificationDetails'),
        androidScheduleMode: captureAny(named: 'androidScheduleMode'),
        matchDateTimeComponents: DateTimeComponents.time,
      ),
    ).captured;
    expect(modes, hasLength(5));
    expect(modes, everyElement(AndroidScheduleMode.inexactAllowWhileIdle));
  });
}
