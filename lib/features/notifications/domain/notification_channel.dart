import 'package:assiette/localization/app_strings.dart';

/// The Android notification channels used by assiette's local reminders,
/// one per family so the user can mute/configure them independently.
enum NotificationChannel {
  /// Meal logging reminders.
  meals('reminders_meals'),

  /// Sleep check-in reminder.
  sleep('reminders_sleep'),

  /// Weather/pressure alerts (US-15).
  weather('reminders_weather'),

  /// Symptom check-in reminder (US-16). Off by default.
  symptoms('reminders_symptoms');

  const NotificationChannel(this.id);

  /// Stable Android channel id. Never rename once shipped: Android treats a
  /// renamed id as a brand-new channel and orphans the old one.
  final String id;

  /// The channel's user-visible name, localized.
  String channelName(AppStrings s) => switch (this) {
    NotificationChannel.meals => s.notificationChannelMealsName,
    NotificationChannel.sleep => s.notificationChannelSleepName,
    NotificationChannel.weather => s.notificationChannelWeatherName,
    NotificationChannel.symptoms => s.notificationChannelSymptomsName,
  };

  /// The channel's user-visible description, localized.
  String channelDescription(AppStrings s) => switch (this) {
    NotificationChannel.meals => s.notificationChannelMealsDescription,
    NotificationChannel.sleep => s.notificationChannelSleepDescription,
    NotificationChannel.weather => s.notificationChannelWeatherDescription,
    NotificationChannel.symptoms => s.notificationChannelSymptomsDescription,
  };
}
