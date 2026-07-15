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
  String get sleepQuestion => 'Comment as-tu dormi ?';
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
  String get mealEntryTitle => 'Nouveau repas';
  @override
  String get editMealTitle => 'Modifier le repas';
  @override
  String get takePhoto => 'Prendre une photo';
  @override
  String get retakePhoto => 'Reprendre';
  @override
  String get removePhoto => 'Supprimer la photo';
  @override
  String get mealTypeLabel => 'Type de repas';
  @override
  String get dateLabel => 'Date';
  @override
  String get timeLabel => 'Heure';
  @override
  String get tagsLabel => 'Tags';
  @override
  String get tagSearchHint => 'Rechercher ou créer un tag';
  @override
  String createTagLabel(String label) => 'Créer « $label »';
  @override
  String get noteHint => 'Note (optionnel)';
  @override
  String get saveAsFavorite => 'Enregistrer comme favori';
  @override
  String get favoriteNameTitle => 'Nom du favori';
  @override
  String get favoriteNameHint => 'Ex. Salade César';
  @override
  String get favoriteSaved => 'Favori enregistré';
  @override
  String get mealSaved => 'Repas enregistré';
  @override
  String get errorGeneric => 'Une erreur est survenue';
  @override
  String get entryDeleted => 'Entrée supprimée';

  @override
  String get favoriteMealAdded => 'Repas ajouté';
  @override
  String get undoAction => 'Annuler';
  @override
  String get favoritesManageTitle => 'Mes favoris';
  @override
  String get manageFavoritesAction => 'Gérer mes favoris';
  @override
  String get noFavoritesMessage => 'Aucun favori pour le moment.';
  @override
  String get newFavoriteTitle => 'Nouveau favori';
  @override
  String get editFavoriteTitle => 'Modifier le favori';
  @override
  String get favoriteUpdated => 'Favori mis à jour';
  @override
  String get deleteAction => 'Supprimer';
  @override
  String get deleteFavoriteConfirmTitle => 'Supprimer ce favori ?';
  @override
  String get deleteFavoriteConfirmMessage => 'Cette action est définitive.';
  @override
  String get favoriteDeleted => 'Favori supprimé';

  @override
  String get symptomEntryTitle => 'Nouveau symptôme';
  @override
  String get editSymptomTitle => 'Modifier le symptôme';
  @override
  String get symptomEntryTypeLabel => 'Type de symptôme';
  @override
  String get intensityLabel => 'Intensité';
  @override
  String get detailLabel => 'Détail (optionnel)';
  @override
  String get endTimeLabel => 'Ajouter une heure de fin';
  @override
  String get removeEndTime => "Supprimer l'heure de fin";
  @override
  String get symptomSaved => 'Symptôme enregistré';
  @override
  String get symptomDetailBloating => 'Ballonnement';
  @override
  String get symptomDetailPain => 'Douleur';
  @override
  String get symptomDetailNausea => 'Nausée';
  @override
  String get symptomDetailIrritable => 'Irritable';
  @override
  String get symptomDetailAnxious => 'Anxieux';
  @override
  String get symptomDetailLow => 'Abattu';

  @override
  String get sleepQualityLabel => 'Qualité';
  @override
  String get bedTimeLabel => 'Heure du coucher';
  @override
  String get wakeTimeLabel => 'Heure du réveil';
  @override
  String get removeBedTime => "Supprimer l'heure de coucher";
  @override
  String get removeWakeTime => "Supprimer l'heure de réveil";
  @override
  String get sleepSaved => 'Sommeil enregistré';

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
  String get settingsTitle => 'À propos';
  @override
  String get aboutSectionTitle => 'Sources de données';
  @override
  String get openMeteoAttribution =>
      'Météo et pression fournies par Open-Meteo.com (CC BY 4.0).';

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
