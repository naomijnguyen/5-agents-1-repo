#!/usr/bin/env bash

set -eu

usage() {
  printf 'Usage: %s <session-slug> [agent-name ...]\n' "$0" >&2
  exit 64
}

[ "$#" -ge 1 ] || usage

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
root_dir=$(CDPATH= cd -- "$script_dir/.." && pwd)
slug=$1
shift

case "$slug" in
  *[!a-zA-Z0-9._-]*|'')
    printf 'Session slug may contain only letters, numbers, dots, underscores, and hyphens.\n' >&2
    exit 64
    ;;
esac

session_id="$(date +%Y-%m-%d)-$slug"
session_dir="$root_dir/sessions/$session_id"

if [ -e "$session_dir" ]; then
  printf 'Session already exists: %s\n' "$session_dir" >&2
  exit 73
fi

mkdir -p "$session_dir/agents" "$session_dir/handoffs"
cp "$root_dir/templates/session-overview.md" "$session_dir/OVERVIEW.md"
cp "$root_dir/templates/architecture-map.md" "$session_dir/ARCHITECTURE.md"
cp "$root_dir/templates/documentation-update.md" "$session_dir/DOCUMENTATION.md"
cp "$root_dir/templates/status.md" "$session_dir/STATUS.md"
cp "$root_dir/handoffs/shared_notes.md" "$session_dir/handoffs/shared_notes.md"

for agent in "$@"; do
  case "$agent" in
    *[!a-zA-Z0-9._-]*|'')
      printf 'Agent name may contain only letters, numbers, dots, underscores, and hyphens: %s\n' "$agent" >&2
      exit 64
      ;;
  esac
  agent_dir="$session_dir/agents/$agent"
  mkdir -p "$agent_dir"
  cp "$root_dir/templates/agent-assignment.md" "$agent_dir/ASSIGNMENT.md"
  cp "$root_dir/templates/agent-notes.md" "$agent_dir/NOTES.md"
  cp "$root_dir/templates/handoff.md" "$agent_dir/HANDOFF.md"
done

printf '%s\n' "$session_dir"
