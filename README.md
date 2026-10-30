# 🍽️ assiette

> **Food · symptoms · environment. Connect the dots.**

[![Android debug APK](https://github.com/Gon3s/assiette/actions/workflows/android-debug-apk.yml/badge.svg)](https://github.com/Gon3s/assiette/actions/workflows/android-debug-apk.yml)

**assiette** est un journal Android pour noter vos repas, migraines, ressentis,
prises de médicaments et nuits de sommeil, avec le contexte météo de vos
journées. Le journal fonctionne sans compte et conserve ses données sur votre
appareil. La sauvegarde Google Drive est facultative.

## Accéder à l'application

- [Présentation d'Assiette](https://gon3s.github.io/assiette/)
- [Application sur Google Play](https://play.google.com/store/apps/details?id=com.gones.assiette)
  — actuellement en alpha, accessible aux testeurs inscrits.
- [Politique de confidentialité](https://gon3s.github.io/assiette/privacy.html)
- [Dernier APK de développement](https://github.com/Gon3s/assiette/releases/download/dev-latest/app-debug.apk)

La connexion Google est opérationnelle sur l'alpha. La configuration OAuth est
en production depuis le 28 octobre 2026 : il n'est plus nécessaire d'ajouter
chaque compte dans la liste des utilisateurs tests Google. L'inscription aux
tests du Play Store reste nécessaire pour accéder à l'alpha.

## 🔒 Vie privée d'abord

- **Utilisable sans compte.** Les données sont enregistrées dans une base
  SQLite sur votre appareil. La sauvegarde/restauration Google Drive est
  facultative et nécessite une connexion Google.
- **Accès Drive limité au dossier applicatif d'Assiette** (`drive.appdata`),
  sans accès général à vos documents. Une sauvegarde remplace la précédente ;
  une restauration remplace le journal local. L'archive peut contenir des
  données de santé et n'est pas chiffrée de bout en bout par l'application.
- La capture photo est retirée ; les anciennes photos restent conservées et
  visibles dans l'historique et les favoris.
- La météo et la qualité de l'air sont obtenues auprès
  d'[Open-Meteo](https://open-meteo.com/) pour le lieu enregistré.
- La position approximative est lue uniquement quand l'app est visible.
  Voir la [justification des permissions Android](docs/android-permissions-US-67.md).

## ✨ Fonctionnalités

### Implémentées sur `main`

La disponibilité sur Google Play dépend de la version distribuée aux testeurs.

- **Onboarding** : présentation en 4 pages, demande de permission
  localisation contextualisée au lien pression/migraine, jamais réaffiché une
  fois complété.
- **Vue journée** : timeline chronologique des repas, symptômes et prises de
  traitement de crise, navigation entre jours (swipe, sélecteur de date,
  raccourci "aujourd'hui"), édition/suppression (soft delete + annuler) en
  tapant une entrée, en-tête météo/pression avec nom du lieu, icône de
  condition, tuiles météo (température, pression, UV, PM2.5/PM10, pollen)
  ouvrant un graphique d'évolution sur 48h (prévision de pression incluse),
  carte sommeil, mise à jour réactive en temps réel.
- **Saisie manuelle de repas en quelques secondes** : type pré-sélectionné selon l'heure,
  tags alimentaires créés par l'utilisateur au fil des saisies, sans liste
  préremplie sur une nouvelle installation, note,
  horodatage éditable, enregistrement en favori.
- **Repas favoris** : liste dédiée (créer, éditer, supprimer), relog en 1 tap.
- **Suivi des migraines** : début exact, approximatif ou inconnu, fin
  optionnelle, intensité maximale, observations pendant la crise et notes.
  Une migraine en cours peut être terminée depuis le journal.
- **Ressenti physique et humeur** : saisies quotidiennes sans horaire,
  catégories pour le ressenti physique et note libre pour l'humeur.
- **Prises de traitement de crise** : nom libre (autocomplétion depuis
  l'historique), horodatage et association facultative à la migraine en cours.
  Le formulaire de nouvelle prise ne demande plus de dose ; les anciennes
  doses restent conservées.
- **Historique et statistiques des migraines** : périodes de 30 jours,
  90 jours ou un an, fréquence, jours avec migraine, durée moyenne, intensité
  maximale moyenne et suivi des prises de médicaments.
- **Sommeil** : qualité (mauvais / moyen / bon), note et heures de
  coucher/réveil éditables. Raccourcis Android pour enregistrer le coucher et
  le réveil ; la nuit est rattachée au jour du réveil.
- **Gestion des tags** : recherche, filtres, renommage et fusion avec aperçu
  des conséquences sur les entrées existantes.
- **Capture automatique météo/pression en tâche de fond** : météo du dernier
  lieu enregistré, appel [Open-Meteo](https://open-meteo.com/) environ toutes les
  trois heures, position actualisée au premier plan, rattrapage des jours manqués au démarrage, delta de pression
  calculé, dégradation silencieuse sans réseau ni permission localisation.
- **Rappels et alertes** : notifications actionnables pour repas/sommeil
  (réponse directe depuis la notification), check-in symptôme, alerte
  proactive en cas de chute de pression (>6hPa/24h) ; réglages par canal
  (activer/désactiver, horaires) dans un écran dédié. Les rappels utilisent des
  alarmes inexactes et peuvent être retardés par Android.
- **Export PDF pour votre médecin** : sélection d'une plage de dates,
  génération d'un document regroupant les journées (repas, tags, migraines,
  ressentis, traitements, sommeil et météo), prévisualisation et partage.
- **Sauvegarde et restauration Google Drive** : journal et anciennes photos
  conservés dans une archive du dossier applicatif privé, avec affichage de
  la dernière sauvegarde et proposition de restauration au démarrage.
- **Suivi menstruel facultatif** : observations quotidiennes, activation dans
  les réglages et choix distincts pour l'inclusion dans les sauvegardes Drive
  et les exports PDF.
- **Thème sombre** dédié (palette, typographie Rubik, cartes arrondies).

### En cours de développement

- Insights locaux (corrélations facteurs ↔ symptômes)

> ⚠️ assiette est un outil de suivi personnel, pas un dispositif médical.
> Les corrélations observées ne sont pas des relations de cause à effet —
> parlez-en à un professionnel de santé.

## 🛠️ Stack technique

| Domaine | Choix |
|---|---|
| Framework | Flutter (Material 3), Android `minSdk 24` |
| État | [Riverpod 3](https://riverpod.dev/) avec génération de code |
| Base locale | [Drift](https://drift.simonbinder.eu/) (SQLite réactif) |
| Navigation | [GoRouter](https://pub.dev/packages/go_router) |
| Modèles | [Freezed](https://pub.dev/packages/freezed) + `json_serializable` |
| Tâches de fond | [workmanager](https://pub.dev/packages/workmanager) |
| Notifications | [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) |
| Graphiques | [fl_chart](https://pub.dev/packages/fl_chart) |
| Export PDF | [pdf](https://pub.dev/packages/pdf) + [printing](https://pub.dev/packages/printing) + [share_plus](https://pub.dev/packages/share_plus) |
| Sauvegarde cloud | [google_sign_in](https://pub.dev/packages/google_sign_in) + [googleapis](https://pub.dev/packages/googleapis) (Drive) |
| Typographie | [google_fonts](https://pub.dev/packages/google_fonts) (Rubik) |
| Lints | [very_good_analysis](https://pub.dev/packages/very_good_analysis) |

### Architecture

Feature-first, en trois couches par fonctionnalité :

```
lib/
├── data/                  # Drift : tables, DAOs et migrations
├── features/<feature>/
│   ├── domain/            # modèles + contrats de repository
│   ├── data/              # implémentations (Drift, clients HTTP…)
│   └── presentation/      # écrans + contrôleurs Riverpod
├── localization/          # AppStrings FR/EN (aucune string UI en dur)
├── routing/               # GoRouter + démarrage de l'app
└── common_widgets/        # widgets partagés
```

L'UI ne parle jamais directement à la base : elle passe par un contrat de
repository (`domain`) implémenté côté `data`, exposé via un provider Riverpod.
Les listes sont branchées sur les streams Drift (`.watch()`) — tout se met à
jour tout seul.

## 🚀 Démarrer

### Prérequis

- [Flutter](https://docs.flutter.dev/get-started/install) 3.47.8
  (Dart 3.13.7 embarqué, même version que la CI)
- Un appareil ou émulateur Android (API 24+)

Sur Windows, si le `PATH` pointe vers un autre SDK, le wrapper
`tool/flutter.ps1` sélectionne Flutter 3.47.8 sans changer le `PATH` système :

```powershell
rtk powershell -NoProfile -ExecutionPolicy Bypass -File tool/flutter.ps1 --version
```

### Installation

```bash
git clone https://github.com/Gon3s/assiette.git
cd assiette
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # code généré
flutter run -t lib/main_dev.dart                            # flavor dev
```

Pour tester aussi la sauvegarde Google Drive, fournir l'identifiant OAuth de
type **Application Web** du projet Google Cloud :

```bash
flutter run -t lib/main_dev.dart --dart-define=GOOGLE_SERVER_CLIENT_ID=VOTRE_CLIENT_ID_WEB
```

Sans ce paramètre, le journal local reste utilisable, mais les opérations de
connexion Google échouent. Le projet Google Cloud doit activer l'API Drive et
disposer des clients OAuth Android correspondant au nom de package et aux
empreintes SHA-1 des signatures utilisées. Pour une installation depuis le
Play Store, utiliser l'empreinte du certificat de signature d'application
fourni par Play App Signing.

Le statut OAuth est indépendant de la piste Play Store : en mode OAuth
**Test**, seuls les comptes déclarés comme utilisateurs tests peuvent donner
leur consentement. Le projet Assiette est désormais en **production** OAuth ;
chaque utilisateur doit toujours autoriser l'accès à son propre dossier Drive.

### Commandes utiles

```bash
flutter test                                               # tests
flutter analyze --no-pub                                   # lints
dart run build_runner watch --delete-conflicting-outputs   # codegen continu
flutter build apk --debug -t lib/main_dev.dart             # APK debug
```

> Les fichiers `*.g.dart` / `*.freezed.dart` sont générés : ne les modifiez
> jamais à la main, relancez `build_runner`.

## 📦 APK de debug via CI

Chaque push sur `main` déclenche le workflow
[Android debug APK](https://github.com/Gon3s/assiette/actions/workflows/android-debug-apk.yml)
(tests + build). L'APK (flavor dev) est publié sur une **release roulante**
mise à jour à chaque push — pratique pour tester sur téléphone sans
environnement Flutter local, pas de connexion GitHub requise :

**[⬇️ Télécharger le dernier APK](https://github.com/Gon3s/assiette/releases/download/dev-latest/app-debug.apk)**

Le workflow est aussi lançable à la main (*Run workflow*).

## Publication Play Store

Le workflow manuel [Android Play Store (internal testing)](https://github.com/Gon3s/assiette/actions/workflows/android-play-internal.yml)
publie un AAB signé sur la piste interne. Le champ facultatif `version_name`
choisit la version visible (par exemple `1.2.3`) ; vide, il reprend celle du
`pubspec.yaml`. Le numéro Android est calculé automatiquement depuis Play,
y compris lors d'une relance du workflow. La procédure et les prérequis sont
décrits dans [le guide de publication](docs/play-store-releases.md).

La piste interne alimentée par ce workflow et l'alpha accessible aux testeurs
sont gérées dans Play Console. Publier OAuth en production ne modifie pas la
piste de distribution Android et ne rend pas l'alpha publique.

La [checklist de publication](docs/play-store-checklist.md) conserve les
constats datés et les étapes à confirmer dans Play Console. Les
[captures françaises de la fiche](docs/play-store/README.md) sont versionnées
avec leur date et leur provenance.

## Site public GitHub Pages

Le site est publié depuis le dossier `docs/` de la branche `main` :

- `docs/index.html` : présentation de l'application et lien Google Play ;
- `docs/privacy.html` : politique de confidentialité.

Après fusion sur `main`, GitHub Pages déploie les pages à l'adresse
<https://gon3s.github.io/assiette/>. Cette adresse et celle de la politique de
confidentialité sont renseignées dans le branding Google Auth Platform, avec
le domaine autorisé `gon3s.github.io`.

## 🤝 Contribuer

Le projet suit un backlog d'user stories. Avant tout commit :

1. `dart run build_runner build --delete-conflicting-outputs` (si fichiers
   annotés modifiés)
2. `flutter analyze --no-pub` — zéro erreur/warning
3. `flutter test` — tout doit passer

Format des commits : `type(scope): message` (anglais, impératif, ≤ 72
caractères) — ex. `feat(feature/day_view): add day navigation`.

Les conventions détaillées du projet sont dans [AGENTS.md](AGENTS.md). Le
fichier [CLAUDE.md](CLAUDE.md) reste disponible pour les sessions Claude Code.

Les mises à jour des dépendances sont proposées chaque semaine par Dependabot.
Les règles de revue et de fusion automatique, ainsi que l'inventaire initial,
figurent dans la [procédure de maintenance](docs/dependency-maintenance-US-64.md).
