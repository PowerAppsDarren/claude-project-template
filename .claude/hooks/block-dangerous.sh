#!/usr/bin/env bash
# .claude/hooks/block-dangerous.sh
# PreToolUse hook for Bash — blocks dangerous commands before execution.
# Exit 0 = allow, Exit 2 = block (stderr shown to Claude), other = warn.
#
# The command being executed is passed via CLAUDE_TOOL_INPUT as JSON.
# Extract the "command" field for inspection.

set -euo pipefail

# Extract the command from the tool input JSON
COMMAND=$(echo "$CLAUDE_TOOL_INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('command',''))" 2>/dev/null || echo "")

if [ -z "$COMMAND" ]; then
  exit 0
fi

# --- Destructive filesystem operations ---
if echo "$COMMAND" | grep -qE 'rm\s+(-[a-zA-Z]*f[a-zA-Z]*\s+)?(/|~|\.\s)'; then
  echo "BLOCKED: Destructive rm command targeting root, home, or current directory" >&2
  exit 2
fi

# --- Force push to main/master ---
if echo "$COMMAND" | grep -qE 'git\s+push\s+.*--force.*\s+(main|master)'; then
  echo "BLOCKED: Force push to main/master is not allowed" >&2
  exit 2
fi
if echo "$COMMAND" | grep -qE 'git\s+push\s+-f\s+.*\s+(main|master)'; then
  echo "BLOCKED: Force push to main/master is not allowed" >&2
  exit 2
fi

# --- Dangerous SQL operations ---
if echo "$COMMAND" | grep -qiE '(DROP\s+(TABLE|DATABASE|SCHEMA)|TRUNCATE\s+TABLE|DELETE\s+FROM\s+\S+\s*;?\s*$)'; then
  echo "BLOCKED: Destructive SQL operation detected" >&2
  exit 2
fi

# --- Dangerous chmod ---
if echo "$COMMAND" | grep -qE 'chmod\s+777'; then
  echo "BLOCKED: chmod 777 is a security risk — use specific permissions instead" >&2
  exit 2
fi

# --- Disk-level operations ---
if echo "$COMMAND" | grep -qE '(mkfs\.|dd\s+if=|>\s*/dev/sd)'; then
  echo "BLOCKED: Disk-level operations are not allowed" >&2
  exit 2
fi

# --- Credential exposure in commands ---
if echo "$COMMAND" | grep -qiE '(password|secret|token|api_key|apikey)\s*=\s*['\''"][^'\''"]+['\''"]'; then
  echo "BLOCKED: Possible credential exposure in command — use environment variables instead" >&2
  exit 2
fi

# --- Disable git hooks ---
if echo "$COMMAND" | grep -qE '(--no-verify|--no-gpg-sign)'; then
  echo "BLOCKED: Bypassing git hooks/signing is not allowed" >&2
  exit 2
fi

# Command passed all checks
exit 0
