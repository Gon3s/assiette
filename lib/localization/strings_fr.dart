import 'package:assiette/localization/app_strings.dart';

/// French strings.
class AppStringsFr implements AppStrings {
  @override
  String get welcomeBack => 'Bon retour';
  @override
  String get signInSubtitle => 'Connectez-vous à votre compte';
  @override
  String get email => 'Email';
  @override
  String get emailHint => 'exemple@domaine.fr';
  @override
  String get password => 'Mot de passe';
  @override
  String get signIn => 'Se connecter';
  @override
  String get createAccount => 'Créer un compte';
  @override
  String get createAccountTitle => 'Créer un compte';
  @override
  String get createAccountSubtitle => 'Rejoignez-nous dès maintenant';
  @override
  String get signUp => "S'inscrire";
  @override
  String get alreadyHaveAccount => 'Déjà un compte ? Se connecter';

  @override
  String get homeTitle => 'Accueil';

  @override
  String get today => "Aujourd'hui";
  @override
  String get emptyDayMessage => 'Rien pour ce jour.';
  @override
  String get logMealAction => 'Photo repas';
  @override
  String get logSymptomAction => 'Symptôme';
  @override
  String get comingSoon => 'Bientôt disponible';
  @override
  String get sleepCardTitle => 'Sommeil';
  @override
  String get sleepNotLogged => 'Nuit non renseignée';
  @override
  String get sleepQualityBad => 'Mauvais';
  @override
  String get sleepQualityMedium => 'Moyen';
  @override
  String get sleepQualityGood => 'Bon';
  @override
  String get weatherUnavailable => 'Météo indisponible';
  @override
  String get pressureUnit => 'hPa';
  @override
  String get mealTypeBreakfast => 'Petit-déjeuner';
  @override
  String get mealTypeLunch => 'Déjeuner';
  @override
  String get mealTypeDinner => 'Dîner';
  @override
  String get mealTypeSnack => 'Snack';
  @override
  String get symptomTypeMigraine => 'Migraine';
  @override
  String get symptomTypeDigestive => 'Digestif';
  @override
  String get symptomTypeMood => 'Humeur';

  @override
  String get accountTitle => 'Mon compte';
  @override
  String get userInfo => 'Informations';
  @override
  String get changePassword => 'Changer le mot de passe';
  @override
  String get currentPassword => 'Mot de passe actuel';
  @override
  String get newPassword => 'Nouveau mot de passe';
  @override
  String get confirmPassword => 'Confirmer le mot de passe';
  @override
  String get save => 'Enregistrer';
  @override
  String get signOut => 'Se déconnecter';
  @override
  String get deleteAccount => 'Supprimer le compte';
  @override
  String get deleteAccountConfirmTitle => 'Supprimer le compte ?';
  @override
  String get deleteAccountConfirmMessage =>
      'Cette action est irréversible. Toutes vos données seront supprimées définitivement.';
  @override
  String get cancel => 'Annuler';
  @override
  String get confirm => 'Confirmer';

  @override
  String get emailEmpty => "L'email ne peut pas être vide";
  @override
  String get emailInvalid => "L'email n'est pas valide";
  @override
  String get passwordEmpty => 'Le mot de passe ne peut pas être vide';
  @override
  String get passwordTooShort =>
      'Le mot de passe doit contenir au moins 8 caractères';
  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';
}
