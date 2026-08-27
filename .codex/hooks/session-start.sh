#!/bin/bash
# Repository-local Codex bootstrap. Keep this hook deterministic and offline:
# tool installation and user-level configuration do not belong to a project
# session hook.
set -uo pipefail

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git config core.hooksPath .githooks \
    || echo "session-start: unable to configure .githooks" >&2
fi

if ! command -v rtk >/dev/null 2>&1; then
  echo "session-start: rtk is not on PATH; commands may be unfiltered" >&2
fi

exit 0
