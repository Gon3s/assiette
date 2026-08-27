---
name: pre-commit-gate
description: Run this project's mandatory pre-commit gate (build_runner, flutter analyze, flutter test) in order, and summarize failures compactly. Use before committing, when the user asks "is this ready to commit", "run the gate", or "check before I commit".
---

# Pre-commit gate

`AGENTS.md` requires this exact sequence before any commit. Run it in order
and stop at the first failure — don't run later steps on top of a broken
earlier one.

## Steps

1. **Code generation** (skip only if no `@freezed` / `@riverpod` /
   `@DriftDatabase` / `@DriftAccessor`-annotated file changed since the last
   commit):
   ```bash
   rtk dart run build_runner build --delete-conflicting-outputs
   ```
   Fail condition: any conflicting-output prompt not auto-resolved, or a
   generator error. Report the offending file and stop.

2. **Analyzer** — must be zero errors/warnings (info-level
   `public_member_api_docs` is explicitly tolerated per `analysis_options.yaml`):
   ```bash
   rtk flutter analyze --no-pub
   ```
   Fail condition: any `error` or `warning` severity line. Group by file,
   quote the exact lint rule, don't dump the full raw log.

3. **Tests**:
   ```bash
   rtk flutter test
   ```
   Fail condition: any failing test. Report failures only (rtk already
   filters passing output).

   Sandbox-only caveat: if `flutter test` fails with
   `Bad state: Hash of downloaded file libsqlite3...`, this is the known
   sandbox network restriction documented in `AGENTS.md` — apply the
   temporary `pubspec.yaml` `hooks.user_defines.sqlite3.source: system`
   override, re-run `flutter pub get`, run tests, then **revert the
   pubspec change before finishing** (never commit it).

4. **Checklist** (manual, not a command):
   - [ ] No hardcoded UI string was introduced (`AppStrings.of(context)` used
     for all new user-facing text — see the `add-string` skill).
   - [ ] Notion US page updated (status + short commit hash) — reminder only,
     do this after the commit exists.

## Output

Report pass/fail per step, terse. On failure, stop there — don't proceed to
the next step or claim the gate passed.
