---
name: add-string
description: Add or rename a user-facing string in this Flutter project's AppStrings localization system, keeping app_strings.dart, strings_fr.dart and strings_en.dart in sync in one pass. Use when the user asks to add UI text, a new label/message/button text, or fix a missing AppStrings getter.
---

# Add / sync an AppStrings key

`AppStrings` has no `.arb`/ICU codegen — it's three hand-written Dart files
that must all define the exact same getters. Missing one of the three is the
most common source of analyzer/runtime breakage in this project (see commit
`43d38cc fix(i18n): add missing AppStrings getters`).

## Steps

1. **Check for an existing key first.** Grep `lib/localization/app_strings.dart`
   for a getter that already covers this text (many screens share `save`,
   `cancel`, `confirm`, `errorGeneric`, etc. in the `// Common` section) —
   don't create a duplicate.

2. **Pick the right section.** `app_strings.dart` is organized by feature
   comment (`// Common`, `// Home`, `// Day view`, `// Meal entry`,
   `// Favorites`, `// Symptom entry`, `// Sleep entry`, `// Settings`,
   `// Onboarding`). Add the new getter under the matching section, or a new
   `// <Feature>` section if this is for a brand-new feature.

3. **Add the same getter to all three files in the same edit pass**, in the
   same relative position (so the three files stay easy to diff against each
   other):
   - `lib/localization/app_strings.dart` — abstract declaration only:
     ```dart
     String get myNewKey;
     ```
     For parameterized strings, declare the method signature instead:
     ```dart
     String myNewKey(String label);
     ```
   - `lib/localization/strings_fr.dart` — French value:
     ```dart
     @override
     String get myNewKey => 'Ma nouvelle valeur';
     ```
   - `lib/localization/strings_en.dart` — English value:
     ```dart
     @override
     String get myNewKey => 'My new value';
     ```

4. **Use it** via `AppStrings.of(context).myNewKey` — never a hardcoded
   `Text('...')` literal for user-facing copy.

5. **Verify all three are in sync**: run
   ```bash
   flutter analyze --no-pub
   ```
   A missing `@override` in either `strings_fr.dart` or `strings_en.dart`
   fails compilation immediately (unimplemented abstract member) — that's
   the safety net, but check it explicitly rather than relying on the user
   to notice.

## Cleaning up unused keys

Before deleting a key, grep its usage across `lib/features/` — some names
look feature-specific but are shared (`save`, `cancel`, `confirm` are used
by four different screens). Only remove a getter from all three files at
once, never from just one.
