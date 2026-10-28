# Suivi des règles : première version

Implémentation du 28 octobre 2026, correspondant aux lots REG-1 à REG-3 de
`menstrual-tracking-plan.md`. Aucun numéro de US Notion n’a été attribué.

## Utilisation

1. Réglages → Suivi des règles → activer le suivi.
2. Dans une journée actuelle ou passée, choisir Ajouter → Règles, ou toucher
   la carte Règles.
3. Choisir aucun saignement, spotting ou règles ; renseigner éventuellement
   le flux, le premier jour déclaré et une note.
4. Modifier ou supprimer depuis la même carte. Une suppression rend la journée
   non renseignée. Aucune observation n’est étendue aux journées voisines.

Les options d’inclusion Drive et PDF sont indépendantes du suivi et désactivées
par défaut. Les écrans concernés rappellent le choix avant l’action. La purge
dédiée efface les observations locales et désactive les trois options après
confirmation, sans toucher au reste du journal. Les copies déjà sauvegardées
ou partagées subsistent.

## Données et compatibilité

- Schéma Drift v14 : table `menstrual_days` et trois options `app_settings`.
- Date civile stable `YYYY-MM-DD` ; les timestamps de création/modification
  servent uniquement à l’audit technique.
- Contrainte d’unicité par journée et contraintes SQLite sur les états,
  le flux et le marqueur de début ; validation calendaire dans le repository
  et lors de l’import.
- Format de sauvegarde v6, avec liste d’observations vide si l’inclusion
  est désactivée. Les sauvegardes v1–v5 restent importables et remplacent aussi
  les éventuelles observations locales, avec les nouvelles options à faux.
- Export PDF à la journée, sans heure inventée, avec suppression des lignes
  masquées et maintien des jours ne contenant que cette nouvelle donnée.
- Invalidation du PDF lors d’un changement de préférence d’inclusion, y compris
  si une génération précédente est encore en cours.
- Itération par dates civiles dans l’export pour respecter les changements
  d’heure ; aucune prévision de cycle ou association statistique ajoutée.

## Couverture de validation

Les nouveaux tests portent sur l’opt-in, les dates et états invalides,
l’unicité/concurrence, les trous de saisie, le spotting, le flux inconnu,
la suppression/réactivation, la désactivation et la purge isolée.

Ils couvrent également l’import de chacun des cinq anciens formats, le
round-trip inclus/exclus, le rejet d’archives invalides sans modification
locale, le PDF d’une journée ne contenant que du spotting, les erreurs du
controller, la confirmation des suppressions, les dates futures et le
formulaire français avec texte agrandi. Les tests de migration existants
restent exécutés jusqu’au schéma v14, avec un scénario spécifique depuis v13.

Les validations utilisent le wrapper du dépôt et Flutter 3.47.8 / Dart 3.13.7.
Résultats finaux :

- Génération `build_runner` réussie.
- `flutter analyze --no-pub` : aucun problème.
- `flutter test --reporter failures-only` : **406 tests réussis**.
- Contrôle d’espacement des sources hors fichiers générés : aucune erreur.
  Freezed produit deux lignes avec des espaces finaux ; elles sont conservées
  conformément à la règle interdisant l’édition manuelle des fichiers générés.

Les tests produisent encore les messages diagnostiques existants sur les
instances Drift multiples et les polices PDF Helvetica ; ils ne provoquent
aucun échec. Aucun contournement SQLite ni changement du `pubspec.yaml`
n’a été nécessaire sur cet environnement Windows.

## Avant diffusion

La politique source et l’inventaire de données ont été actualisés dans le dépôt.
La publication de cette politique et la vérification de la déclaration Play
relative aux données menstruelles restent des opérations de mise en production.
Les essais ici sont automatisés ; une vérification sur appareil Android reste
à réaliser avant diffusion.
