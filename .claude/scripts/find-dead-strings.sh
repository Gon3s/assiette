#!/bin/bash
# Lists AppStrings getters/methods declared in lib/localization/app_strings.dart
# that are never referenced anywhere else in lib/. Catches residue like the
# ~35 unused Auth/Account keys inherited from the flutter_starter_kit Mason
# brick (cleaned up once; this script is for catching it happening again).
#
# Usage: .claude/scripts/find-dead-strings.sh
# Exit code: 0 if no dead keys found, 1 if any dead key found (CI-friendly).
set -uo pipefail

cd "$(dirname "$0")/../.." || exit 1

STRINGS_FILE="lib/localization/app_strings.dart"

if [ ! -f "$STRINGS_FILE" ]; then
  echo "error: $STRINGS_FILE not found (run from repo root or via .claude/scripts/)" >&2
  exit 1
fi

# Extract getter names ("String get foo;") and method names ("String foo(...)")
keys=$(grep -oE '^\s*String get [A-Za-z0-9_]+;' "$STRINGS_FILE" | sed -E 's/^\s*String get ([A-Za-z0-9_]+);/\1/'
       grep -oE '^\s*String [A-Za-z0-9_]+\(' "$STRINGS_FILE" | sed -E 's/^\s*String ([A-Za-z0-9_]+)\(/\1/')

dead=0
total=0
for key in $keys; do
  total=$((total + 1))
  # Usage looks like `s.key` / `AppStrings.of(context).key` / `.key(` for methods.
  # Search everywhere except the 3 files that declare it (enum_labels.dart and
  # others under lib/localization/ are legitimate consumers, so only exclude
  # the declaration files themselves, not the whole directory).
  hits=$(grep -rln --include='*.dart' -E "\.${key}\b" lib \
    | grep -vE 'localization/(app_strings|strings_fr|strings_en)\.dart$' \
    | wc -l)
  if [ "$hits" -eq 0 ]; then
    dead=$((dead + 1))
    echo "dead: $key"
  fi
done

echo "---"
echo "$dead / $total AppStrings keys unused"
[ "$dead" -eq 0 ] && exit 0 || exit 1
