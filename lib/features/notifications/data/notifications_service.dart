import 'dart:io';

import 'package:assiette/features/notifications/background/notification_action_dispatcher.dart';
import 'package:assiette/features/notifications/domain/notification_channel.dart';
import 'package:assiette/features/notifications/domain/notification_ids.dart';
import 'package:assiette/features/notifications/domain/notification_preferences.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

part 'notifications_service.g.dart';

/// Local reminder notifications: channel setup, daily scheduling, and the
/// POST_NOTIFICATIONS permission request.
///
/// Kept as an interface, not top-level functions, so tests can inject a
/// fake without touching the real plugin (mirrors `LocationReader`).
abstract class NotificationsService {
  /// Initializes the plugin, wires the foreground/background response
  /// handlers, and creates the reminder channels.
  Future<void> init({
    required AppStrings strings,
    DidReceiveNotificationResponseCallback? onForegroundResponse,
  });

  /// (Re)schedules the daily reminders per [preferences]: enabled channels
  /// are scheduled at their configured times, disabled ones are cancelled.
  /// [strings] provides the localized titles/action labels.
  Future<void> scheduleDailyReminders(
    AppStrings strings,
    NotificationPreferences preferences,
  );

  /// Requests the POST_NOTIFICATIONS permission (Android 13+). A no-op on
  /// older versions, and idempotent once granted or permanently denied.
  Future<void> requestPermission();

  /// Shows an immediate (non-scheduled) proactive pressure-drop alert on
  /// the weather channel.
  Future<void> showPressureDropAlert(AppStrings strings);
}

/// [NotificationsService] backed by `flutter_local_notifications`.
class LocalNotificationsService implements NotificationsService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> init({
    required AppStrings strings,
    DidReceiveNotificationResponseCallback? onForegroundResponse,
  }) async {
    tz_data.initializeTimeZones();
    final timezoneName = await FlutterTimezone.getLocalTimezone();
    try {
      tz.setLocalLocation(tz.getLocation(timezoneName));
    } on tz.LocationNotFoundException {
      // Some devices report a timezone id (e.g. "GMT") that isn't a
      // canonical IANA location in the tzdata this package ships.
      tz.setLocalLocation(tz.UTC);
    }

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: onForegroundResponse,
      onDidReceiveBackgroundNotificationResponse:
          notificationBackgroundDispatcher,
    );

    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android == null) return;
    for (final channel in NotificationChannel.values) {
      await android.createNotificationChannel(
        AndroidNotificationChannel(
          channel.id,
          channel.channelName(strings),
          description: channel.channelDescription(strings),
        ),
      );
    }
  }

  @override
  Future<void> scheduleDailyReminders(
    AppStrings strings,
    NotificationPreferences preferences,
  ) async {
    if (preferences.sleepEnabled) {
      await _scheduleSleepReminder(
        strings,
        hour: preferences.sleepHour,
        minute: preferences.sleepMinute,
      );
    } else {
      await _plugin.cancel(id: NotificationIds.sleepReminder);
    }

    if (preferences.mealsEnabled) {
      await _scheduleMealReminder(
        id: NotificationIds.breakfastReminder,
        hour: preferences.breakfastHour,
        minute: preferences.breakfastMinute,
        strings: strings,
      );
      await _scheduleMealReminder(
        id: NotificationIds.lunchReminder,
        hour: preferences.lunchHour,
        minute: preferences.lunchMinute,
        strings: strings,
      );
      await _scheduleMealReminder(
        id: NotificationIds.dinnerReminder,
        hour: preferences.dinnerHour,
        minute: preferences.dinnerMinute,
        strings: strings,
      );
    } else {
      await _plugin.cancel(id: NotificationIds.breakfastReminder);
      await _plugin.cancel(id: NotificationIds.lunchReminder);
      await _plugin.cancel(id: NotificationIds.dinnerReminder);
    }

    if (preferences.symptomsEnabled) {
      await _scheduleSymptomsReminder(
        strings,
        hour: preferences.symptomsHour,
        minute: preferences.symptomsMinute,
      );
    } else {
      await _plugin.cancel(id: NotificationIds.symptomsReminder);
    }
  }

  Future<void> _scheduleSleepReminder(
    AppStrings strings, {
    required int hour,
    required int minute,
  }) => _plugin.zonedSchedule(
    id: NotificationIds.sleepReminder,
    title: strings.sleepQuestion,
    scheduledDate: _nextInstanceOf(hour: hour, minute: minute),
    notificationDetails: NotificationDetails(
      android: AndroidNotificationDetails(
        NotificationChannel.sleep.id,
        NotificationChannel.sleep.channelName(strings),
        channelDescription: NotificationChannel.sleep.channelDescription(
          strings,
        ),
        actions: [
          AndroidNotificationAction(
            NotificationActionIds.sleepBad,
            strings.sleepQualityBad,
          ),
          AndroidNotificationAction(
            NotificationActionIds.sleepMedium,
            strings.sleepQualityMedium,
          ),
          AndroidNotificationAction(
            NotificationActionIds.sleepGood,
            strings.sleepQualityGood,
          ),
        ],
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  Future<void> _scheduleMealReminder({
    required int id,
    required int hour,
    required int minute,
    required AppStrings strings,
  }) => _plugin.zonedSchedule(
    id: id,
    title: strings.mealReminderTitle,
    scheduledDate: _nextInstanceOf(hour: hour, minute: minute),
    notificationDetails: NotificationDetails(
      android: AndroidNotificationDetails(
        NotificationChannel.meals.id,
        NotificationChannel.meals.channelName(strings),
        channelDescription: NotificationChannel.meals.channelDescription(
          strings,
        ),
        actions: [
          // showsUserInterface: true opens the app on tap - handled by the
          // onForegroundResponse callback, not the background dispatcher.
          AndroidNotificationAction(
            NotificationActionIds.mealPhoto,
            strings.mealReminderPhotoAction,
            showsUserInterface: true,
          ),
          AndroidNotificationAction(
            NotificationActionIds.mealFavorite,
            strings.mealReminderFavoriteAction,
          ),
        ],
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  Future<void> _scheduleSymptomsReminder(
    AppStrings strings, {
    required int hour,
    required int minute,
  }) => _plugin.zonedSchedule(
    id: NotificationIds.symptomsReminder,
    title: strings.symptomsReminderTitle,
    scheduledDate: _nextInstanceOf(hour: hour, minute: minute),
    notificationDetails: NotificationDetails(
      android: AndroidNotificationDetails(
        NotificationChannel.symptoms.id,
        NotificationChannel.symptoms.channelName(strings),
        channelDescription: NotificationChannel.symptoms.channelDescription(
          strings,
        ),
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  tz.TZDateTime _nextInstanceOf({required int hour, required int minute}) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  @override
  Future<void> requestPermission() async {
    // assiette targets Android; also guards test runs, where no platform
    // channel is registered and resolving an implementation would throw.
    if (!Platform.isAndroid) return;
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.requestNotificationsPermission();
  }

  @override
  Future<void> showPressureDropAlert(AppStrings strings) => _plugin.show(
    id: NotificationIds.pressureDropAlert,
    title: strings.pressureDropAlertTitle,
    body: strings.pressureDropAlertBody,
    notificationDetails: NotificationDetails(
      android: AndroidNotificationDetails(
        NotificationChannel.weather.id,
        NotificationChannel.weather.channelName(strings),
        channelDescription: NotificationChannel.weather.channelDescription(
          strings,
        ),
      ),
    ),
  );
}

/// Provides the [NotificationsService] implementation. Overridden with a
/// fake in tests that exercise callers of this provider (e.g. the
/// notification settings controller), since the real one needs a platform
/// channel that isn't registered in unit tests.
@riverpod
NotificationsService notificationsService(Ref ref) =>
    LocalNotificationsService();
