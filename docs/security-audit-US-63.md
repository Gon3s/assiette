# Audit sécurité et confidentialité — US-63

## Actualisation du 27 octobre 2026

Les sections suivantes conservent les constats historiques du 22 octobre.
Elles ne décrivent pas toutes l'état actuel du dépôt. La revue des sources
au 27 octobre donne les résultats suivants :

| Constat | État actuel dans le dépôt |
|---|---|
| SEC-63-01 | Corrigé dans les sources : `BackupArchiveCodec` borne téléchargement et décompression, vérifie les entrées et CRC ; `BackupRestorer` valide le snapshot, prépare les photos dans un nouveau dossier et nettoie en cas d'échec de la transaction. Voir [US-65/66](security-fixes-US-65-66.md). |
| SEC-63-02 | Toujours applicable : la sauvegarde Drive ne comporte pas de chiffrement côté application. La décision produit reste distincte des corrections techniques. |
| SEC-63-03 | Permissions réduites : localisation approximative uniquement pendant l'utilisation ; caméra, localisation en arrière-plan et alarmes exactes retirées explicitement du manifeste. Voir [US-67](android-permissions-US-67.md). Vérification sur artefact/appareil encore nécessaire. |
| SEC-63-04 | Corrigé dans les sources : signature release dédiée et validation dans `android/release-signing.gradle.kts`, sans fallback debug. Voir [US-65/66](security-fixes-US-65-66.md). |
| SEC-63-05 | Règles explicites présentes : `allowBackup=false`, `backup_rules.xml` et `data_extraction_rules.xml`. Voir [US-68](privacy-data-inventory-US-68.md). Comportement OS/appareil à vérifier. |
| SEC-63-06 | Notice présente dans `docs/privacy.html` et liée depuis les réglages ; inventaire [US-68](privacy-data-inventory-US-68.md) disponible. Déploiement public et déclarations Play non vérifiés ici. |
| SEC-63-07 | Actions épinglées sur SHA dans les deux workflows Android ; droits `contents: write` limités au job de publication APK. Protection des branches/environnements non vérifiée ici. |

Cette actualisation est une revue statique des sources ; elle ne certifie
ni l'application publiée ni les réglages des services externes.

## Audit historique du 22 octobre 2026

Date : 2026-10-22  
Périmètre : revue statique du dépôt, des manifestes Android, des workflows GitHub et du parcours de sauvegarde Google Drive. Aucune analyse dynamique, inspection de l’application publiée, de la console Play, du projet Google Cloud ou des secrets CI n’a été possible dans ce dépôt.

## Résumé

L’application stocke localement des données de santé et d’environnement (repas, symptômes/migraines, médicaments, sommeil, localisation/météo) dans Drift, ainsi que des photos dans le répertoire privé de l’application. L’export analytique PDF peut être partagé par l’utilisateur. La sauvegarde sérialise les tables en JSON et les photos dans un ZIP envoyé au dossier Drive `appDataFolder` avec le scope `drive.appdata`. Les appels météo partent vers Open-Meteo. Le code de capture d’environnement demande une localisation en arrière-plan.

Deux points doivent bloquer une nouvelle publication jusqu’à décision/correction : la restauration accepte une archive sans limites ni validation complète avant d’écrire les photos, et la configuration de signature Gradle retombe sur la clé debug pour un build release local sans keystore. La politique de confidentialité et les déclarations Data safety de Play n’ont pas pu être vérifiées car aucun lien ou export de ces déclarations n’est présent dans le dépôt.

## Inventaire des données et flux

| Donnée | Stockage / traitement observé | Flux externe observé |
|---|---|---|
| Repas, tags, photos, symptômes, migraines, prises de médicaments, sommeil, réglages | Tables Drift dans la base SQLite `assiette`; photos sous `Documents/meal_photos` | Sauvegarde JSON + photos vers Google Drive; export PDF local/partage système |
| Localisation | Latitude/longitude et horodatage dans `EnvironmentSnapshots`; capture périodique et à l’ouverture | Coordonnées envoyées à Open-Meteo pour les données météo; aucune géolocalisation envoyée à Google observée dans ce parcours |
| Identité de sauvegarde | Compte Google et jeton d’accès gérés par `google_sign_in` | Scope Drive `drive.appdata`, appels Drive |
| Suggestion de tags photo | ML Kit Image Labeling utilisé dans l’application | Traitement on-device dans le code observé |
| Notifications | Notifications locales, paramètres et planifications | Aucun serveur de notification observé |

Le dépôt ne déclare pas de politique de rétention, de suppression complète des données, de chiffrement applicatif ou de comportement Android Auto Backup. Le comportement effectif du backup système Android reste à vérifier sur le manifeste fusionné et sur appareil.

## Constats

### SEC-63-01 — Restauration ZIP non bornée et fichiers écrits avant validation

- **Gravité / vraisemblance :** élevée / moyenne.
- **Preuve :** `GoogleDriveBackupRepository.restoreLatest()` appelle `ZipDecoder().decodeBytes(zipBytes)` sans limite de taille compressée/décompressée, décode `database.json` en Map et écrit chaque entrée `photos/` dans le répertoire photo avant d’appeler le codec. Le nom est réduit par `basename`, ce qui réduit le risque de traversal, mais ne valide ni le nombre/taille/type des entrées ni la cohérence de la sauvegarde.
- **Impact :** archive endommagée ou hostile pouvant consommer beaucoup de mémoire/espace, écraser des photos portant le même nom, ou laisser les photos modifiées alors que la restauration DB échoue. L’import remplace la base locale dans une transaction, mais les écritures photo sont hors transaction.
- **Correction :** borner taille ZIP, taille décompressée, nombre d’entrées et taille de chaque photo; valider version et schéma/relations avant toute écriture; extraire vers un dossier temporaire, puis remplacer les photos après validation et avec rollback/nettoyage; rejeter entrées inattendues, chemins absolus et doublons.
- **Propriétaire technique :** `features/cloud_backup`.
- **Livraison :** bloquant avant exposition publique de la restauration. Aucun test dynamique d’archive hostile n’a été exécuté.

### SEC-63-02 — Sauvegarde de santé non chiffrée côté application

- **Gravité / vraisemblance :** élevée / moyenne.
- **Preuve :** `backupNow()` encode `database.json` et les photos en ZIP puis l’envoie avec `driveAppdataScope`; aucun chiffrement applicatif avant upload n’est présent. `appDataFolder` limite la visibilité via l’interface Drive, mais ce n’est pas un chiffrement de bout en bout contrôlé par l’application.
- **Impact :** le contenu de santé dépend de la protection du compte et de l’infrastructure Google; toute compromission d’accès Drive peut exposer la sauvegarde.
- **Correction :** décision produit documentée sur le modèle de menace; si la sauvegarde doit rester confidentielle même vis-à-vis du fournisseur, chiffrer côté client avec une clé récupérable par l’utilisateur, définir récupération/perte de clé, rotation et migration. Expliquer clairement au consentement la destination et la nature des données.
- **Propriétaire technique :** `features/cloud_backup` + produit.
- **Livraison :** décision requise avant de promouvoir la sauvegarde cloud comme stockage confidentiel. Le choix du chiffrement et de la récupération est une décision produit non résolue.

### SEC-63-03 — Permissions Android plus larges que le besoin démontré

- **Gravité / vraisemblance :** élevée / moyenne.
- **Preuve :** `AndroidManifest.xml` déclare `ACCESS_BACKGROUND_LOCATION`, `CAMERA`, coarse/fine location, exact alarm et notifications. `GeolocatorLocationReader.ensurePermission()` demande `locationAlways`; la capture photo passe par `image_picker` et suggestion on-device. Le retrait des fonctions photo de repas est planifié en US-58, donc `CAMERA` doit être réévaluée après cette US. Aucun usage de `ACCESS_BACKGROUND_LOCATION` en dehors de la capture environnement n’a été trouvé.
- **Impact :** collecte plus sensible que nécessaire, friction/risque de rejet Play lié à l’accès en arrière-plan, déclaration et justification utilisateur nécessaires; permission caméra potentiellement résiduelle.
- **Correction :** confirmer que la capture en arrière-plan est essentielle et conforme aux politiques Play; privilégier l’accès « pendant l’utilisation » si suffisant; supprimer les permissions qui ne sont plus requises après US-58; vérifier le manifeste fusionné des plugins et les prompts réellement affichés.
- **Propriétaire technique :** `features/environment_capture` + configuration Android.
- **Livraison :** bloquant si la déclaration Play ne justifie pas l’accès d’arrière-plan ou si une permission déclarée n’a pas de fonctionnalité correspondante.

### SEC-63-04 — Signature release retombe sur la clé debug

- **Gravité / vraisemblance :** élevée / faible à moyenne.
- **Preuve :** `android/app/build.gradle.kts` sélectionne `signingConfigs.getByName("debug")` lorsqu’aucun `key.properties` n’existe pour le build type `release`. Le workflow Play crée le keystore depuis les secrets, mais le build local release peut donc produire un artefact signé debug sans échec explicite.
- **Impact :** artefact release mal signé, non publiable ou provenance/signature ambiguë; risque d’erreur de livraison.
- **Correction :** faire échouer explicitement le build release si la configuration release manque; garder la signature debug uniquement sur le build type debug; vérifier les certificats upload/app-signing configurés côté Play.
- **Propriétaire technique :** Android build/CI.
- **Livraison :** bloquant pour produire un artefact release hors pipeline Play correctement configuré.

### SEC-63-05 — Sauvegarde automatique Android et données de santé non documentées

- **Gravité / vraisemblance :** moyenne à élevée / moyenne.
- **Preuve :** le manifeste principal ne précise ni `android:allowBackup` ni règles `dataExtractionRules`/`fullBackupContent`; le répertoire Drift et les photos sont dans le stockage privé standard. Les valeurs effectives dépendent du manifeste fusionné Android et de la version OS.
- **Impact :** des données locales peuvent être incluses dans le mécanisme de sauvegarde système du compte Android sans que l’UX de sauvegarde Drive soit l’unique chemin compris par l’utilisateur.
- **Correction :** inspecter le manifeste fusionné et la sauvegarde sur versions Android supportées; décider explicitement quelles bases/fichiers sont exclus ou inclus; aligner l’information utilisateur.
- **Propriétaire technique :** configuration Android.
- **Livraison :** à résoudre avant publication après vérification sur artefact fusionné.

### SEC-63-06 — Déclarations Play et notice de confidentialité absentes du dépôt

- **Gravité / vraisemblance :** moyenne / moyenne.
- **Preuve :** aucune politique/notice de confidentialité ni export Data safety Play n’a été trouvée dans les fichiers du dépôt; l’écran À propos n’affiche que l’attribution Open-Meteo. Les flux de localisation, données de santé, photos et sauvegarde sont donc impossibles à rapprocher des déclarations publiques depuis ce checkout.
- **Impact :** risque de déclaration incomplète ou incohérente sur la collecte, le partage, la rétention et la suppression.
- **Correction :** fournir les URL/captures des fiches Play et de la politique publiée, les comparer à l’inventaire ci-dessus, puis corriger les déclarations ou le produit/documentation.
- **Propriétaire technique :** produit / publication Play.
- **Livraison :** vérification bloquée faute d’accès aux éléments externes; aucune conformité n’est affirmée.

### SEC-63-07 — Actions GitHub référencées par tags mutables

- **Gravité / vraisemblance :** moyenne / faible à moyenne.
- **Preuve :** workflows utilisent des références telles que `actions/checkout@v4`, `subosito/flutter-action@v2`, `softprops/action-gh-release@v2` et `r0adkll/upload-google-play@v1`, sans SHA complet. Le workflow Play restreint les permissions globales à `contents: read`; le workflow APK demande `contents: write` pour créer la release de développement.
- **Impact :** les tags peuvent avancer vers du code différent; une compromission amont d’action aurait accès aux jetons/secrets du job. Le droit `contents: write` est nécessaire pour publier le binaire dev mais augmente l’impact potentiel.
- **Correction :** épingler les actions tierces sur SHA complet avec Renovate/Dependabot pour mises à jour contrôlées; donner les permissions au job uniquement et réduire les permissions/étapes où possible; protéger l’environnement et la branche de publication.
- **Propriétaire technique :** CI GitHub.
- **Livraison :** amélioration recommandée; pas de preuve de compromission actuelle.

## État de la revue par domaine

- **Drift/fichiers :** base locale privée; aucune couche de chiffrement applicatif observée. Vérification du chiffrement OS et Auto Backup encore requise.
- **ZIP/restauration :** SEC-63-01 identifié; scope Drive limité à `drive.appdata`; pas de contrôle de taille ni validation préalable.
- **OAuth/scopes :** scope demandé uniquement `drive.appdata`, sans scope Drive général observé. Les identifiants et secrets de build transitent par secrets GitHub; vérifier les restrictions OAuth et la rotation dans la console Google Cloud.
- **Composants Android exportés :** activité launcher exportée (`MainActivity`, attendu); receivers de notifications exportés à `false`; aucune autre déclaration exportée dans le manifeste source. Les manifestes fusionnés restent à contrôler.
- **Notifications :** locales, permissions POST_NOTIFICATIONS/exact alarm déclarées; revoir l’exact alarm selon fonctionnalités et les données sensibles visibles sur écran verrouillé.
- **Localisation :** permission arrière-plan demandée et snapshots persistés; revue Play et réduction au minimum requis indispensables.
- **Secrets/signature :** clés référencées comme secrets GitHub et `android/key.properties` ignoré par Git; vérification de valeur, rotation et restriction impossible. SEC-63-04 identifié.
- **Workflows :** permissions Play en lecture seule au niveau workflow; workflow debug avec `contents: write`; actions non épinglées par SHA.
- **Play Store / notice :** éléments externes absents; SEC-63-06 bloqué.

## Plan de correction proposé

1. **S — Durcir les imports et restauration ZIP** : limites, validation préalable, staging des photos, échec atomique et cas de corruption/archive surdimensionnée.
2. **S — Faire échouer les builds release non signés correctement** : retirer le fallback debug du type release et vérifier les certificats de publication.
3. **M — Minimiser les permissions Android** : examiner le manifeste fusionné après US-58, décider du besoin de localisation en arrière-plan, exact alarms et caméra; documenter la justification Play.
4. **M — Vérifier et aligner confidentialité/Play/Auto Backup** : obtenir la politique publique et Data safety, inspecter les règles de backup Android, publier une information cohérente sur données, sauvegarde, rétention et suppression.
5. **S — Renforcer la chaîne CI** : épingler les actions par SHA, limiter les permissions par job et protéger la publication.
6. **M/L — Décider du chiffrement côté client des sauvegardes** : cadrer récupération des clés et migration avant chiffrage; estimation à confirmer avec le produit.

Les estimations sont indicatives et devront être affinées avec la vérification des déclarations Play, des manifestes fusionnés et de la politique actuelle. Cet audit est une revue statique et ne constitue pas une certification de sécurité.
