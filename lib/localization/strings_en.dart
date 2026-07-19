import 'package:assiette/localization/app_strings.dart';

/// English strings.
class AppStringsEn implements AppStrings {
  @override
  String get save => 'Save';
  @override
  String get cancel => 'Cancel';
  @override
  String get confirm => 'Confirm';

  @override
  String get today => 'Today';
  @override
  String get emptyDayMessage => 'Nothing logged this day.';
  @override
  String get logMealAction => 'Meal photo';
  @override
  String get logSymptomAction => 'Symptom';
  @override
  String get sleepCardTitle => 'Sleep';
  @override
  String get sleepQualityBad => 'Bad';
  @override
  String get sleepQualityMedium => 'Okay';
  @override
  String get sleepQualityGood => 'Good';
  @override
  String get sleepQuestion => 'How did you sleep?';
  @override
  String get weatherUnavailable => 'Weather unavailable';
  @override
  String get pressureUnit => 'hPa';
  @override
  String get weatherTemperatureLabel => 'Temperature';
  @override
  String get weatherPressureLabel => 'Pressure';
  @override
  String get mealTypeBreakfast => 'Breakfast';
  @override
  String get mealTypeLunch => 'Lunch';
  @override
  String get mealTypeDinner => 'Dinner';
  @override
  String get mealTypeSnack => 'Snack';
  @override
  String get symptomTypeMigraine => 'Migraine';
  @override
  String get symptomTypeDigestive => 'Digestive';
  @override
  String get symptomTypeMood => 'Mood';
  @override
  String get symptomTypePain => 'Pain';

  @override
  String get mealEntryTitle => 'New meal';
  @override
  String get editMealTitle => 'Edit meal';
  @override
  String get takePhoto => 'Take a photo';
  @override
  String get retakePhoto => 'Retake';
  @override
  String get removePhoto => 'Remove photo';
  @override
  String get mealTypeLabel => 'Meal type';
  @override
  String get tagsLabel => 'Tags';
  @override
  String get tagSearchHint => 'Search or create a tag';
  @override
  String createTagLabel(String label) => 'Create "$label"';
  @override
  String get suggestedTagsLabel => 'Suggestions';
  @override
  String get noteHint => 'Note (optional)';
  @override
  String get saveAsFavorite => 'Save as favorite';
  @override
  String get favoriteNameTitle => 'Favorite name';
  @override
  String get favoriteNameHint => 'E.g. Caesar salad';
  @override
  String get favoriteSaved => 'Favorite saved';
  @override
  String get mealSaved => 'Meal saved';
  @override
  String get errorGeneric => 'Something went wrong';
  @override
  String get entryDeleted => 'Entry deleted';

  @override
  String get favoriteMealAdded => 'Meal added';
  @override
  String get undoAction => 'Undo';
  @override
  String get favoritesManageTitle => 'My favorites';
  @override
  String get manageFavoritesAction => 'Manage my favorites';
  @override
  String get noFavoritesMessage => 'No favorites yet.';
  @override
  String get newFavoriteTitle => 'New favorite';
  @override
  String get editFavoriteTitle => 'Edit favorite';
  @override
  String get favoriteUpdated => 'Favorite updated';
  @override
  String get deleteAction => 'Delete';
  @override
  String get deleteFavoriteConfirmTitle => 'Delete this favorite?';
  @override
  String get deleteFavoriteConfirmMessage => 'This action cannot be undone.';
  @override
  String get favoriteDeleted => 'Favorite deleted';

  @override
  String get symptomEntryTitle => 'New symptom';
  @override
  String get editSymptomTitle => 'Edit symptom';
  @override
  String get symptomEntryTypeLabel => 'Symptom type';
  @override
  String get intensityLabel => 'Intensity';
  @override
  String get detailLabel => 'Detail (optional)';
  @override
  String get endTimeLabel => 'Add an end time';
  @override
  String get removeEndTime => 'Remove end time';
  @override
  String get symptomSaved => 'Symptom saved';
  @override
  String get symptomDetailBloating => 'Bloating';
  @override
  String get symptomDetailPain => 'Pain';
  @override
  String get symptomDetailNausea => 'Nausea';
  @override
  String get symptomDetailIrritable => 'Irritable';
  @override
  String get symptomDetailAnxious => 'Anxious';
  @override
  String get symptomDetailLow => 'Low';
  @override
  String get symptomDetailBack => 'Back';
  @override
  String get symptomDetailJoint => 'Joint';
  @override
  String get symptomDetailMuscle => 'Muscle';

  @override
  String get sleepQualityLabel => 'Quality';
  @override
  String get bedTimeLabel => 'Bed time';
  @override
  String get wakeTimeLabel => 'Wake time';
  @override
  String get removeBedTime => 'Remove bed time';
  @override
  String get removeWakeTime => 'Remove wake time';
  @override
  String get sleepSaved => 'Sleep saved';

  @override
  String get settingsTitle => 'About';
  @override
  String get aboutSectionTitle => 'Data sources';
  @override
  String get openMeteoAttribution =>
      'Weather and pressure data provided by Open-Meteo.com (CC BY 4.0).';
  @override
  String get manageNotificationsAction => 'Notification settings';
  @override
  String get photoTagSuggestionsSettingTitle => 'Suggest tags from photo';
  @override
  String get photoTagSuggestionsSettingSubtitle =>
      'Analyzes the photo on-device to suggest tags to confirm. Never sent '
      'anywhere, never applied automatically.';

  @override
  String get notificationChannelMealsName => 'Meals';
  @override
  String get notificationChannelMealsDescription =>
      'Reminders to log a meal';
  @override
  String get notificationChannelSleepName => 'Sleep';
  @override
  String get notificationChannelSleepDescription =>
      'Morning reminder to log your sleep';
  @override
  String get notificationChannelWeatherName => 'Weather';
  @override
  String get notificationChannelWeatherDescription =>
      'Alerts related to weather and pressure';
  @override
  String get notificationChannelSymptomsName => 'Symptom check-in';
  @override
  String get notificationChannelSymptomsDescription =>
      'Reminder to log your symptoms';
  @override
  String get mealReminderTitle => 'Did you eat?';
  @override
  String get mealReminderPhotoAction => 'Photo';
  @override
  String get mealReminderFavoriteAction => 'Favorite';
  @override
  String get pressureDropAlertTitle => 'Pressure drop expected';
  @override
  String get pressureDropAlertBody =>
      'A pressure drop is expected in the next 24h — a common trigger '
      'for some people.';
  @override
  String get symptomsReminderTitle => 'How are you feeling?';

  @override
  String get notificationSettingsTitle => 'Notification settings';
  @override
  String get notificationSettingsSaved => 'Preferences saved';

  @override
  String get exportPdfAction => 'Export journal as PDF';
  @override
  String get pdfExportScreenTitle => 'Export PDF';
  @override
  String get pdfExportRangeLabel => 'Date range';
  @override
  String get pdfExportChooseRange => 'Choose a date range';
  @override
  String get pdfExportGenerate => 'Generate PDF';
  @override
  String get pdfExportShare => 'Share';
  @override
  String get pdfExportEmptyRange => 'No data in this range';
  @override
  String get pdfDocTitle => 'Journal - Assiette';
  @override
  String get pdfSectionMeals => 'Meals';
  @override
  String get pdfSectionSymptoms => 'Symptoms';
  @override
  String get pdfSectionWeather => 'Pressure';

  @override
  String get onboardingSkip => 'Skip';
  @override
  String get onboardingNext => 'Next';
  @override
  String get onboardingValueTitle => 'Food, symptoms, environment';
  @override
  String get onboardingValueBody =>
      'Assiette helps you connect what you eat, how you feel, and the '
      'weather.';
  @override
  String get onboardingLoggingTitle => 'A photo, a few tags';
  @override
  String get onboardingLoggingBody =>
      'Snap a photo of your meal and add tags in seconds.';
  @override
  String get onboardingWeatherTitle => 'Automatic weather and pressure';
  @override
  String get onboardingWeatherBody =>
      'Weather and atmospheric pressure are logged for you, in the '
      'background.';
  @override
  String get onboardingPermissionTitle => 'Allow location';
  @override
  String get onboardingPermissionBody =>
      'Atmospheric pressure can be linked to migraines. Allow location so '
      'we can track it automatically near you.';
  @override
  String get onboardingEnableLocation => 'Allow location';
  @override
  String get onboardingMaybeLater => 'Maybe later';
}
