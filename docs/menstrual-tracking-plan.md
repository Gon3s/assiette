# Plan d’ajout du suivi des règles

Date : 28 octobre 2026. Statut : lots REG-1 à REG-3 implémentés et validés
automatiquement (analyse propre, 406 tests réussis). Voir `qa-menstrual-tracking.md`.
Les identifiants ci-dessous sont locaux à ce document,
pas des numéros de US Notion attribués.

## Objectif et recommandation

Permettre de noter les règles dans le journal et de les consulter à côté des
migraines, ressentis et médicaments. Une première version collecte les faits
observés ; une étape ultérieure étudiera leurs associations avec les migraines.

Créer une feature `menstrual_tracking` indépendante. Ajouter simplement un
type à `SymptomType` ne suffirait pas : le flux, l’absence explicite de
saignement et les débuts de règles ont leurs propres règles de validation.
Le suivi reste facultatif, désactivé par défaut, sans question sur le sexe ou
l’identité de genre dans le profil.

## État des lieux vérifié

| Élément | Constat et conséquence |
| --- | --- |
| `lib/data/db/app_database.dart` | Schéma Drift v13. Prévoir la prochaine migration disponible, v14 si aucune autre évolution ne la précède. |
| `lib/data/db/enums/symptom_type.dart` | Migraine, digestif, humeur, douleur, eczéma ; aucun type menstruel. Ne pas modifier l’ordre des valeurs persistées. |
| `lib/features/day_view/presentation/day_view_screen.dart` | Le menu « Ajouter » propose migraine, ressenti, humeur et médicament. Les notes quotidiennes disposent de cartes distinctes de la chronologie horaire. |
| `lib/features/day_view/presentation/day_view_providers.dart` | Providers réactifs par date, adaptés à une carte quotidienne supplémentaire. |
| `lib/features/settings/presentation/settings_screen.dart` | Point d’entrée pour l’activation du suivi. |
| `lib/features/pdf_export/domain/day_journal_entry.dart` | Agrégat journalier à étendre, y compris `hasData` pour un jour contenant uniquement une observation menstruelle. |
| `lib/features/cloud_backup/data/database_snapshot_codec.dart` | Format actuel v5, liste explicite de tables et restauration par remplacement transactionnel. Une nouvelle table exige une évolution du format et des validations. |
| `docs/architecture/analytics_case_control_v1.md` | Le modèle accepté couvre repas, sommeil et pression ; le cycle est hors de ses facteurs actuels. La couverture manuelle dépend de US-33. |
| `docs/privacy-data-inventory-US-68.md` | Sauvegarde Drive explicite, sans chiffrement applicatif ; pas de purge globale dans l’app. Ne pas promettre d’effacement des copies distantes. |

La page Notion US-54 « Refondre la saisie des symptômes et ressentis
quotidiens », marquée terminée, confirme la séparation entre événements
horodatés et données à la journée. Les recherches ciblées dans Notion n’ont
pas identifié de US dédiée au suivi menstruel ; cela ne garantit pas son
absence dans tout le backlog.

Source : https://app.notion.com/p/3d0b6460010081efb5fcdd31da230aca

Les deux workflows Android pinent Flutter 3.47.8. Le wrapper `tool/flutter.ps1`
sélectionne cette installation ; version confirmée avec Dart 3.13.7 au début
de l’implémentation. Le SDK du PATH reste plus ancien et n’est pas utilisé
pour les validations de cette version.

## Périmètre de la première version

- Réglage « Suivi des règles », désactivé par défaut.
- Menu « Ajouter → Règles » après activation ; première activation depuis
  les réglages, avec explication courte de l’usage et des destinations.
- Formulaire prérempli sur la journée affichée, y compris lors d’une saisie
  rétrospective : aucune heure à renseigner.
- Observation quotidienne : « Aucun saignement », « Spotting / petites
  pertes », ou « Règles ».
- Pour « Règles », flux facultatif : faible, moyen ou abondant. Aucun choix
  précoché ; un flux non renseigné ne devient pas automatiquement faible.
- Case facultative « Premier jour des règles », déclarée par la personne.
- Note libre facultative. Les douleurs et médicaments continuent à utiliser
  leurs saisies existantes ; ne pas créer de doublons automatiquement.
- Une observation par date, modifiable et supprimable ; supprimer une
  observation rétablit l’état inconnu de cette date.
- Carte « Règles » à la journée, hors de la chronologie horaire, avec statut,
  flux éventuel, marqueur de début et accès à la modification.
- Consultation des journées passées via la navigation existante.
- Sauvegarde/restauration et export PDF compatibles dès la livraison.

La première version n’inclut ni calendrier mensuel spécialisé, ni prévision
des prochaines règles, ni ovulation/fertilité, ni diagnostic, ni traitement,
ni rappel automatique, ni suivi de contraception ou de grossesse. Elle reste
utilisable avec des cycles irréguliers sans imposer une durée standard.

## Règles métier proposées

1. Une journée sans observation est **inconnue**. Seul un enregistrement
   explicite « Aucun saignement » constate une absence pour cette date.
2. Spotting et règles sont distincts. Le spotting seul ne démarre pas un
   cycle et ne devient jamais automatiquement un jour de règles.
3. Un début est uniquement un marqueur déclaré. Ne pas le déduire d’un trou
   de saisie, d’un changement de mois ou d’une durée supposée normale.
4. Le marqueur de début et le flux sont autorisés seulement avec « Règles ».
   Changer d’état doit expliquer puis retirer les valeurs incompatibles.
5. Aucun intervalle n’est rempli automatiquement. Noter le 5 puis le 7 ne
   renseigne pas le 6. Aucune propagation de « règles en cours » sur les jours
   suivants en première version.
6. Autoriser les dates passées et la date actuelle, refuser les dates futures
   pour les observations. Ne pas imposer de limite médicale de durée.
7. Modifier ou supprimer un marqueur de début met à jour toute donnée dérivée.
   Aucun lien vers une migraine n’est enregistré en dur.
8. Une désactivation masque le module et suspend ses usages, sans effacer
   implicitement l’historique. La réactivation retrouve les observations.
9. Les jours historiques restent attachés à leur date de saisie même après
   voyage ou changement de fuseau.

## Modèle de données et architecture

Table proposée : `MenstrualDays`, avec DAO `MenstrualDaysDao`.

| Champ | Règle |
| --- | --- |
| `localDate` | Date civile `YYYY-MM-DD`, clé primaire ; validation calendaire stricte. |
| `bleedingStatus` | Code stable `none`, `spotting`, `period` ; pas d’index d’enum dépendant de son ordre. |
| `flow` | Code stable nullable `light`, `medium`, `heavy` ; autorisé seulement avec `period`. |
| `isPeriodStart` | Booléen faux par défaut ; vrai seulement avec `period`. |
| `note` | Texte nullable, borné selon les conventions de saisie du projet. |
| `createdAt`, `updatedAt` | Instants techniques UTC ; jamais interprétés comme heure des règles. |
| `deletedAt` | Suppression logique pour une observation, filtrée des vues et exports usuels. |

Une sauvegarde après suppression logique peut encore contenir la ligne :
ce mécanisme doit être distingué de l’effacement définitif décrit plus bas.
Un nouvel enregistrement sur une date supprimée réactive la même clé par
upsert transactionnel. L’unicité est garantie par SQLite, pas uniquement par
le formulaire. Aucun tableau de cycles calculés n’est nécessaire en V1.

Ajouter à `AppSettings` trois booléens, tous faux par défaut : activation du
suivi, inclusion dans les sauvegardes et inclusion dans les PDF. Les options
d’inclusion sont indépendantes de l’affichage du module.

Organisation cible :

- `lib/data/db/tables/menstrual_days_table.dart` et
  `lib/data/daos/menstrual_days_dao.dart` ; enregistrement dans `AppDatabase`.
- `lib/features/menstrual_tracking/domain/` : observation/draft Freezed,
  états de saignement/flux, date civile et contrat de repository.
- `lib/features/menstrual_tracking/data/` : repository Drift ; lecture par
  date/plage, upsert, suppression logique et purge dédiée.
- `lib/features/menstrual_tracking/presentation/` : formulaire, controller
  Riverpod, carte quotidienne et réglages. La carte peut consommer son propre
  provider sans transformer les observations en `TimelineItem`.
- Route dans `lib/routing/app_router.dart`, libellés dans les trois fichiers
  `AppStrings` FR/EN. Aucun accès Drift direct depuis les widgets.

Vérifier les contraintes à la saisie, au repository et lors d’une restauration.
Générer les fichiers Drift/Riverpod/Freezed ; ne jamais les écrire à la main.

## Sauvegarde, export et confidentialité

- Inclure ces observations dans Drive et les PDF uniquement après choix
  explicite. Afficher un résumé de ce choix avant sauvegarde/partage.
- Prochain format du snapshot : v6 si v5 reste la dernière version. Il
  contient une liste `menstrualDays`, vide si l’inclusion est désactivée.
  Ne pas réutiliser la version de schéma Drift comme version du ZIP.
- Restaurer v1–v5 avec une liste vide et les nouveaux réglages à faux.
  Respecter le remplacement actuel : aucune observation locale résiduelle
  après restauration d’une sauvegarde ancienne ou excluant ces données.
- Valider clés, dates, codes, unicité et cohérence flux/début avant toute
  modification de la base réelle ; une archive invalide laisse la base intacte.
- Tester le round-trip avec et sans inclusion. Une ancienne version de l’app
  refusera normalement le nouveau format : ne pas promettre la compatibilité
  descendante, seulement l’import des anciennes sauvegardes par la nouvelle app.
- PDF : section quotidienne dédiée, sans heure, avec inclusion contrôlée ;
  ne pas afficher un faux « aucun saignement » pour les jours inconnus.
- Prévoir « Effacer définitivement les données de règles » avec confirmation
  du périmètre : purge locale, remise à faux des trois réglages, aucune
  suppression des migraines ou autres données du journal.
- Expliquer que les anciens PDF et archives Drive subsistent et qu’une
  restauration peut réintroduire les données. Une suppression distante
  sélective ne fait pas partie de cette première version.
- Actualiser l’inventaire, la politique de confidentialité et vérifier les
  déclarations Play avant publication. Aucun nouveau service ou droit Android
  n’est nécessaire ; ne pas envoyer le contenu dans les logs ou la télémétrie.

## Analyse des associations : lot ultérieur séparé

La présence d’un marqueur dans le journal fournit une lecture croisée avec
les migraines, sans établir une association statistique ou une causalité.

Avant toute statistique, définir un contrat de couverture journalière compatible
avec US-33 et distinguer absence déclarée, observation positive et jour inconnu.
Les jours supprimés ou le suivi désactivé ne valent pas absence de règles.

Prévoir une spécification séparée pour les fenêtres autour d’un début déclaré,
la date locale de survenue d’une migraine, les débuts migraine inconnus, les
témoins, les données manquantes et les seuils d’affichage. Certaines fenêtres
utilisent un début de règles postérieur à la migraine : il s’agit alors d’une
classification rétrospective, pas d’une exposition précédant la crise.

Le contrat `case_control_v1.0.0` ne peut donc pas être étendu silencieusement.
Versionner toute évolution et faire valider les éventuelles conventions
médicales avant leur introduction. N’afficher ni diagnostic de migraine
menstruelle ni conseil contraceptif à partir de ces seules observations.

## Découpage proposé

| Lot | Livraison et critères d’acceptation | Dépendances | Taille |
| --- | --- | --- | --- |
| REG-1 | Socle complet : modèle, repository, DAO, migration, réglages et snapshot. Une base existante conserve toutes ses données ; les sauvegardes v1–v5 sont importables ; les valeurs invalides sont refusées sans modification locale. | Validation du cadrage | L |
| REG-2 | Activation et parcours quotidien FR/EN : Ajouter → Règles, carte, édition, suppression, date de la journée sélectionnée et purge dédiée. Pas de carte avant activation, pas d’heure fictive, pas de doublon par date. | REG-1 | L |
| REG-3 | Export PDF contrôlé, information Drive, confidentialité et QA transversale. Une journée ne contenant que des règles s’exporte si l’option est active ; rien de menstruel n’apparaît si elle est inactive. | REG-1, REG-2 | M |
| REG-4 | Historique mensuel et résumés descriptifs éventuels ; définir explicitement couverture et débuts avant tout calcul de durée de règles ou de cycle. | Première version livrée et retours d’usage | À cadrer |
| REG-5 | Spécification puis analyse des associations migraines/règles, avec version d’algorithme et preuves visibles. | US-33 et socle analytique pertinent, REG-1, cadrage spécifique | À cadrer |

REG-1 à REG-3 constituent une seule première version publiable. Ne pas livrer
la saisie avant sa sauvegarde/restauration et ses choix de confidentialité.
Les tailles sont relatives, pas des engagements de délai. Attribuer les vrais
numéros de US lors de la création éventuelle dans Notion, après recherche des
doublons et confirmation des dépendances analytiques.

## Validation prévue pour l’implémentation

- Métier/DAO : les trois états, flux inconnu, début explicite, incohérences,
  upsert concurrent, suppression/réactivation et purge isolée.
- Dates : mois/année bissextile, changement d’heure, voyage, journée passée
  sélectionnée, refus d’une observation future ; aucun déplacement de date.
- Migration : création neuve, v13 et anciens chemins déjà couverts ; aucune
  observation ni activation inventée à partir des anciennes douleurs/humeurs.
- Sauvegarde : anciens formats, v6 inclus/exclus, archives invalides, dates
  dupliquées, transactions annulées, absence de résidu après remplacement.
- Widgets : module masqué, activation, saisie minimale, modification, erreurs,
  suppression et purge, FR/EN, accessibilité et texte agrandi.
- PDF : journée avec cette seule donnée, absence d’heure, exclusion choisie,
  distinction spotting/règles et non-divulgation des lignes supprimées.
- Régression : migraines, ressentis, sommeil, médicaments et restauration.
- Gate avec le SDK CI : génération, `flutter analyze --no-pub`, `flutter test`.
  Mettre ensuite à jour les US réellement livrées avec le hash du commit.

## Arbitrages restant ouverts

Le plan retient comme hypothèses un suivi quotidien, le flux facultatif,
l’absence de prévisions et l’exclusion par défaut des sauvegardes/PDF.
Ces choix ont été autorisés pour la première version. Une saisie par début/fin
d’épisode ou par plage de dates nécessiterait
un contrat différent pour ne pas fabriquer les jours intermédiaires.
