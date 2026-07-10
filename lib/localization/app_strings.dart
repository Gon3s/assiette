import 'package:assiette/localization/strings_en.dart';
import 'package:assiette/localization/strings_fr.dart';
import 'package:flutter/widgets.dart';

/// Abstract base class for all app strings.
abstract class AppStrings {
  /// Returns the [AppStrings] implementation for the current locale.
  /// Falls back to English if no localization ancestor is found.
  static AppStrings of(BuildContext context) {
    try {
      final locale = Localizations.localeOf(context);
      if (locale.languageCode == 'fr') return AppStringsFr();
    } catch (_) {
      // No localization ancestor — use English default
    }
    return AppStringsEn();
  }

  // Auth
  String get welcomeBack;
  String get signInSubtitle;
  String get email;
  String get emailHint;
  String get password;
  String get signIn;
  String get createAccount;
  String get createAccountTitle;
  String get createAccountSubtitle;
  String get signUp;
  String get alreadyHaveAccount;

  // Home
  String get homeTitle;

  // Day view
  String get today;
  String get emptyDayMessage;
  String get logMealAction;
  String get logSymptomAction;
  String get sleepCardTitle;
  String get sleepNotLogged;
  String get sleepQualityBad;
  String get sleepQualityMedium;
  String get sleepQualityGood;
  String get sleepQuestion;
  String get weatherUnavailable;
  String get pressureUnit;
  String get mealTypeBreakfast;
  String get mealTypeLunch;
  String get mealTypeDinner;
  String get mealTypeSnack;
  String get symptomTypeMigraine;
  String get symptomTypeDigestive;
  String get symptomTypeMood;

  // Meal entry
  String get mealEntryTitle;
  String get takePhoto;
  String get retakePhoto;
  String get removePhoto;
  String get mealTypeLabel;
  String get dateLabel;
  String get timeLabel;
  String get tagsLabel;
  String get tagSearchHint;
  String createTagLabel(String label);
  String get noteHint;
  String get saveAsFavorite;
  String get favoriteNameTitle;
  String get favoriteNameHint;
  String get favoriteSaved;
  String get mealSaved;
  String get errorGeneric;

  // Favorites
  String get favoriteMealAdded;
  String get undoAction;

  // Symptom entry
  String get symptomEntryTitle;
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

  // Sleep entry
  String get sleepQualityLabel;
  String get bedTimeLabel;
  String get wakeTimeLabel;
  String get removeBedTime;
  String get removeWakeTime;
  String get sleepSaved;

  // Account
  String get accountTitle;
  String get userInfo;
  String get changePassword;
  String get currentPassword;
  String get newPassword;
  String get confirmPassword;
  String get save;
  String get signOut;
  String get deleteAccount;
  String get deleteAccountConfirmTitle;
  String get deleteAccountConfirmMessage;
  String get cancel;
  String get confirm;

  // Settings
  String get settingsTitle;
  String get aboutSectionTitle;
  String get openMeteoAttribution;

  // Errors
  String get emailEmpty;
  String get emailInvalid;
  String get passwordEmpty;
  String get passwordTooShort;
  String get passwordsDoNotMatch;
}
