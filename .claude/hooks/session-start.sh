#!/bin/bash
# Installs two third-party Claude Code token-reduction tools at the start of
# every session, so they persist across this repo's ephemeral containers.
# Both installers write to user-level (~/.claude) config, not just this repo,
# and are safe to re-run (idempotent) — see the session's chat history for
# the security review that preceded adding this hook.
#
#   - RTK (github.com/rtk-ai/rtk): compresses Bash/tool output to cut token
#     usage. Installs a checksummed binary + a PreToolUse hook.
#   - Caveman (github.com/JuliusBrussee/caveman): condenses agent responses
#     and adds /caveman-commit. Installs SessionStart/UserPromptSubmit hooks
#     and registers an MCP server.
set -uo pipefail

export PATH="$HOME/.local/bin:$PATH"

if ! command -v rtk >/dev/null 2>&1; then
  curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh \
    || echo "session-start: rtk install failed, continuing without it" >&2
fi
if command -v rtk >/dev/null 2>&1; then
  rtk init -g || echo "session-start: rtk init failed, continuing" >&2
fi

if command -v node >/dev/null 2>&1; then
  curl -fsSL https://raw.githubusercontent.com/JuliusBrussee/caveman/main/install.sh | bash \
    || echo "session-start: caveman install failed, continuing" >&2
else
  echo "session-start: node >=18 not found, skipping caveman install" >&2
fi

exit 0
