import 'package:assiette/localization/app_strings.dart';

/// English strings.
class AppStringsEn implements AppStrings {
  @override
  String get welcomeBack => 'Welcome back';
  @override
  String get signInSubtitle => 'Sign in to your account';
  @override
  String get email => 'Email';
  @override
  String get emailHint => 'example@domain.com';
  @override
  String get password => 'Password';
  @override
  String get signIn => 'Sign in';
  @override
  String get createAccount => 'Create an account';
  @override
  String get createAccountTitle => 'Create an account';
  @override
  String get createAccountSubtitle => 'Join us today';
  @override
  String get signUp => 'Sign up';
  @override
  String get alreadyHaveAccount => 'Already have an account? Sign in';

  @override
  String get homeTitle => 'Home';

  @override
  String get today => 'Today';
  @override
  String get emptyDayMessage => 'Nothing logged this day.';
  @override
  String get logMealAction => 'Meal photo';
  @override
  String get logSymptomAction => 'Symptom';
  @override
  String get comingSoon => 'Coming soon';
  @override
  String get sleepCardTitle => 'Sleep';
  @override
  String get sleepNotLogged => 'Night not logged';
  @override
  String get sleepQualityBad => 'Bad';
  @override
  String get sleepQualityMedium => 'Okay';
  @override
  String get sleepQualityGood => 'Good';
  @override
  String get weatherUnavailable => 'Weather unavailable';
  @override
  String get pressureUnit => 'hPa';
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
  String get mealEntryTitle => 'New meal';
  @override
  String get takePhoto => 'Take a photo';
  @override
  String get retakePhoto => 'Retake';
  @override
  String get removePhoto => 'Remove photo';
  @override
  String get mealTypeLabel => 'Meal type';
  @override
  String get dateLabel => 'Date';
  @override
  String get timeLabel => 'Time';
  @override
  String get tagsLabel => 'Tags';
  @override
  String get tagSearchHint => 'Search or create a tag';
  @override
  String createTagLabel(String label) => 'Create "$label"';
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
  String get accountTitle => 'My account';
  @override
  String get userInfo => 'Information';
  @override
  String get changePassword => 'Change password';
  @override
  String get currentPassword => 'Current password';
  @override
  String get newPassword => 'New password';
  @override
  String get confirmPassword => 'Confirm password';
  @override
  String get save => 'Save';
  @override
  String get signOut => 'Sign out';
  @override
  String get deleteAccount => 'Delete account';
  @override
  String get deleteAccountConfirmTitle => 'Delete account?';
  @override
  String get deleteAccountConfirmMessage =>
      'This action is irreversible. All your data will be permanently deleted.';
  @override
  String get cancel => 'Cancel';
  @override
  String get confirm => 'Confirm';

  @override
  String get emailEmpty => 'Email cannot be empty';
  @override
  String get emailInvalid => 'Email is not valid';
  @override
  String get passwordEmpty => 'Password cannot be empty';
  @override
  String get passwordTooShort => 'Password must be at least 8 characters';
  @override
  String get passwordsDoNotMatch => 'Passwords do not match';
}
