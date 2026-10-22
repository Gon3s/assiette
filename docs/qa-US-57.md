# US-57 — Validation des raccourcis sommeil

Validation effectuée le 22 octobre 2026.

## Vérifications automatisées

- Génération : `dart run build_runner build --delete-conflicting-outputs`.
- Analyse : `flutter analyze --no-pub`, aucun problème.
- Suite complète : `flutter test --no-pub --reporter failures-only`,
  235 tests réussis.
- APK : `flutter build apk --debug --no-pub`, compilation réussie.

Les régressions couvrent notamment la qualité inconnue, la note facultative,
le coucher et le lever, le passage de minuit, les actions répétées,
les anciennes clés de date et la conservation de la date de nuit lors
d'un changement de fuseau. La migration v12 préserve les anciennes nuits.
Le formulaire est également vérifié sans fournisseur préchargé, et les
raccourcis ne doivent pas attendre le flux du journal avant de naviguer.

## Vérifications sur émulateur

Android 15, API 35, AVD `Medium_Phone_API_35`.
Un profil Android temporaire avec une base vierge a été utilisé, puis supprimé.

- Appui long sur l'icône dans le lanceur : deux raccourcis visibles.
- Application arrêtée, choix du coucher dans le menu : ouverture du journal
  et carte « Nuit en cours ».
- Application arrêtée, choix du lever dans le menu : ouverture du formulaire
  avec les deux heures, sans qualité sélectionnée.
- Choix d'une qualité et saisie d'une note fictive : sauvegarde réussie,
  retour au journal et qualité affichée sur la carte.

Les captures de cette session restent dans `build/qa/`, dossier ignoré par Git.

## Correctifs issus de la validation

- Déclaration `android.app.shortcuts` placée sur l'activité du lanceur.
- Navigation après l'écriture, sans attendre un flux Riverpod non écouté.
- Écoute du sommeil par le formulaire avant d'initialiser ses champs.
- Date canonique de nuit conservée malgré un changement de fuseau.

## Limite de validation

Flutter local : **3.44.1**, Dart **3.12.1**.
La CI est épinglée sur Flutter **3.44.5** ; cette version exacte n'a pas été
exécutée localement. La validation Android concerne l'APK debug sur émulateur.
