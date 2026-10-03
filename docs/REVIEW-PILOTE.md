# Pilote de review manuelle

Cette fiche sert de petit changement de référence pour préparer le pilote J0.
Elle décrit une review documentaire ; aucun défaut n'est injecté
volontairement.

## Préparer le contexte

- Relever le numéro de PR, le SHA de base et le SHA de tête.
- Lire le diff correspondant dans un checkout jetable.
- Charger `AGENTS.md` depuis la référence de confiance, puis relever son SHA.
- Utiliser uniquement des données synthétiques, sans base ni sauvegarde
  personnelle.

## Contrôles du projet

La CI épingle Flutter 3.44.5. Dans l'environnement isolé de préparation :

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze --no-pub
flutter test
```

Ces commandes servent au contrôle préalable J0. La review de diff J1
n'exécute pas automatiquement les scripts du dépôt.

## Rapport attendu

Indiquer les SHA analysés, le résumé, les observations justifiées et leurs
fichiers ou lignes, les contrôles réellement exécutés et les limites
rencontrées. Un rapport sans observation est acceptable ; il ne garantit pas
l'absence de bug.

Conserver le rapport localement. La publication, le merge et le déploiement
restent des actions distinctes nécessitant une demande explicite.
