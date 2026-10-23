# Correctifs sécurité — US-65 et US-66

Ces changements traitent SEC-63-01 (restauration ZIP) et SEC-63-04
(signature release), identifiés par l’audit US-63.

## Sauvegardes ZIP

Les limites sont appliquées à la création et à la restauration :

| Ressource | Limite |
| --- | --- |
| Archive compressée, téléchargement compris | 64 Mio |
| Ensemble des entrées décompressées | 128 Mio |
| `database.json` | 8 Mio |
| Une photo | 16 Mio |
| Nombre d’entrées, base comprise | 2 048 |
| Nombre total de lignes du snapshot | 100 000 |

Le téléchargement s’arrête dès qu’il dépasse son budget. La lecture des
en-têtes précède toute décompression. Seuls les ZIP simples utilisant STORE
ou DEFLATE sont acceptés : pas de chiffrement ZIP, ZIP64, archives réparties,
liens symboliques, répertoires, chemins imbriqués ou entrées inconnues.
Les noms sont uniques, y compris sans tenir compte de la casse.

La taille réellement décompressée est contrôlée à chaque bloc, indépendamment
des tailles déclarées dans le ZIP. Le CRC et la longueur finale doivent
correspondre aux métadonnées. Le décodeur évite le parcours de la bibliothèque
`archive` qui accumule toute la sortie décompressée avant son contrôle.

Le snapshot doit utiliser un format entier de 1 à 5. Sa structure, ses types,
contraintes SQLite et références sont vérifiés dans une base mémoire distincte.
Les migrations de symptômes et observations des anciens formats restent prises
en charge. Chaque photo référencée doit être présente, et chaque photo de
l’archive doit être référencée. Une sauvegarde incomplète échoue explicitement.

Les photos sont écrites et synchronisées dans un dossier temporaire privé.
Le dossier est ensuite renommé vers un emplacement unique sous `meal_photos`.
La base et l’indicateur de restauration sont mis à jour dans une transaction,
en utilisant ces nouveaux chemins. Les fichiers précédemment référencés ne
sont jamais écrasés : une interruption avant le commit laisse la base et ses
photos utilisables. Une erreur de transaction supprime les nouveaux fichiers.
L’offre de restauration reste disponible après un échec.

Les anciennes photos privées restent sur disque. Une interruption du processus
ou un échec du nettoyage peut également laisser des fichiers sans référence.
La purge et la politique de rétention relèvent du chantier confidentialité.
La validation ne prouve pas l’authenticité d’une archive : les sauvegardes ne
sont pas signées ou chiffrées par cette modification.

## Signature Android

Le type `release` utilise exclusivement la configuration `release`.
La tâche `validateReleaseSigning` précède les tâches release, y compris
`assembleRelease` et `bundleRelease`, sans dépendre de la manière dont la tâche
a été demandée. Elle exige les quatre champs de `android/key.properties`,
le fichier keystore et une clé privée accessible avec les mots de passe fournis.
Elle refuse l’alias `androiddebugkey` et les certificats `CN=Android Debug`,
même si leur alias a été renommé. Les diagnostics ne recopient aucun secret.

Les tâches debug restent disponibles sans configuration release. Le workflow
Play continue à fournir le keystore et ses propriétés via les secrets CI.
Aucune clé de publication n’a été ajoutée au dépôt.

## Vérification

SDK : Flutter 3.44.5 / Dart 3.12.2, conformément aux deux workflows Android.

- Tests ciblés : archives tronquées/invalides, noms et doublons, liens,
  chiffrement ZIP refusé, CRC, métadonnées de taille falsifiées, budgets,
  annulation du téléchargement, versions, types et références.
- Restauration : succès suivi d’une nouvelle sauvegarde, erreur SQLite après
  remplacement des lignes, erreur sur l’indicateur, photos absentes ou en trop,
  échec de publication sur disque et conservation des fichiers existants.
- Signature : fixture Gradle isolée avec clés jetables. Dix cas vérifiés :
  debug sans configuration; release sans configuration; propriétés incomplètes;
  keystore absent; alias debug; certificat debug renommé; mauvais mot de passe;
  alias absent; clé de test valide pour assemble et bundle.
  Reproduction sous PowerShell :
  `rtk proxy powershell -NoProfile -File tool/check_release_signing.ps1`
  (JDK/keytool et distribution Gradle du wrapper déjà disponibles).
- Projet Android réel : `:app:assembleRelease` sans `key.properties` échoue
  explicitement dans `:app:validateReleaseSigning`.

La publication Play et la signature avec la vraie clé de publication ne sont
pas exécutées. Les autres constats US-63 (permissions, confidentialité/Play,
CI et chiffrement des sauvegardes) restent des chantiers distincts.
