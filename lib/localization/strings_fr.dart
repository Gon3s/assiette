import 'package:assiette/localization/app_strings.dart';

/// French strings.
class AppStringsFr implements AppStrings {
  @override
  String get save => 'Enregistrer';
  @override
  String get cancel => 'Annuler';
  @override
  String get confirm => 'Confirmer';

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
  String get settingsTitle => 'À propos';
  @override
  String get aboutSectionTitle => 'Sources de données';
  @override
  String get openMeteoAttribution =>
      'Météo et pression fournies par Open-Meteo.com (CC BY 4.0).';
  @override
  String get manageNotificationsAction => 'Réglages notifications';

  @override
  String get notificationChannelMealsName => 'Repas';
  @override
  String get notificationChannelMealsDescription =>
      'Rappels pour loguer un repas';
  @override
  String get notificationChannelSleepName => 'Sommeil';
  @override
  String get notificationChannelSleepDescription =>
      'Rappel matinal pour loguer ton sommeil';
  @override
  String get notificationChannelWeatherName => 'Météo';
  @override
  String get notificationChannelWeatherDescription =>
      'Alertes liées à la météo et à la pression';
  @override
  String get notificationChannelSymptomsName => 'Check-in symptômes';
  @override
  String get notificationChannelSymptomsDescription =>
      'Rappel pour noter tes symptômes';
  @override
  String get mealReminderTitle => 'As-tu mangé ?';
  @override
  String get mealReminderPhotoAction => 'Photo';
  @override
  String get mealReminderFavoriteAction => 'Favori';
  @override
  String get pressureDropAlertTitle => 'Baisse de pression prévue';
  @override
  String get pressureDropAlertBody =>
      'Une baisse de pression est prévue dans les prochaines 24h — '
      'déclencheur fréquent pour certaines personnes.';
  @override
  String get symptomsReminderTitle => 'Comment te sens-tu ?';

  @override
  String get notificationSettingsTitle => 'Réglages notifications';
  @override
  String get notificationSettingsSaved => 'Préférences enregistrées';

  @override
  String get exportPdfAction => 'Exporter le journal en PDF';
  @override
  String get pdfExportScreenTitle => 'Export PDF';
  @override
  String get pdfExportRangeLabel => 'Période';
  @override
  String get pdfExportChooseRange => 'Choisir une période';
  @override
  String get pdfExportGenerate => 'Générer le PDF';
  @override
  String get pdfExportShare => 'Partager';
  @override
  String get pdfExportEmptyRange => 'Aucune donnée sur cette période';
  @override
  String get pdfDocTitle => 'Journal - Assiette';
  @override
  String get pdfSectionMeals => 'Repas';
  @override
  String get pdfSectionSymptoms => 'Symptômes';
  @override
  String get pdfSectionWeather => 'Pression';

  @override
  String get onboardingSkip => 'Passer';
  @override
  String get onboardingNext => 'Suivant';
  @override
  String get onboardingValueTitle => 'Repas, symptômes, environnement';
  @override
  String get onboardingValueBody =>
      "Assiette t'aide à relier ce que tu manges, comment tu te sens et "
      'la météo du jour.';
  @override
  String get onboardingLoggingTitle => 'Une photo, quelques tags';
  @override
  String get onboardingLoggingBody =>
      'Prends en photo ton repas et ajoute des tags en quelques secondes.';
  @override
  String get onboardingWeatherTitle => 'Météo et pression automatiques';
  @override
  String get onboardingWeatherBody =>
      'La météo et la pression atmosphérique sont enregistrées pour toi, '
      'en arrière-plan.';
  @override
  String get onboardingPermissionTitle => 'Autoriser la localisation';
  @override
  String get onboardingPermissionBody =>
      'La pression atmosphérique peut être liée aux migraines. Autorise '
      'la localisation pour la suivre automatiquement près de chez toi.';
  @override
  String get onboardingEnableLocation => 'Autoriser la localisation';
  @override
  String get onboardingMaybeLater => 'Plus tard';
}
