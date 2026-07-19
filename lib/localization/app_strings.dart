import 'package:assiette/localization/strings_en.dart';
import 'package:assiette/localization/strings_fr.dart';
import 'package:flutter/widgets.dart';

/// Abstract base class for all app strings.
abstract class AppStrings {
  /// Returns the [AppStrings] implementation for the current locale.
  /// Falls back to English if no localization ancestor is found.
  static AppStrings of(BuildContext context) {
    return ofLocale(Localizations.maybeLocaleOf(context));
  }

  /// Returns the [AppStrings] implementation for [locale], for call sites
  /// with no [BuildContext] (background isolates, bootstrap). Falls back to
  /// English.
  static AppStrings ofLocale(Locale? locale) {
    if (locale?.languageCode == 'fr') return AppStringsFr();
    return AppStringsEn();
  }

  // Common
  String get save;
  String get cancel;
  String get confirm;

  // Day view
  String get today;
  String get emptyDayMessage;
  String get logMealAction;
  String get logSymptomAction;
  String get sleepCardTitle;
  String get sleepQualityBad;
  String get sleepQualityMedium;
  String get sleepQualityGood;
  String get sleepQuestion;
  String get weatherUnavailable;
  String get pressureUnit;
  String get weatherTemperatureLabel;
  String get weatherPressureLabel;
  String get weatherHumidityLabel;
  String get weatherUvLabel;
  String get weatherPollenLabel;
  String get weatherAirLabel;
  String get airQualityUnit;
  String get pollenLevelLow;
  String get pollenLevelModerate;
  String get pollenLevelHigh;
  String get weatherUpdatedJustNow;
  String weatherUpdatedMinutesAgo(int minutes);
  String weatherUpdatedHoursAgo(int hours);
  String get weatherChartNoData;
  String get weatherChartMeasuredLegend;
  String get weatherChartForecastLegend;
  String get mealTypeBreakfast;
  String get mealTypeLunch;
  String get mealTypeDinner;
  String get mealTypeSnack;
  String get symptomTypeMigraine;
  String get symptomTypeDigestive;
  String get symptomTypeMood;
  String get symptomTypePain;

  // Meal entry
  String get mealEntryTitle;
  String get editMealTitle;
  String get takePhoto;
  String get retakePhoto;
  String get removePhoto;
  String get mealTypeLabel;
  String get tagsLabel;
  String get tagSearchHint;
  String createTagLabel(String label);
  String get suggestedTagsLabel;
  String get noteHint;
  String get saveAsFavorite;
  String get favoriteNameTitle;
  String get favoriteNameHint;
  String get favoriteSaved;
  String get mealSaved;
  String get errorGeneric;
  String get entryDeleted;

  // Favorites
  String get favoriteMealAdded;
  String get undoAction;
  String get favoritesManageTitle;
  String get manageFavoritesAction;
  String get noFavoritesMessage;
  String get newFavoriteTitle;
  String get editFavoriteTitle;
  String get favoriteUpdated;
  String get deleteAction;
  String get deleteFavoriteConfirmTitle;
  String get deleteFavoriteConfirmMessage;
  String get favoriteDeleted;

  // Symptom entry
  String get symptomEntryTitle;
  String get editSymptomTitle;
  String get symptomEntryTypeLabel;
  String get intensityLabel;
  String get detailLabel;
  String get endTimeLabel;
  String get removeEndTime;
  String get symptomSaved;
  String get symptomDetailBloating;
  String get symptomDetailPain;
  String get symptomDetailNausea;
  String get symptomDetailIrritable;
  String get symptomDetailAnxious;
  String get symptomDetailLow;
  String get symptomDetailBack;
  String get symptomDetailJoint;
  String get symptomDetailMuscle;

  // Medication intakes (US-20)
  String get medicationSectionTitle;
  String get addMedicationAction;
  String get medicationNameLabel;
  String get medicationDoseLabel;
  String get medicationIntakeTimeLabel;
  String get removeMedicationIntake;
  String get pdfSectionMedications;

  // Sleep entry
  String get sleepQualityLabel;
  String get bedTimeLabel;
  String get wakeTimeLabel;
  String get removeBedTime;
  String get removeWakeTime;
  String get sleepSaved;

  // Settings
  String get settingsTitle;
  String get aboutSectionTitle;
  String get openMeteoAttribution;
  String get manageNotificationsAction;
  String get photoTagSuggestionsSettingTitle;
  String get photoTagSuggestionsSettingSubtitle;

  // Notifications
  String get notificationChannelMealsName;
  String get notificationChannelMealsDescription;
  String get notificationChannelSleepName;
  String get notificationChannelSleepDescription;
  String get notificationChannelWeatherName;
  String get notificationChannelWeatherDescription;
  String get notificationChannelSymptomsName;
  String get notificationChannelSymptomsDescription;
  String get mealReminderTitle;
  String get mealReminderPhotoAction;
  String get mealReminderFavoriteAction;
  String get pressureDropAlertTitle;
  String get pressureDropAlertBody;
  String get symptomsReminderTitle;

  // Notification settings (US-16)
  String get notificationSettingsTitle;
  String get notificationSettingsSaved;

  // PDF export (US-17)
  String get exportPdfAction;
  String get pdfExportScreenTitle;
  String get pdfExportRangeLabel;
  String get pdfExportChooseRange;
  String get pdfExportGenerate;
  String get pdfExportShare;
  String get pdfExportEmptyRange;
  String get pdfDocTitle;
  String get pdfSectionMeals;
  String get pdfSectionSymptoms;
  String get pdfSectionWeather;

  // Onboarding
  String get onboardingSkip;
  String get onboardingNext;
  String get onboardingValueTitle;
  String get onboardingValueBody;
  String get onboardingLoggingTitle;
  String get onboardingLoggingBody;
  String get onboardingWeatherTitle;
  String get onboardingWeatherBody;
  String get onboardingPermissionTitle;
  String get onboardingPermissionBody;
  String get onboardingEnableLocation;
  String get onboardingMaybeLater;
}
