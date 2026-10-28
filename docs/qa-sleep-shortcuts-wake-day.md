# Raccourcis sommeil — rattachement au jour du réveil

Correctif du 28 octobre 2026.

## Règle retenue

- Coucher le 28 à 22 h : fiche du 29, heure réelle du coucher conservée au 28.
- Coucher le 29 à 1 h : fiche du 29.
- La bascule des raccourcis est à midi, en heure locale. Les dates sont
  construites par calendrier, sans ajouter une durée fixe de 24 heures.
- Lever le 29 : complète la fiche du 29 et ouvre le formulaire sur cette date.
- Les actions répétées gardent les premières heures enregistrées ; les
  transactions empêchent deux actions simultanées de créer des doublons.
- Le formulaire manuel et l'export PDF suivent la même convention. L'export
  privilégie la date canonique et ne duplique pas une nuit le jour du coucher.

## Données existantes

Aucun déplacement global des anciennes nuits : les fiches historiques peuvent
avoir été saisies selon des conventions différentes et la colonne `source`
ne permet pas de distinguer les raccourcis des saisies manuelles.

Au lever, une ancienne nuit encore ouverte peut être déplacée au jour du réveil
si son coucher date de moins de 24 heures, que sa clé correspond au jour du
coucher et que la destination est libre, y compris parmi les fiches supprimées.
Son identifiant, ses heures, sa qualité, sa note et sa date de création sont
préservés. Une destination occupée est prioritaire et n'est jamais remplacée.
Les autres clés stockées restent inchangées, notamment pour les voyages.

Le formulaire reçoit les nouvelles heures du flux sans remplacer les champs
déjà modifiés par l'utilisateur. Un raccourci réinitialise le contrôleur avant
la navigation pour éviter de reprendre un ancien brouillon.

## Validation

- Flutter **3.47.8**, Dart **3.13.7**.
- Génération avec `build_runner` réussie. L'option historique
  `--delete-conflicting-outputs` est désormais ignorée par cette version.
- Tests ciblés sommeil et export : **50 réussites**.
- `flutter analyze --no-pub` : aucun problème.
- Suite complète `flutter test --no-pub --reporter failures-only` :
  **379 réussites**. Les tests existants émettent des avertissements Drift et
  de polices PDF, sans échec.
- Syntaxe du hook Git vérifiée avec Bash ; `git diff --check` sans erreur.
- Pas de validation sur appareil ni de compilation APK pour ce correctif.

Les régressions couvrent deux nuits consécutives, le coucher après minuit,
la limite de midi, le changement d'année, les changements d'heure, les doubles
clics et actions simultanées, le réveil seul, les anciennes nuits ouvertes,
les destinations occupées ou supprimées, et l'affichage du réveil dans le
formulaire avec un fournisseur déjà en cache.

## Commande locale Windows

Le PATH système pointe encore vers Flutter 3.44.1 et sa modification exige
des droits administrateur. Le wrapper local sélectionne le SDK installé
correspondant aux deux workflows CI sans modifier Windows ni télécharger
de fichiers :

```powershell
rtk powershell -NoProfile -ExecutionPolicy Bypass -File tool/flutter.ps1 --version
rtk powershell -NoProfile -ExecutionPolicy Bypass -File tool/flutter.ps1 -Dart run build_runner build
rtk powershell -NoProfile -ExecutionPolicy Bypass -File tool/flutter.ps1 analyze --no-pub
rtk powershell -NoProfile -ExecutionPolicy Bypass -File tool/flutter.ps1 test --no-pub --reporter failures-only
```

`-ExecutionPolicy Bypass` concerne uniquement le processus lancé. Le wrapper
met Flutter et son Dart sur le PATH de ses sous-processus. Le hook Windows
utilise ce même wrapper. Dans Codex, les commandes Flutter demandent également
l'accès au cache SDK hors du bac à sable ; sans cet accès, le lanceur batch
peut boucler silencieusement sur son verrou de cache.
