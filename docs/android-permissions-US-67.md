# Permissions Android — US-58 et US-67

## Périmètre

La capture photo et la reconnaissance des repas sont retirées (US-58). Les
repas sont saisis manuellement. Les anciennes photos restent visibles dans
l’historique et les favoris ; modifier un repas ou un favori laisse sa colonne
photo intacte. Les colonnes et fichiers existants, le format des sauvegardes
cloud et l’ancien identifiant d’action de notification `meal_photo` sont
conservés. Aucun nettoyage de photos ni migration de schéma n’est effectué.

`image_picker`, `google_mlkit_image_labeling` et `permission_handler`, ainsi
que leurs dépendances exclusives, sont supprimés.

## Localisation et météo

- Seule `ACCESS_COARSE_LOCATION` est déclarée. La météo régionale ne nécessite
  pas de position précise.
- Le démarrage ne demande aucune permission. Le dernier écran d’onboarding
  explique la finalité et permet d’autoriser la position ou de continuer sans.
- La demande est déclenchée par « Autoriser la localisation ». Android propose
  un accès pendant l’utilisation ou pour cette fois, selon sa version.
- La lecture de position est limitée à l’application visible. Au premier plan,
  un emplacement récent peut être réutilisé ; sinon une position de faible
  précision est demandée, avec délai maximal. Une réponse reçue après le passage
  en arrière-plan est ignorée.
- Le worker périodique utilise les coordonnées du dernier relevé enregistré.
  Il vérifie le consentement existant et le service de localisation, sans ouvrir
  de dialogue ni interroger la position du terminal. Sans consentement ou sans
  coordonnées, il termine sans travail plutôt que de relancer indéfiniment.
- La météo en arrière-plan reste celle du dernier lieu enregistré, y compris
  pendant un déplacement. La position sera actualisée à une prochaine ouverture
  au premier plan. L’onboarding FR/EN explique ce comportement.
- Révoquer la permission ou désactiver la localisation interrompt les nouveaux
  cycles météo. Les relevés historiques sont conservés.

Ce choix applique le principe de portée minimale des règles Google Play :
la fonctionnalité fonctionne avec une position approximative et n’exige pas
d’accès à la position en arrière-plan.

## Permissions conservées dans les manifestes fusionnés

| Permission | Justification |
| --- | --- |
| `INTERNET` | Météo/qualité de l’air Open-Meteo, connexion Google et sauvegarde/restauration Drive. |
| `ACCESS_COARSE_LOCATION` | Position approximative au premier plan pour choisir le lieu de la météo. Consentement contextuel, refus accepté. |
| `POST_NOTIFICATIONS` | Rappels et alertes météo. Demande après une saisie de repas ou l’activation/enregistrement des préférences de rappel, sur Android 13+. |
| `RECEIVE_BOOT_COMPLETED` | Réenregistrement des rappels et du travail WorkManager après redémarrage. Les receivers de l’application ne sont pas exportés. |
| `WAKE_LOCK` | Exécution courte du travail WorkManager et des notifications ; aucun suivi permanent. |
| `VIBRATE` | Signal des notifications, soumis aux préférences Android. |
| `ACCESS_NETWORK_STATE` | Contrainte réseau des tâches WorkManager et intégrations réseau. |
| `com.gones.assiette.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION` | Permission interne AndroidX, déclarée avec protection `signature`, pour protéger les receivers dynamiques. Aucune demande utilisateur. |

Les permissions caméra, position précise, position en arrière-plan, alarmes
exactes, services de premier plan et biométrie/empreinte sont explicitement
exclues de la fusion. Le service inutilisé
`com.baseflow.geolocator.GeolocatorLocationService` est retiré.

## Rappels sans alarme exacte

Les cinq rappels quotidiens utilisent
`AndroidScheduleMode.inexactAllowWhileIdle`. Aucune demande d’accès spécial
aux alarmes exactes n’est nécessaire. Android peut différer leur livraison
selon ses restrictions de batterie ; les préférences l’indiquent en FR/EN.
La ponctualité à la minute n’est pas garantie.

## Composants exportés

Inventaire identique pour les manifestes debug et release contrôlés :

| Composant | Protection / raison |
| --- | --- |
| `com.gones.assiette.MainActivity` | Activité de lancement, seule entrée exportée sans permission. |
| `com.google.android.gms.auth.api.signin.RevocationBoundService` | `com.google.android.gms.auth.api.signin.permission.REVOCATION_NOTIFICATION`, service de révocation Google Sign-In. |
| `androidx.work.impl.background.systemjob.SystemJobService` | `android.permission.BIND_JOB_SERVICE`, appels du planificateur système. |
| `androidx.work.impl.diagnostics.DiagnosticsReceiver` | `android.permission.DUMP`, diagnostic protégé système/signature. |
| `androidx.profileinstaller.ProfileInstallReceiver` | `android.permission.DUMP`, installation de profil protégée système/signature. |

Les autres activités, services, providers et receivers des manifestes contrôlés
ne sont pas exportés. `tool/check_android_manifest.ps1` rejette une permission
hors liste, un composant exporté non protégé (sauf le lanceur), un export implicite
avec filtre d’intention et le retour du service de localisation.

Après une construction Android, lancer par exemple :

```powershell
rtk proxy powershell -NoProfile -ExecutionPolicy Bypass -File tool/check_android_manifest.ps1 -Path build/app/intermediates/merged_manifests/debug/processDebugManifest/AndroidManifest.xml
rtk proxy powershell -NoProfile -ExecutionPolicy Bypass -File tool/check_android_manifest.ps1 -Path build/app/intermediates/merged_manifests/release/processReleaseManifest/AndroidManifest.xml
```

## Contrôles effectués

Avec Flutter 3.44.5 / Dart 3.12.2 :

- Génération `build_runner`, analyse sans diagnostic et 305 tests réussis.
- Tests ciblés : consentement/visibilité et lecture approximative, coordonnées
  stockées et révocation, worker sans coordonnées, cinq rappels inexacts,
  permission de notification contextuelle, conservation des anciennes photos
  lors des modifications, compatibilité des sauvegardes cloud.
- Construction de l’APK debug et audit positif des manifestes fusionnés debug
  et release. Le manifeste release a été produit avec une clé de contrôle
  jetable ; la clé et `android/key.properties` temporaires ont été supprimés.
  Aucun artefact de publication n’a été signé avec cette clé.
- Android 15 / API 35, émulateur isolé : aucun dialogue au lancement ; demande
  de position approximative après action explicite ; refus suivi d’un accueil
  utilisable ; formulaire de repas manuel sans caméra ; demande de notifications
  après enregistrement ; acceptation de la position au premier plan et météo
  chargée avec le service de localisation retiré.
- Application masquée, reprise réseau puis worker WorkManager terminé avec
  `SUCCESS` : le dernier accès `COARSE_LOCATION` reste celui du premier plan,
  sans nouvelle lecture de position pendant ce cycle de fond.
- Les permissions du package effectivement installé correspondent à la liste
  des manifestes fusionnés. Le contrôle a également rejeté l’ancien manifeste
  qui déclarait encore `ACCESS_FINE_LOCATION`.

Limites : contrôle natif sur émulateur Android 15, sans mesure longue durée de
Doze, d’autonomie ou de ponctualité des rappels sur appareils constructeurs.
La déclaration Data safety, les textes de confidentialité et la validation
Play Console relèvent de l’US-68 ; ce document ne vaut pas validation par Google.

## Références

- [Google Play — accès à la position en arrière-plan](https://support.google.com/googleplay/android-developer/answer/9799150?hl=en)
- [Google Play — portée minimale des permissions de localisation](https://support.google.com/googleplay/android-developer/answer/17033915?hl=en)
- [Android — alarmes exactes et inexactes](https://developer.android.com/develop/background-work/services/alarms)
