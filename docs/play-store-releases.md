# Publication Android sur Play Store

Dans Actions → **Android Play Store (internal testing)** → **Run workflow**,
choisir la branche à livrer et, éventuellement, `version_name` (`1.2.3`,
`1.2.3-beta.1`). Sans saisie, la version visible vient du `pubspec.yaml`.
Le workflow exécute génération, analyse et tests, puis construit et publie
l'AAB signé sur la piste **internal**, avec le statut **completed**.

## Numéros de version

- `versionName` : version visible choisie ci-dessus. Elle n'est pas incrémentée
  automatiquement ; plusieurs livraisons internes peuvent garder `1.0.0`.
- `versionCode` : maximum des codes des bundles, APK et versions de **toutes**
  les pistes retournés par Play, plus un. Le suffixe `+N` du `pubspec.yaml`
  constitue un minimum, utile pour reprendre un historique externe.
- Exemple : avec `version: 1.0.0+1` et un maximum Play à `21`, la livraison
  est `1.0.0 (22)`. Une relance après succès produit `1.0.0 (23)`.
- Le résumé Actions affiche la version publiée et le commit source.
  Aucun commit automatique du `pubspec.yaml` n'est nécessaire.

Les publications partagent le groupe de concurrence
`play-store-com-gones-assiette`, indépendant du nom du workflow et de la
branche. Conserver ce même groupe pour tout futur workflow de publication.
GitHub conserve au plus un run en cours et un en attente par groupe : une
nouvelle demande peut remplacer celle déjà en attente.

La lecture et la publication utilisent le même edit Play. Si le build ou
l'envoi échoue, cet edit est abandonné au mieux ; les edits expirent aussi
côté Play. Ne pas modifier l'application dans Play Console pendant une
livraison : cela invalide l'edit. Après résolution d'une erreur réseau ou
d'un edit invalidé, relancer **tous** les jobs pour recalculer le code et
reconstruire l'AAB. Un upload et un commit ne sont jamais retentés aveuglément
dans le même edit. Si un code utilisé hors workflow n'est plus exposé par
l'inventaire Play, relever le minimum `+N` au-dessus de ce code.

## Authentification et maintenance

Les secrets existants restent nécessaires :
`PLAY_STORE_SERVICE_ACCOUNT_JSON`, `ANDROID_KEYSTORE_BASE64`,
`ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD` et
`GOOGLE_SERVER_CLIENT_ID`. Le compte de service conserve ses droits Play
existants ; aucun rôle IAM Token Creator supplémentaire n'est nécessaire.
L'action officielle Google `auth@v3` crée le fichier temporaire ADC et le
supprime en fin de job. Les jetons restent en mémoire, sont masqués dans
Actions et sont renouvelés avant chaque appel du script.

Le script `.github/scripts/play-store.cjs` utilise `gcloud` pour OAuth et les
API REST Play via `fetch` sur Node 24, sans dépendance npm supplémentaire.
Le SDK Google Cloud préinstallé sur le runner est sélectionné par
`setup-gcloud@v3`. Il remplace `r0adkll/upload-google-play`, dont
la version épinglée émettait les avertissements `track`, `punycode` et
`url.parse()`. Les runners sont fixés à `ubuntu-26.04` pour éviter le
changement implicite de `ubuntu-latest`. Le paramètre supprimé
`--delete-conflicting-outputs` n'est plus passé à `build_runner` dans la CI.

Validation locale des scripts, sans publication réelle :

```sh
rtk node --test .github/scripts/*.test.cjs
```

La CI lance ces tests avec une API Play simulée. Une publication réelle
reste déclenchée manuellement après fusion.

Références : [edits Play](https://developers.google.com/android-publisher/edits),
[liste des bundles](https://developers.google.com/android-publisher/api-ref/rest/v3/edits.bundles/list),
[upload des bundles](https://developers.google.com/android-publisher/api-ref/rest/v3/edits.bundles/upload).
