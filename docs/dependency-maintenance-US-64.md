# Maintenance des dépendances — US-64

Inventaire du 24 octobre 2026, établi avec Flutter **3.44.5** / Dart **3.12.2**,
depuis le lockfile de main (2a4e963). Les versions restent inchangées dans cette
US : les montées de version et leur validation métier font l'objet de PR dédiées.

Après cet inventaire, la PR #45 a migré le projet vers Flutter **3.47.8** /
Dart **3.13.7** et Freezed 4. La procédure courante utilise ce nouveau SDK;
les tableaux ci-dessous conservent l'état initial de l'inventaire.

## Sources et couverture

- flutter pub outdated --json et flutter pub get --enforce-lockfile :
  résolution avec le SDK épinglé, contraintes du pubspec et du graphe complet.
- [OSV querybatch](https://google.github.io/osv.dev/api/#tag/querybatch) :
  les **180 paquets Pub hébergés verrouillés** et les trois coordonnées
  Maven déclarées (AGP, plugin Kotlin et desugar_jdk_libs), aux versions exactes.
- Métadonnées officielles [AGP](https://dl.google.com/dl/android/maven2/com/android/tools/build/gradle/maven-metadata.xml),
  [Kotlin](https://repo.maven.apache.org/maven2/org/jetbrains/kotlin/kotlin-gradle-plugin/maven-metadata.xml),
  [desugar](https://dl.google.com/dl/android/maven2/com/android/tools/desugar_jdk_libs/maven-metadata.xml)
  et [Gradle](https://services.gradle.org/versions/current).
- Releases et références Git des dépôts officiels des Actions, vérifiées par
  l'API GitHub avant épinglage sur SHA de commit.

Cet état ne couvre pas tous les JAR transitifs Android, les binaires du SDK ni
les outils internes des Actions. Une absence de correspondance OSV ne prouve
pas l'absence de vulnérabilité. Les versions « résolubles » ne constituent pas
une validation des API, des migrations ou du comportement sur appareil.

## Avis de sécurité et recommandations

Aucun avis OSV ne correspond aux 180 versions Pub interrogées. Le résolveur Pub
ne signale pas de version rétractée ou affectée dans sa sortie d'inventaire.

**Kotlin Gradle plugin 2.3.20 : avis modéré
[GHSA-r937-wjx7-w2jp / CVE-2026-53914](https://osv.dev/vulnerability/GHSA-r937-wjx7-w2jp)**.
Une désérialisation non sûre des métadonnées du cache de build peut permettre
l'exécution de code. L'avis indique une correction à partir de 2.4.20-Beta1;
la version stable recommandée à évaluer est **2.4.21**. Le plugin est déclaré
avec apply false; l'usage effectif dans la chaîne Kotlin intégrée à AGP reste
à vérifier. Prévoir une PR Android dédiée : revue de compatibilité
Flutter 3.44.5 / AGP / Gradle / JDK, compilation APK et essais sur appareil.
Cette US identifie et trace cet avis; elle ne livre pas sa correction.

Ordre de revue recommandé : Kotlin et sa chaîne Android, correctifs des plugins
natifs, puis mises à jour Dart compatibles. Les versions majeures et
préversions restent en revue manuelle. Ne pas lancer une mise à jour majeure
globale pour faire disparaître les écarts de cet inventaire.

## Blocages de compatibilité observés

- intl reste à 0.20.2 même en résolution élargie : version liée au SDK Flutter.
- google_fonts 9.0.0, build_runner 2.17.1 et very_good_analysis 11.0.0 dépassent
  les versions résolubles du graphe actuel. Examiner SDK et contraintes avant
  toute mise à jour; conserver l'alignement entre le lint et analysis_options.yaml.
- Drift / drift_dev et Riverpod / annotations / générateur demandent une revue
  groupée. Le résolveur ne peut pas appliquer toutes leurs dernières versions
  sous les contraintes actuelles.
- Freezed est verrouillé sur 3.2.6-dev.1; la résolution élargie propose encore
  une préversion tandis que la dernière stable est 4.0.3. Revue de migration et
  de compatibilité des générateurs requise.
- geocoding 5, flutter_timezone 5, go_router 18, googleapis 17,
  cupertino_icons 2 et workmanager 0.10 demandent une revue d'API ou native.
- Les paquets épinglés par flutter_test (test_api, matcher, meta, etc.) doivent
  suivre le SDK : ne pas utiliser dependency_overrides pour les forcer.

## Android

| Composant | Déclaré | Dernière stable observée | Traitement |
| --- | --- | --- | --- |
| AGP | 9.0.1 | 9.4.1 | PR manuelle avec Gradle et Flutter |
| Gradle wrapper | 9.1.0 | 9.8.2 | Matrice AGP/JDK à vérifier |
| Kotlin Gradle plugin | 2.3.20 | 2.4.21 | Avis de sécurité ci-dessus; revue prioritaire |
| desugar_jdk_libs | 2.1.4 | 2.1.5 | Correctif natif en revue manuelle |

La dernière stable n'est pas automatiquement compatible avec ce projet.
Dependabot surveille /android, y compris les plugins Gradle et le wrapper.

## GitHub Actions

Les majeures existantes sont conservées et leurs références sont maintenant
des SHA de commit vérifiés; Dependabot proposera leur actualisation.

| Action | Majeure conservée | Dernière release observée | Revue |
| --- | --- | --- | --- |
| actions/checkout | v4 | v7.0.1 | Migration majeure manuelle |
| actions/setup-java | v4 | v6.1.0 | Migration majeure manuelle |
| subosito/flutter-action | v2 | v2.23.0 | Revue manuelle; SDK toujours 3.44.5 |
| softprops/action-gh-release | v2 | v3.0.3 | Migration majeure manuelle |
| r0adkll/upload-google-play | v1 | v1.1.5 | Revue manuelle avant publication |
| actions/github-script (nouvelle) | v9 | v9.0.0 | SHA épinglé; exécution sur runner hébergé |

Les avis OSV de la section précédente couvrent Pub et les trois coordonnées
Maven, pas les Actions. Leur épinglage et leur surveillance ne constituent pas
une certification de sécurité de leur code.

## Procédure de maintenance

1. Dependabot vérifie chaque lundi, heure de Paris : Pub à 07:00, Gradle à
   07:15 et Actions à 07:30. Limites de PR : 5 / 3 / 3. Les correctifs Dart de
   la liste ci-dessous sont groupés; les mises à jour Gradle/Actions mineures
   et correctives sont regroupées séparément.
2. Toute PR vers main exécute « Flutter quality gate » (installation avec
   lockfile, génération, analyse sans diagnostic, tests) et « Dependency
   automation policy » (tests Node de la politique). La CI des PR est en
   lecture seule et n'utilise aucun secret de publication.
3. La protection de main doit rendre ces deux contrôles obligatoires et
   exiger une branche à jour. Les noms des jobs sont des identifiants stables à
   conserver synchronisés avec les protections GitHub. La configuration
   attendue est versionnée dans .github/main-protection.json : contrôles liés
   à GitHub Actions (app 15368), administrateurs inclus, force-push et
   suppression interdits. Les revues humaines ne sont pas imposées globalement
   afin de permettre les correctifs admissibles; les autres PR nécessitent
   une fusion manuelle.
4. Après réussite de cette CI, le workflow de fusion utilise exclusivement du
   code de la branche par défaut et lit le contenu de la PR comme des données.
   Il vérifie l'auteur dependabot[bot], l'origine du dépôt, le SHA testé, les
   deux jobs réussis et leur présence dans la protection de main avec l'identité
   GitHub Actions, puis demande une fusion squash via l'API REST GitHub avec
   le SHA testé. Les protections de main restent appliquées par GitHub; un
   refus ou une modification concurrente laisse la PR ouverte. Les erreurs
   d'autorisation ou du serveur restent visibles dans Actions.
5. Éligibilité : uniquement pubspec.yaml / pubspec.lock modifiés, correctifs
   stables croissants de archive, collection, freezed_annotation, http, intl,
   json_annotation, mocktail, path, timezone ou uuid. Chaque changement
   transitif du lockfile est également vérifié. Changement natif, autre
   paquet, mineure, majeure, préversion, SDK, ajout/retrait de dépendance,
   changement de registre, de code ou de workflow : revue manuelle.
6. Les PR non admissibles restent ouvertes pour revue. Sur échec : lire les
   logs des contrôles, reproduire avec Flutter 3.47.8, corriger dans une PR ou
   demander une actualisation Dependabot. Ne pas désactiver les contrôles
   requis et ne pas ignorer un avis de sécurité sans décision documentée.
7. Arrêt de l'automatisation : désactiver « Dependabot patch auto-merge » dans
   Actions.
   Refaire une revue avant réactivation. Pour élargir la liste, modifier à la
   fois dependabot.yml et dependency-policy.cjs, avec leurs tests.

État GitHub initial observé : main non protégée, aucune ruleset et auto-merge
désactivé. L'activation et les résultats CI de livraison sont consignés dans
la PR et dans la page Notion de la US-64.

## Dépendances Pub directes et de développement obsolètes

« Mise à jour autorisée » respecte les contraintes actuelles; « Résoluble »
permet de les élargir tout en gardant le SDK et un graphe cohérent. Un tiret
signifie qu'aucune version n'est proposée dans cette colonne. Les dépendances
déjà à jour ne sont pas listées.

| Paquet | Verrouillé | Mise à jour autorisée | Résoluble | Dernière |
| --- | --- | --- | --- | --- |
| archive | 4.0.9 | 4.5.2 | 4.5.2 | 4.5.2 |
| build_runner | 2.15.0 | 2.15.1 | 2.15.1 | 2.17.1 |
| cupertino_icons | 1.0.9 | 1.0.9 | 2.0.0 | 2.0.0 |
| drift | 2.33.0 | 2.34.4 | 2.35.3 | 2.35.3 |
| drift_dev | 2.33.0 | 2.34.0 | 2.35.2 | 2.35.2 |
| drift_flutter | 0.3.0 | 0.3.1 | 0.3.1 | 0.3.1 |
| fl_chart | 1.2.0 | 1.3.0 | 1.3.0 | 1.3.0 |
| flutter_local_notifications | 22.0.0 | 22.3.2 | 22.3.2 | 22.3.2 |
| flutter_riverpod | 3.3.2 | 3.3.2 | 3.4.3 | 3.4.3 |
| flutter_timezone | 4.1.1 | 4.1.1 | 5.1.1 | 5.1.1 |
| freezed | 3.2.6-dev.1 | 3.2.6-dev.1 | 4.0.0-dev.3 | 4.0.3 |
| geocoding | 4.0.0 | 4.0.0 | 5.0.0 | 5.0.0 |
| geolocator | 14.0.2 | 14.1.2 | 14.1.2 | 14.1.2 |
| go_router | 17.3.0 | 17.5.0 | 18.1.1 | 18.1.1 |
| google_fonts | 6.3.3 | 6.3.3 | 8.2.1 | 9.0.0 |
| googleapis | 15.0.0 | 15.0.0 | 17.0.0 | 17.0.0 |
| intl | 0.20.2 | 0.20.2 | 0.20.2 | 0.20.3 |
| json_serializable | 6.14.0 | 6.15.2 | 6.15.2 | 6.15.2 |
| path_provider | 2.1.5 | 2.1.6 | 2.1.6 | 2.1.6 |
| pdf | 3.12.0 | 3.13.1 | 3.13.1 | 3.13.1 |
| printing | 5.14.3 | 5.15.1 | 5.15.1 | 5.15.1 |
| riverpod_annotation | 4.0.3 | 4.0.3 | 4.0.7 | 4.0.7 |
| riverpod_generator | 4.0.4 | 4.0.4 | 4.0.9 | 4.0.9 |
| share_plus | 13.1.0 | 13.3.1 | 13.3.1 | 13.3.1 |
| timezone | 0.11.0 | 0.11.2 | 0.11.2 | 0.11.2 |
| uuid | 4.5.3 | 4.6.0 | 4.6.0 | 4.6.0 |
| very_good_analysis | 10.2.0 | 10.3.0 | 10.3.0 | 11.0.0 |
| workmanager | 0.9.0+3 | 0.9.3 | 0.10.10 | 0.10.10 |

## Dépendances Pub transitives signalées par le résolveur

| Paquet | Verrouillé | Mise à jour autorisée | Résoluble | Dernière |
| --- | --- | --- | --- | --- |
| _discoveryapis_commons | 1.0.7 | 1.0.8 | 1.0.8 | 1.0.8 |
| _fe_analyzer_shared | 99.0.0 | 99.0.0 | 100.0.0 | 110.0.0 |
| analyzer | 12.1.0 | 12.1.0 | 13.0.0 | 14.6.0 |
| analyzer_buffer | 0.3.2 | 0.3.4 | 0.3.4 | 0.3.4 |
| build | 4.0.6 | 4.0.7 | 4.0.7 | 5.0.0 |
| build_config | 1.3.0 | 1.3.3 | 1.3.3 | 1.4.0 |
| build_daemon | 4.1.1 | 4.1.7 | 4.1.7 | 4.1.7 |
| built_collection | 5.1.1 | 5.1.2 | 5.1.2 | 5.1.2 |
| built_value | 8.12.6 | 8.13.0 | 8.13.0 | 8.13.0 |
| cli_util | 0.4.2 | 0.4.2 | 0.6.0 | 0.6.0 |
| clock | 1.1.2 | 1.1.2 | 1.1.2 | 1.1.3 |
| code_assets | 1.2.1 | 1.2.1 | 1.2.1 | 2.1.0 |
| code_builder | 4.11.1 | 4.13.0 | 4.13.0 | 4.13.0 |
| coverage | 1.15.1 | 1.15.1 | — | 1.16.0 |
| cross_file | 0.3.5+2 | 0.3.5+5 | 0.3.5+5 | 0.4.0 |
| cupertino_ui | — | — | 1.0.2 | 1.1.4 |
| dart_style | 3.1.8 | 3.1.8 | 3.1.9 | 3.1.14 |
| dbus | 0.7.14 | 0.7.15 | 0.7.15 | 0.8.0 |
| equatable | 2.1.0 | 3.0.0 | 3.0.0 | 3.0.0 |
| flutter_local_notifications_linux | 8.0.1 | 8.0.2 | 8.0.2 | 8.0.2 |
| flutter_local_notifications_platform_interface | 12.0.0 | 12.2.0 | 12.2.0 | 12.2.0 |
| flutter_local_notifications_windows | 3.1.0 | 3.1.1 | 3.1.1 | 3.1.1 |
| frontend_server_client | 4.0.0 | 4.1.0 | — | 4.2.0 |
| geocoding_android | 4.0.1 | 4.0.1 | 5.1.0 | 5.1.0 |
| geocoding_darwin | — | — | 1.0.3 | 1.0.3 |
| geocoding_platform_interface | 3.2.0 | 3.2.0 | 5.0.0 | 5.0.0 |
| geolocator_android | 5.0.2 | 5.2.1 | 5.2.1 | 5.2.1 |
| geolocator_apple | 2.3.13 | 2.4.3 | 2.4.3 | 2.4.3 |
| geolocator_linux | 0.2.5 | 0.2.6 | 0.2.6 | 0.2.6 |
| geolocator_platform_interface | 4.2.7 | 4.4.1 | 4.4.1 | 4.4.1 |
| geolocator_web | 4.1.3 | 4.1.4 | 4.1.4 | 4.1.4 |
| glob | 2.1.3 | 2.2.0 | 2.2.0 | 2.2.0 |
| google_sign_in_android | 7.2.16 | 7.2.18 | 7.2.18 | 7.2.18 |
| google_sign_in_ios | 6.3.0 | 6.3.8 | 6.3.8 | 6.3.8 |
| gsettings | 0.2.8 | 0.2.8 | 0.2.8 | 0.2.9 |
| hooks | 2.0.2 | 2.0.2 | 2.0.2 | 2.2.0 |
| html | 0.15.6 | 0.15.7 | 0.15.7 | 0.15.7 |
| http_multi_server | 3.2.2 | 3.2.3 | 3.2.3 | 3.2.3 |
| image | 4.8.0 | 4.12.0 | 4.12.0 | 4.12.0 |
| io | 1.0.5 | 1.1.0 | 1.1.0 | 1.1.0 |
| jni | 1.0.0 | 1.1.0 | 1.1.0 | 1.1.0 |
| jni_flutter | 1.0.1 | 1.0.4+1 | 1.0.4+1 | 1.0.4+1 |
| jni_util | — | 1.0.0 | 1.0.0 | 1.0.0 |
| listen | — | — | 1.0.1 | 1.0.1 |
| matcher | 0.12.19 | 0.12.19 | 0.12.19 | 0.12.20 |
| material_color_utilities | 0.13.0 | 0.13.0 | 0.13.0 | 0.13.1 |
| material_ui | — | — | 1.2.0 | 1.8.0 |
| meta | 1.18.0 | 1.18.0 | 1.18.0 | 1.19.0 |
| mime | 2.0.0 | 2.1.0 | 2.1.0 | 2.1.0 |
| mockito | 5.6.4 | 5.6.4 | 5.7.0 | 5.8.1 |
| native_toolchain_c | 0.19.1 | 0.19.2 | 0.19.2 | 0.19.5 |
| objective_c | 9.4.1 | 9.5.0 | 9.5.0 | 9.6.2 |
| package_config | 2.2.0 | 2.2.0 | 2.2.0 | 3.0.0 |
| package_info_plus | 10.1.0 | 10.2.2 | 10.2.2 | 10.2.2 |
| path_provider_linux | 2.2.1 | 2.2.2 | 2.2.2 | 2.2.2 |
| path_provider_platform_interface | 2.1.2 | 2.1.3 | 2.1.3 | 2.1.3 |
| petitparser | 7.0.2 | 7.0.2 | 7.0.2 | 7.1.0 |
| platform | 3.1.6 | 3.2.0 | 3.2.0 | 3.2.0 |
| pool | 1.5.2 | 1.5.3 | 1.5.3 | 1.5.3 |
| posix | 6.5.0 | 6.5.2 | 6.5.2 | 6.5.2 |
| pub_semver | 2.2.0 | 2.2.1 | 2.2.1 | 2.2.1 |
| pubspec_parse | 1.5.0 | 1.7.0 | 1.7.0 | 1.7.0 |
| qr | 3.0.2 | 3.0.2 | 3.0.2 | 4.0.0 |
| record_use | 0.6.0 | 0.6.0 | 0.6.0 | 1.1.1 |
| riverpod | 3.3.2 | 3.3.2 | 3.4.3 | 3.4.3 |
| riverpod_analyzer_utils | 1.0.0-dev.10 | 1.0.0-dev.10 | 1.0.0-dev.12 | 1.0.0-dev.12 |
| share_plus_platform_interface | 7.1.0 | 7.2.0 | 7.2.0 | 7.2.0 |
| shelf | 1.4.2 | 1.4.3 | 1.4.3 | 1.4.3 |
| shelf_static | 1.1.3 | 1.2.0 | — | 1.2.0 |
| source_gen | 4.2.3 | 4.2.4 | 4.2.4 | 4.3.1 |
| source_helper | 1.3.12 | 1.4.0 | 1.4.0 | 1.4.0 |
| source_maps | 0.10.13 | 0.10.14 | — | 0.10.14 |
| sqlite3 | 3.3.2 | 3.5.2 | 3.5.2 | 3.8.0 |
| sqlparser | 0.44.4 | 0.44.5 | 0.45.1 | 0.45.1 |
| stack_trace | 1.12.1 | 1.12.1 | 1.12.1 | 1.12.2 |
| stream_transform | 2.1.1 | 2.1.2 | 2.1.2 | 2.1.2 |
| test | 1.31.0 | 1.31.0 | — | 1.33.0 |
| test_api | 0.7.11 | 0.7.11 | 0.7.11 | 0.7.15 |
| test_core | 0.6.17 | 0.6.17 | — | 0.6.21 |
| url_launcher_linux | 3.2.2 | 3.2.3 | 3.2.3 | 3.2.3 |
| url_launcher_windows | 3.1.5 | 3.1.6 | 3.1.6 | 3.1.6 |
| vector_math | 2.2.0 | 2.2.0 | 2.2.0 | 2.4.3 |
| vm_service | 15.2.0 | 15.4.0 | 15.4.0 | 15.4.0 |
| web | 1.1.1 | 1.1.1 | 1.1.1 | 1.1.2 |
| win32 | 6.3.0 | 6.4.0 | 6.4.0 | 6.4.0 |
| workmanager_android | 0.9.0+2 | 0.9.3 | 0.10.9 | 0.10.9 |
| workmanager_apple | 0.9.1+2 | 0.9.6 | 0.9.11 | 0.9.11 |
| workmanager_linux | — | — | 0.1.1+1 | 0.1.1+1 |
| workmanager_platform_interface | 0.9.1+1 | 0.9.4 | 0.10.5 | 0.10.5 |
| workmanager_web | — | — | 0.2.0 | 0.2.0 |
| xml | 6.6.1 | 7.0.1 | 7.0.1 | 7.1.0 |
| yaml | 3.1.3 | 3.1.4 | 3.1.4 | 3.1.4 |
| yaml_edit | — | — | 2.2.4 | 2.2.4 |
