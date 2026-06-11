# assiette — Project Guide for Claude

> This project was generated from the **flutter_starter_kit** Mason brick.
> This file gives Claude (and any contributor) the conventions and commands to
> work effectively in this codebase. Keep it up to date as the project evolves.

## Project overview

Food · symptoms · environment. Connect the dots.

- **State management:** Riverpod 3 with code generation (`@riverpod`)
- **Routing:** GoRouter with code generation + redirect guards
- **Models:** Freezed 3 + `json_serializable`
- **Architecture:** feature-first (`data` / `domain` / `presentation`)



## Golden rules

1. **Never hand-write generated files.** Files ending in `.g.dart` and
   `.freezed.dart` are produced by `build_runner`. Edit the source annotated
   file, then re-run the generator.
2. **Always run code generation after touching annotated files** (providers,
   Freezed models, routes):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   # or keep it running while you work:
   dart run build_runner watch --delete-conflicting-outputs
   ```
3. **No hardcoded user-facing strings.** Add them to `AppStrings` and the
   `AppStringsFr` / `AppStringsEn` implementations, then use
   `AppStrings.of(context).yourKey`.
4. **Keep the analyzer clean.** Run `flutter analyze` — this project uses
   `very_good_analysis` (strict lints). Fix warnings/errors before committing.
5. **Respect the feature-first layering.** UI never talks to Firebase/storage
   directly — it goes through a repository in `domain` implemented in `data`.

## Common commands

```bash
flutter pub get                                    # install deps
dart run build_runner build --delete-conflicting-outputs   # code gen
flutter run -t lib/main_dev.dart                   # run (development)
flutter run -t lib/main.dart                       # run (production)
flutter test                                       # run tests
flutter analyze --no-pub                           # lint (ignorer public_member_api_docs)
```

## Drift (SQLite local)

- Tables → `lib/data/db/` (schéma dans `*_database.dart`, `schemaVersion`)
- DAOs → `lib/data/db/daos/`
- Migrations : incrémenter `schemaVersion` + `MigrationStrategy` avec `recreateAllViews`
- Seed système → `lib/data/db/seed/` (tags système — ne pas modifier sans US dédiée)
- `.g.dart` : jamais à la main — `build_runner` uniquement

## Architecture & conventions

```
lib/
├── main.dart / main_dev.dart   # entry points (prod / dev flavors)
├── bootstrap.dart              # init + error zone + runApp
├── app.dart                    # MaterialApp.router, theme, localization
├── app_env.dart                # environment selector
├── common_widgets/             # shared widgets
├── constants/                  # sizes, spacing
├── localization/               # AppStrings (FR/EN)
├── routing/                    # GoRouter, app startup, 404
├── utils/                      # helpers
└── features/<feature>/
    ├── data/                   # repository implementations, DTOs
    ├── domain/                 # models + repository contracts (abstractions)
    └── presentation/<screen>/  # screen widget + Riverpod controller
```

### Adding a new feature

1. Create `lib/features/<feature>/{data,domain,presentation}/`.
2. Define the model with Freezed in `domain/` (remember: `abstract class`).
3. Define a repository **contract** (abstract class) in `domain/` and a
   `@riverpod` provider returning it.
4. Implement the repository in `data/`.
5. Build the screen + a `@riverpod` controller in `presentation/<screen>/`.
6. Register the route in `lib/routing/app_router.dart`.
7. Run `build_runner`.

### Riverpod 3.x notes (important)

- Functional providers take a plain `Ref` parameter — the old generated
  `*Ref` aliases (e.g. `MyProviderRef`) **no longer exist**.
- `isLoading` / `requireValue` are native on `AsyncValue` — don't redefine them.
- For async controllers, use `AsyncValue.guard` so the state transitions
  `AsyncLoading → AsyncData/AsyncError` cleanly:
  ```dart
  state = const AsyncLoading();
  state = await AsyncValue.guard(() async { /* work */ });
  ```

### Freezed 3.x notes

- Data classes that use `with _$X` **must be declared `abstract`**:
  ```dart
  @freezed
  abstract class MyModel with _$MyModel { ... }
  ```





## Testing conventions

- Tests use `mocktail`.
- Test controllers by listening to their `AsyncValue` state through a
  `ProviderContainer` with overridden providers.
- Mirror the `lib/` structure under `test/`.

## Convention commits

Format : `type(scope): message` — anglais, impératif, ≤72 car.
Scopes : `db`, `feature/<name>`, `routing`, `ui`, `i18n`, `deps`, `config`
Utiliser `/caveman-commit` pour générer le message.

## Before you commit

Gate obligatoire (dans cet ordre) :
```bash
dart run build_runner build --delete-conflicting-outputs  # si fichiers annotés modifiés
flutter analyze --no-pub   # zéro erreur/warning hors public_member_api_docs
flutter test               # doit passer
```
- [ ] Aucune string UI hardcodée
- [ ] Page Notion de l'US mise à jour (status + hash commit)

## Notion — suivi des US

Après chaque US livrée :
1. MCP Notion → page US → `status = Done`
2. Ajouter hash commit court dans les notes de la page
3. Noter blocages éventuels

MCP `notion-update-page` et `notion-fetch` disponibles en session.
