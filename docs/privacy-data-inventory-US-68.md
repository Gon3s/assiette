# Données, sauvegarde et confidentialité — US-68

État : inventaire du dépôt et décision Android. Ce document ne constitue pas
une politique de confidentialité ni une déclaration Data safety vérifiée.

## Décision Android

La sauvegarde système Android et le transfert d’appareil à appareil sont
désactivés pour les données de l’application. Le manifeste définit
`android:allowBackup="false"`, des règles d’exclusion pour Android 12 et plus,
et des règles d’exclusion historiques pour les versions antérieures. Les règles
excluent tout le stockage privé de l’application, dont la base Drift et les
photos conservées dans les documents privés.

Cette décision évite qu’une restauration système concurrence la sauvegarde
Drive et rende ambigu le consentement de l’utilisateur. La sauvegarde Drive
reste une action distincte offerte dans l’application. Il faut confirmer les
résultats sur manifestes fusionnés et appareils Android avant de considérer ce
comportement comme vérifié.

## Inventaire observé dans le dépôt

| Donnée / flux | Destination observée | Conservation et suppression observées |
| --- | --- | --- |
| Repas, tags, symptômes et migraines, prises de médicaments, sommeil, réglages, relevés météo/air | Base Drift dans le stockage privé de l’application | Plusieurs suppressions sont réversibles (soft delete). Aucun effacement global de toutes les données locales n’a été trouvé dans le dépôt. La conservation exacte après désinstallation dépend du système et n’est pas vérifiée ici. |
| Coordonnées approximatives et horodatage | Base locale, puis requête météo Open-Meteo | La permission Android est limitée à la position approximative au premier plan (US-67). Les coordonnées du relevé sont envoyées au service météo. Les pratiques de journalisation et de rétention d’Open-Meteo n’ont pas été vérifiées. |
| Base de données et photos référencées | Archive ZIP `assiette_backup.zip` dans le dossier applicatif Google Drive (`drive.appdata`) lors d’une sauvegarde explicite | L’archive remplace la sauvegarde précédente du compte. Elle n’est pas chiffrée par l’application. L’application n’offre pas de suppression distante de la sauvegarde ni de durée de rétention. La déconnexion Google ne supprime pas l’archive. |
| Restauration Drive | Base locale et photos sur l’appareil | La restauration remplace les données locales par l’instantané téléchargé. Elle ne supprime pas l’archive Drive. |

Les appels Google Sign-In et Drive envoient des données au service Google pour
l’authentification et le transfert de l’archive. La portée Drive observée est
`drive.appdata`; aucune portée générale Drive n’est déclarée dans le dépôt.

## Éléments externes requis avant clôture

### Extension : suivi des règles (28 octobre 2026)

Les dates civiles, statuts de saignement, flux facultatifs, débuts déclarés et
notes sont conservés dans `menstrual_days`. Le suivi, l’inclusion Drive et
l’inclusion PDF sont trois options indépendantes, toutes désactivées par défaut.
Une suppression d’observation est logique ; la commande dédiée d’effacement
définitif supprime toutes les observations locales et remet les trois options
à faux. Elle ne touche ni les autres données ni les copies Drive/PDF existantes.
Une restauration par remplacement peut réintroduire des données d’une archive.
Le format de sauvegarde v6 inclut une liste vide lorsque l’inclusion est refusée.
Les réglages du module restent dans la sauvegarde générale des réglages.
Il n’y a ni nouveau service distant ni nouvelle permission Android.

La politique source a été adaptée ; vérifier sa publication et les déclarations
Google Play relatives aux données menstruelles avant diffusion de cette version.

### Vérifications externes

- URL et contenu de la politique de confidentialité effectivement publiée.
- Valeurs actuelles de la fiche Google Play Data safety, y compris collecte,
  partage, chiffrement en transit, suppression et rétention.
- Paramètres OAuth et de sauvegarde Google Play/Android effectivement publiés.
- Vérification des manifestes fusionnés debug et release et du comportement
  de sauvegarde/transfert sur les versions Android prises en charge.
- Décision produit sur l’effacement distant de la sauvegarde Drive, sa durée de
  conservation, l’effacement local définitif et les données réintroduites lors
  d’une restauration.

Tant que ces éléments ne sont pas comparés aux faits ci-dessus, aucune
conformité de la politique ou de la déclaration Play n’est affirmée.

## Avancement au 23 octobre 2026

Les sources du dépôt ont été examinées et les règles Android ainsi que
l’information de sauvegarde FR/EN ont été ajoutées. Avec Flutter 3.44.5,
`flutter analyze --no-pub` ne signale aucun problème et l’APK debug est
construit. Les manifestes fusionnés debug et release ont été produits et
examinés : minSdk 24, targetSdk 36, `allowBackup=false` et les deux fichiers de
règles de sauvegarde sont présents. Aucune permission caméra, localisation
précise ou arrière-plan, alarme exacte ou service de premier plan ne subsiste.

Le manifeste release a été fusionné sans produire d’APK release : la clé de
signature de publication manque. Le contrôle runtime Android n’a pas pu être
fait car le daemon ADB ne démarre pas dans cet environnement. Les éléments
externes requis ci-dessus restent différés jusqu’à la préparation de la
publication.
