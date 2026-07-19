# 🍽️ assiette

> **Food · symptoms · environment. Connect the dots.**

[![Android debug APK](https://github.com/Gon3s/assiette/actions/workflows/android-debug-apk.yml/badge.svg)](https://github.com/Gon3s/assiette/actions/workflows/android-debug-apk.yml)

**assiette** est un journal Android **100 % local** qui croise ce que vous mangez,
ce que vous ressentez (migraines, troubles digestifs, humeur) et votre
environnement (sommeil, pression atmosphérique, météo) pour vous aider à
identifier vos déclencheurs probables.

## 🔒 Vie privée d'abord

- **Aucun compte, aucun backend, aucun tracking.** Toutes les données restent
  dans une base SQLite sur votre appareil.
- Les photos de repas sont stockées dans le répertoire interne de l'app.
- La seule requête réseau effectuée est l'appel météo en tâche de fond à
  [Open-Meteo](https://open-meteo.com/) (sans clé API, données CC BY 4.0).

## ✨ Fonctionnalités

### Disponibles

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
- **Saisie de repas en quelques secondes** : photo (optionnelle) avec
  suggestions de tags par analyse d'image on-device (ML Kit, aucun réseau,
  jamais appliquées automatiquement), type pré-sélectionné selon l'heure,
  tags (25 déclencheurs classiques pré-remplis + création à la volée), note,
  horodatage éditable, enregistrement en favori.
- **Repas favoris** : liste dédiée (créer, éditer, supprimer), relog en 1 tap.
- **Saisie de symptômes** (migraine, digestif, humeur, douleur) en deux
  taps : intensité 0-10, détail contextuel, heure de fin optionnelle.
- **Prises de traitement de crise** : nom libre (autocomplétion depuis
  l'historique), dose optionnelle, horodatage propre, rattachable ou non à un
  symptôme.
- **Sommeil 1-tap** : qualité (mauvais / moyen / bon), heures de coucher/réveil
  éditables.
- **Capture automatique météo/pression en tâche de fond** : position
  approximative, appel [Open-Meteo](https://open-meteo.com/) toutes les
  heures, rattrapage des jours manqués au démarrage, delta de pression
  calculé, dégradation silencieuse sans réseau ni permission localisation.
- **Rappels et alertes** : notifications actionnables pour repas/sommeil
  (réponse directe depuis la notification), check-in symptôme, alerte
  proactive en cas de chute de pression (>6hPa/24h) ; réglages par canal
  (activer/désactiver, horaires) dans un écran dédié.
- **Export PDF pour votre médecin** : sélection d'une plage de dates,
  génération d'un PDF par jour (repas + tags, symptômes + intensité,
  traitements, sommeil, pression), prévisualisation et partage.
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
| Modèles | [Freezed 3](https://pub.dev/packages/freezed) |
| Tâches de fond | [workmanager](https://pub.dev/packages/workmanager) |
| Notifications | [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) |
| Graphiques | [fl_chart](https://pub.dev/packages/fl_chart) |
| Export PDF | [pdf](https://pub.dev/packages/pdf) + [printing](https://pub.dev/packages/printing) + [share_plus](https://pub.dev/packages/share_plus) |
| Tags photo | [google_mlkit_image_labeling](https://pub.dev/packages/google_mlkit_image_labeling) (on-device) |
| Typographie | [google_fonts](https://pub.dev/packages/google_fonts) (Rubik) |
| Lints | [very_good_analysis](https://pub.dev/packages/very_good_analysis) |

### Architecture

Feature-first, en trois couches par fonctionnalité :

```
lib/
├── data/                  # Drift : tables, DAOs, seed des tags système
├── features/<feature>/
│   ├── domain/            # modèles + contrats de repository
│   ├── data/              # implémentations (Drift, image_picker…)
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

- [Flutter](https://docs.flutter.dev/get-started/install) stable ≥ 3.44
  (Dart ≥ 3.10)
- Un appareil ou émulateur Android (API 24+)

### Installation

```bash
git clone https://github.com/Gon3s/assiette.git
cd assiette
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # code généré
flutter run -t lib/main_dev.dart                            # flavor dev
```

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

## 🤝 Contribuer

Le projet suit un backlog d'user stories. Avant tout commit :

1. `dart run build_runner build --delete-conflicting-outputs` (si fichiers
   annotés modifiés)
2. `flutter analyze --no-pub` — zéro erreur/warning
3. `flutter test` — tout doit passer

Format des commits : `type(scope): message` (anglais, impératif, ≤ 72
caractères) — ex. `feat(feature/day_view): add day navigation`.

Les conventions détaillées du projet sont dans [CLAUDE.md](CLAUDE.md).
