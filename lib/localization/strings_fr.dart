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
  String get addHealthAction => 'Ajouter';
  @override
  String get dailyFeelingsCardTitle => 'Ressentis du jour';
  @override
  String get activeMigraineTitle => 'Migraine en cours';
  @override
  String migraineDuration(String duration) => 'Depuis $duration';
  @override
  String get updateIntensityAction => 'Mettre à jour l’intensité';
  @override
  String get endMigraineAction => 'Terminer';
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
  String get weatherTemperatureLabel => 'Température';
  @override
  String get weatherPressureLabel => 'Pression';
  @override
  String get weatherHumidityLabel => 'Humidité';
  @override
  String get weatherUvLabel => 'UV';
  @override
  String get weatherPollenLabel => 'Pollen';
  @override
  String get weatherAirLabel => 'Air (PM2.5)';
  @override
  String get airQualityUnit => 'µg/m³';
  @override
  String get pollenLevelLow => 'Faible';
  @override
  String get pollenLevelModerate => 'Modéré';
  @override
  String get pollenLevelHigh => 'Élevé';
  @override
  String get weatherUpdatedJustNow => "MAJ à l'instant";
  @override
  String weatherUpdatedMinutesAgo(int minutes) => 'MAJ il y a $minutes min';
  @override
  String weatherUpdatedHoursAgo(int hours) => 'MAJ il y a $hours h';
  @override
  String get weatherChartNoData =>
      "Pas encore assez de mesures pour aujourd'hui";
  @override
  String get weatherChartMeasuredLegend => 'Mesuré';
  @override
  String get weatherChartForecastLegend => 'Prévision';
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
  String get symptomTypePain => 'Douleur';
  @override
  String get symptomTypeEczema => 'Eczéma';

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
  String get suggestedTagsLabel => 'Suggestions';
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
  String get symptomDetailBack => 'Dos';
  @override
  String get symptomDetailJoint => 'Articulaire';
  @override
  String get symptomDetailMuscle => 'Musculaire';
  @override
  String get migraineEntryTitle => 'Nouvelle migraine';
  @override
  String get dailyFeelingTitle => 'Ressenti';
  @override
  String get dailyMoodTitle => 'Humeur du jour';
  @override
  String get feelingCategoryLabel => 'Catégorie';
  @override
  String get dailyNoteHint => 'Que ressens-tu ?';
  @override
  String get migraineStartLabel => 'Début';
  @override
  String get migraineStartExact => 'Exact';
  @override
  String get migraineStartApproximate => 'Approximatif';
  @override
  String get migraineStartUnknown => 'Inconnu';
  @override
  String get migraineEndLabel => 'Fin';
  @override
  String get maximumIntensityLabel => 'Intensité maximale';
  @override
  String get migraineObservationsTitle => 'Évolution de la migraine';
  @override
  String get addMigraineObservationAction => 'Ajouter une observation';
  @override
  String get editMigraineObservationTitle => 'Modifier l’observation';
  @override
  String get observationTimeLabel => 'Heure de l’observation';
  @override
  String get migraineLateralityLabel => 'Latéralité';
  @override
  String get migraineLateralityLeft => 'Gauche';
  @override
  String get migraineLateralityRight => 'Droite';
  @override
  String get migraineLateralityBilateral => 'Bilatérale';
  @override
  String get migraineLocationLabel => 'Localisation';
  @override
  String get migraineLocationForehead => 'Front';
  @override
  String get migraineLocationTemple => 'Tempe';
  @override
  String get migraineLocationEye => 'Œil';
  @override
  String get migraineLocationBackOfHead => 'Arrière du crâne';
  @override
  String get migraineLocationNeck => 'Nuque';
  @override
  String get migraineLocationDiffuse => 'Diffuse';
  @override
  String get auraLabel => 'Aura';
  @override
  String get nauseaLabel => 'Nausée';
  @override
  String get photophobiaLabel => 'Photophobie';
  @override
  String get phonophobiaLabel => 'Phonophobie';
  @override
  String get presenceUnknown => 'Inconnu';
  @override
  String get presenceAbsent => 'Absent';
  @override
  String get presencePresent => 'Présent';
  @override
  String get observationDeleted => 'Observation supprimée';
  @override
  String get activeMigraineExistsTitle => 'Une migraine est déjà en cours';
  @override
  String get activeMigraineExistsBody =>
      'Terminer la migraine précédente maintenant ?';
  @override
  String previousIntensity(int intensity) =>
      'Intensité précédemment enregistrée : $intensity/10';

  @override
  String get medicationSectionTitle => 'Médicaments';
  @override
  String get addMedicationAction => 'Ajouter une prise';
  @override
  String get medicationNameLabel => 'Médicament';
  @override
  String get medicationDoseLabel => 'Dose (optionnel)';
  @override
  String get medicationIntakeTimeLabel => 'Heure de prise';
  @override
  String get removeMedicationIntake => 'Supprimer la prise';
  @override
  String get pdfSectionMedications => 'Médicaments';
  @override
  String get medicationEntryTitle => 'Médicament';
  @override
  String get newMedicationAction => 'Nouveau médicament';
  @override
  String get recentMedicationsTitle => 'Médicaments récents';
  @override
  String get medicationSaved => 'Prise enregistrée';
  @override
  String get linkToActiveMigraine => 'Associer à la migraine en cours';

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
  String get photoTagSuggestionsSettingTitle =>
      'Suggestion de tags depuis la photo';
  @override
  String get photoTagSuggestionsSettingSubtitle =>
      "Analyse la photo sur l'appareil pour proposer des tags à confirmer. "
      'Jamais envoyée, jamais appliquée automatiquement.';

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
  String get notificationChannelSymptomsName => 'Humeur du jour';
  @override
  String get notificationChannelSymptomsDescription =>
      'Rappel pour noter ton humeur du jour';
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
  String get symptomsReminderTitle => 'Quelle est ton humeur du jour ?';

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
  String get cloudBackupAction => 'Sauvegarde cloud';
  @override
  String get cloudBackupScreenTitle => 'Sauvegarde cloud';
  @override
  String get cloudBackupSignInAction => 'Se connecter avec Google';
  @override
  String get cloudBackupSignOutAction => 'Se déconnecter';
  @override
  String cloudBackupSignedInAs(String email) => 'Connecté en tant que $email';
  @override
  String get cloudBackupNotSignedIn => 'Aucun compte connecté';
  @override
  String get cloudBackupNowAction => 'Sauvegarder maintenant';
  @override
  String get cloudBackupInProgress => 'Sauvegarde en cours…';
  @override
  String get cloudBackupLastBackupLabel => 'Dernière sauvegarde';
  @override
  String get cloudBackupNeverBackedUp => 'Jamais sauvegardé';
  @override
  String get cloudBackupSuccess => 'Sauvegarde terminée';
  @override
  String get cloudBackupFailure =>
      'Échec de la sauvegarde. Vérifie ta connexion et réessaie.';
  @override
  String get cloudRestoreAction => 'Restaurer ma sauvegarde';
  @override
  String get cloudRestoreInProgress => 'Restauration en cours…';
  @override
  String get cloudRestoreSuccess => 'Restauration terminée';
  @override
  String get cloudRestoreFailure =>
      'Échec de la restauration. Vérifie ta connexion et réessaie.';
  @override
  String get cloudRestoreConfirmTitle => 'Restaurer la sauvegarde ?';
  @override
  String get cloudRestoreConfirmBody =>
      'Toutes les données locales actuelles seront remplacées par la '
      'dernière sauvegarde. Action irréversible.';
  @override
  String get cloudRestoreNoBackupFound =>
      'Aucune sauvegarde trouvée pour ce compte';
  @override
  String get cloudRestorePromptTitle => 'Sauvegarde trouvée';
  @override
  String get cloudRestorePromptBody =>
      'Une sauvegarde existe pour ce compte Google. La restaurer '
      'maintenant ?';
  @override
  String get cloudRestorePromptLater => 'Plus tard';

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
