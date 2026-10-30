# Checklist de publication Google Play — Assiette

Dernière observation de Play Console : **27 octobre 2026**.
Documentation révisée le **30 octobre 2026**, sans nouvelle consultation de
Play Console. Les cases cochées conservent les constats du 27 octobre ; les
cases ouvertes sont des étapes dont l'achèvement reste à confirmer.
Application : `com.gones.assiette`.

## Actualisation du 30 octobre 2026

- La configuration OAuth est indiquée en production depuis le 28 octobre
  dans le [README](../README.md). Ce statut est distinct des pistes de test
  et de l'accès en production Google Play.
- Le suivi menstruel facultatif et la correction des raccourcis sommeil sont
  fusionnés sur `main` (PR #62 et #63). Leur présence dans la version Play
  distribuée reste à vérifier avant les tests de publication.
- Les quatre captures ci-dessous documentent l'interface du 27 octobre.
  Les comparer à la version retenue pour la prochaine publication.
- Relever dans Play Console la piste active, la version distribuée, l'état
  de l'examen, le nombre de testeurs inscrits et la date de début du test
  fermé avant de mettre à jour les sections suivantes.

## 1. Configuration initiale terminée

Les **11 tâches de configuration sont terminées** au 27 octobre 2026.
À cette date, la rubrique de configuration initiale avait disparu du tableau
de bord ; la fiche était « Prête à être envoyée pour examen » et « Contenu
de l'application » ne présentait plus de déclaration nécessitant une action.

- [x] **Informations de connexion** : répondre à la question sur les sections
  limitées et enregistrer la déclaration. Le journal fonctionne sans compte,
  mais la sauvegarde/restauration Google Drive nécessite Google Sign-In :
  préciser comment l'équipe Google peut examiner cette fonctionnalité et
  fournir les instructions ou accès requis. Instructions en anglais préparées ;
  rubrique désormais marquée terminée dans la Console après intervention utilisateur.
- [x] **Cible et contenu** : remplir le questionnaire après les informations
  de connexion (la Console impose cet ordre). Aligner les tranches d'âge sur
  la fiche actuelle qui annonce une application destinée aux 16 ans et plus.
  Tranches 16–17 ans et 18 ans et plus enregistrées.
- [x] **Sécurité des données** : compléter les cinq étapes du questionnaire
  puis enregistrer. Examiner les données de santé, les photos, les données
  de connexion Google et la localisation approximative, leurs destinations,
  leurs finalités, leur caractère facultatif, le chiffrement en transit et
  les possibilités de suppression. Distinguer les données conservées
  uniquement sur l'appareil des transmissions vers Drive et Open-Meteo,
  et appliquer les définitions/exceptions de Google aux flux réels.
  Utiliser [l'inventaire existant](privacy-data-inventory-US-68.md) comme base,
  en actualisant les constats avant déclaration. Déclaration vérifiée et
  enregistrée : e-mail, identifiant utilisateur, position approximative,
  données de santé, photos héritées et autre contenu utilisateur ; partage
  de position approximative ; collecte facultative, HTTPS et absence de
  procédure de demande de suppression déclarés selon le comportement actuel.
- [x] **Fiche Play Store** : ajouter au moins **2 captures d'écran téléphone**
  (jusqu'à 8), puis terminer les étapes « Éléments » et « Avis » et valider
  l'enregistrement. Quatre captures représentatives ont été retenues :
  saisie d'un repas, ressenti, migraine et export PDF.
  Format indiqué : PNG/JPEG, jusqu'à 8 Mo par image, ratio 16:9 ou 9:16,
  côtés entre 320 et 3 840 px. La Console recommande au moins 4 captures
  d'une résolution minimale de 1 080 × 1 080 px pour la promotion.

  Quatre captures françaises natives ont été produites et vérifiées en
  1080 × 1920 (PNG, moins de 100 Ko chacune), sans données personnelles :
  [repas](play-store/01-repas-fr.png),
  [ressenti](play-store/02-ressenti-fr.png),
  [migraine](play-store/03-migraine-fr.png),
  [export PDF](play-store/04-export-pdf-fr.png).
  L'utilisateur a importé les quatre fichiers ; leur présence, le format
  9:16 et les dimensions ont été vérifiés dans la Console. Les étapes
  « Éléments » et « Avis » ont été validées, et la fiche a été enregistrée.

- [x] **Identifiant publicitaire** : déclaration supplémentaire complétée
  avec « Non ». Aucun usage d'identifiant publicitaire ni SDK publicitaire
  trouvé dans les sources/dépendances ; aucune permission AD_ID dans les
  manifestes fusionnés debug et release examinés. La déclaration a été
  enregistrée et la liste « Attention requise » est désormais vide.

L'incohérence initiale entre le résumé de la fiche et l'éditeur sans captures
est résolue après import et enregistrement. La vidéo YouTube est facultative.

## 2. Publier et conduire le test fermé obligatoire

- [ ] Créer/configurer un canal de test fermé ; sélectionner les pays/régions
  et le groupe ou la liste de testeurs.
- [ ] Préparer la version à tester : promouvoir la release interne existante
  si elle convient, ou importer un nouvel AAB signé, puis ajouter les notes
  de version et résoudre les erreurs bloquantes signalées par la Console.
- [ ] Envoyer les modifications et la version pour examen, puis rendre le
  test fermé accessible après validation de Google.
- [ ] Recruter **au moins 12 testeurs inscrits au test fermé** (0 constaté
  le 27 octobre ; effectif actuel à relever dans Play Console).
  Leur transmettre le lien d'inscription et vérifier leur participation.
- [ ] Maintenir au moins **12 testeurs inscrits pendant 14 jours consécutifs**
  avant de demander l'accès en production. Les tests internes ne remplacent
  pas cette exigence.
- [ ] Recueillir les retours, noter les parcours testés et les corrections
  apportées : ces éléments serviront à la demande d'accès en production.

## 3. Vérifications avant le lancement public

Ces points restent à confirmer pour la version à publier ; ils n'étaient pas
tous signalés comme des blocages par la Console consultée le 27 octobre.

- [ ] Tester l'installation depuis Google Play avec la signature Play :
  démarrage, migrations, saisies, rappels, permissions refusées, export PDF,
  sauvegarde et restauration Drive. Vérifier particulièrement Google Sign-In
  sur cette version distribuée, avec la configuration OAuth correspondante.
- [ ] Examiner le rapport de pré-lancement s'il est disponible et corriger
  les problèmes bloquants de stabilité, compatibilité et accessibilité.
- [ ] Vérifier que la politique publiée est accessible et concorde avec le
  comportement livré et la déclaration « Sécurité des données », notamment
  la conservation/suppression du journal et de la sauvegarde Drive.
- [ ] Confirmer le comportement réel de sauvegarde/transfert Android et
  les décisions de suppression/conservation encore mentionnées dans
  l'inventaire US-68 ; mettre ce document à jour selon les résultats.

## 4. Obtenir l'accès et publier en production

- [ ] Lorsque les critères du test fermé sont remplis, cliquer sur
  « Demander à publier en production » et répondre aux questions sur les
  tests, les retours et la préparation de l'application.
- [ ] Obtenir l'autorisation d'accès en production de Google.
- [ ] Configurer les pays/régions de production et confirmer le choix de
  distribution gratuite/payante.
- [ ] Préparer/promouvoir la version finale en production, renseigner les
  notes de version, vérifier les déclarations et envoyer pour examen.
- [ ] Après approbation, lancer le déploiement selon le mode de publication
  choisi et vérifier la fiche publique, l'installation et les premiers
  rapports Android vitals. La publication gérée était désactivée le
  27 octobre : confirmer ce réglage pour anticiper une éventuelle mise en
  ligne automatique après approbation.

## Constats enregistrés le 27 octobre 2026

- [x] Release **1.0.0** active et accessible aux testeurs internes,
  diffusée le 27 octobre 2026 ; elle est indiquée **non examinée**.
- [x] Nom, descriptions française courte et complète, icône 512 × 512 et
  image de présentation présents dans l'éditeur.
- [x] Politique de confidentialité renseignée :
  <https://gon3s.github.io/assiette/privacy.html>.
- [x] Annonces, classification du contenu, applis gouvernementales,
  fonctionnalités financières, santé, catégorie et coordonnées marquées
  terminées dans le tableau de bord. Plusieurs déclarations attendent encore
  leur envoi pour examen : « terminé » ne signifie pas « approuvé ».
- [x] Workflow de construction et publication d'un AAB signé sur la piste
  interne présent ; voir [la documentation](play-store-releases.md).
  Il publie uniquement sur la piste interne.

Source principale : [tableau de bord Play Console](https://play.google.com/console/u/0/developers/5115711519934903449/app/4974750511243213393/app-dashboard).
Les déclarations Cible et contenu, Sécurité des données et Identifiant
publicitaire ainsi que la fiche avec quatre captures françaises ont été
enregistrées après l'audit, à la demande de l'utilisateur. Leur enregistrement
ne constitue pas une approbation de Google ni une publication en production.
L'envoi pour examen et le lancement du test fermé n'étaient pas encore
effectués lors de ce contrôle. Leur état actuel et les critères affichés par
Google doivent être confirmés dans Play Console.

La capture administrative du contrôle final est conservée en archive locale
privée ; elle ne fait pas partie des captures publiques de l'application.
