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
  String get addHealthAction => 'Add';
  @override
  String get dailyFeelingsCardTitle => "Today's feelings";
  @override
  String get activeMigraineTitle => 'Active migraine';
  @override
  String migraineDuration(String duration) => 'For $duration';
  @override
  String get updateIntensityAction => 'Update intensity';
  @override
  String get endMigraineAction => 'End';
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
  String get weatherHumidityLabel => 'Humidity';
  @override
  String get weatherUvLabel => 'UV';
  @override
  String get weatherPollenLabel => 'Pollen';
  @override
  String get weatherAirLabel => 'Air (PM2.5)';
  @override
  String get airQualityUnit => 'µg/m³';
  @override
  String get pollenLevelLow => 'Low';
  @override
  String get pollenLevelModerate => 'Moderate';
  @override
  String get pollenLevelHigh => 'High';
  @override
  String get weatherUpdatedJustNow => 'Updated just now';
  @override
  String weatherUpdatedMinutesAgo(int minutes) => 'Updated $minutes min ago';
  @override
  String weatherUpdatedHoursAgo(int hours) => 'Updated ${hours}h ago';
  @override
  String get weatherChartNoData => 'Not enough readings for today yet';
  @override
  String get weatherChartMeasuredLegend => 'Measured';
  @override
  String get weatherChartForecastLegend => 'Forecast';
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
  String get symptomTypeEczema => 'Eczema';

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
  String get migraineEntryTitle => 'New migraine';
  @override
  String get dailyFeelingTitle => 'Feeling';
  @override
  String get dailyMoodTitle => 'Mood of the day';
  @override
  String get feelingCategoryLabel => 'Category';
  @override
  String get dailyNoteHint => 'What are you feeling?';
  @override
  String get migraineStartLabel => 'Start';
  @override
  String get migraineStartExact => 'Exact';
  @override
  String get migraineStartApproximate => 'Approximate';
  @override
  String get migraineStartUnknown => 'Unknown';
  @override
  String get activeMigraineExistsTitle => 'A migraine is already active';
  @override
  String get activeMigraineExistsBody => 'End the previous migraine now?';
  @override
  String previousIntensity(int intensity) =>
      'Previously recorded intensity: $intensity/10';

  @override
  String get medicationSectionTitle => 'Medications';
  @override
  String get addMedicationAction => 'Add an intake';
  @override
  String get medicationNameLabel => 'Medication';
  @override
  String get medicationDoseLabel => 'Dose (optional)';
  @override
  String get medicationIntakeTimeLabel => 'Intake time';
  @override
  String get removeMedicationIntake => 'Remove intake';
  @override
  String get pdfSectionMedications => 'Medications';
  @override
  String get medicationEntryTitle => 'Medication';
  @override
  String get newMedicationAction => 'New medication';
  @override
  String get recentMedicationsTitle => 'Recent medications';
  @override
  String get medicationSaved => 'Intake saved';
  @override
  String get linkToActiveMigraine => 'Link to active migraine';

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
  String get notificationChannelMealsDescription => 'Reminders to log a meal';
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
  String get notificationChannelSymptomsName => 'Mood of the day';
  @override
  String get notificationChannelSymptomsDescription =>
      'Reminder to log your mood of the day';
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
  String get symptomsReminderTitle => "What's your mood today?";

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
  String get cloudBackupAction => 'Cloud backup';
  @override
  String get cloudBackupScreenTitle => 'Cloud backup';
  @override
  String get cloudBackupSignInAction => 'Sign in with Google';
  @override
  String get cloudBackupSignOutAction => 'Sign out';
  @override
  String cloudBackupSignedInAs(String email) => 'Signed in as $email';
  @override
  String get cloudBackupNotSignedIn => 'No account connected';
  @override
  String get cloudBackupNowAction => 'Back up now';
  @override
  String get cloudBackupInProgress => 'Backing up…';
  @override
  String get cloudBackupLastBackupLabel => 'Last backup';
  @override
  String get cloudBackupNeverBackedUp => 'Never backed up';
  @override
  String get cloudBackupSuccess => 'Backup complete';
  @override
  String get cloudBackupFailure =>
      'Backup failed. Check your connection and try again.';
  @override
  String get cloudRestoreAction => 'Restore my backup';
  @override
  String get cloudRestoreInProgress => 'Restoring…';
  @override
  String get cloudRestoreSuccess => 'Restore complete';
  @override
  String get cloudRestoreFailure =>
      'Restore failed. Check your connection and try again.';
  @override
  String get cloudRestoreConfirmTitle => 'Restore backup?';
  @override
  String get cloudRestoreConfirmBody =>
      'All current local data will be replaced by the latest backup. '
      'This cannot be undone.';
  @override
  String get cloudRestoreNoBackupFound => 'No backup found for this account';
  @override
  String get cloudRestorePromptTitle => 'Backup found';
  @override
  String get cloudRestorePromptBody =>
      'A backup exists for this Google account. Restore it now?';
  @override
  String get cloudRestorePromptLater => 'Later';

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
