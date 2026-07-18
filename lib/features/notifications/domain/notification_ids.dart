/// Action ids attached to notification action buttons, read back in the
/// foreground/background response handlers to decide what to do.
abstract final class NotificationActionIds {
  /// "Mauvais" action on the sleep check-in reminder.
  static const sleepBad = 'sleep_bad';

  /// "Moyen" action on the sleep check-in reminder.
  static const sleepMedium = 'sleep_medium';

  /// "Bon" action on the sleep check-in reminder.
  static const sleepGood = 'sleep_good';

  /// "Photo" action on a meal reminder: opens the app on the entry form.
  static const mealPhoto = 'meal_photo';

  /// "Favori" action on a meal reminder: logs the default favorite in the
  /// background, no UI shown.
  static const mealFavorite = 'meal_favorite';
}

/// Notification ids, one per scheduled reminder. Kept stable so scheduling
/// the same reminder again replaces it instead of stacking duplicates.
abstract final class NotificationIds {
  /// The daily sleep check-in reminder.
  static const sleepReminder = 1;

  /// The breakfast reminder.
  static const breakfastReminder = 2;

  /// The lunch reminder.
  static const lunchReminder = 3;

  /// The dinner reminder.
  static const dinnerReminder = 4;

  /// The proactive pressure-drop alert (US-15).
  static const pressureDropAlert = 5;

  /// The daily symptom check-in reminder (US-16, off by default).
  static const symptomsReminder = 6;
}
