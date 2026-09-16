#!/usr/bin/env bash

set -eu

if [ "$#" -ne 2 ]; then
  printf 'Usage: %s <shared-notes.md> <entry.md>\n' "$0" >&2
  exit 64
fi

target=$1
entry=$2
lock_dir="${target}.lock"

[ -f "$target" ] || {
  printf 'Shared notes file not found: %s\n' "$target" >&2
  exit 66
}

[ -s "$entry" ] || {
  printf 'Entry file is missing or empty: %s\n' "$entry" >&2
  exit 66
}

attempt=0
while ! mkdir "$lock_dir" 2>/dev/null; do
  attempt=$((attempt + 1))
  if [ "$attempt" -ge 50 ]; then
    printf 'Could not acquire append lock: %s\n' "$lock_dir" >&2
    exit 75
  fi
  sleep 0.1
done

cleanup() {
  rmdir "$lock_dir" 2>/dev/null || true
}
trap cleanup EXIT HUP INT TERM

printf '\n' >> "$target"
cat "$entry" >> "$target"
printf '\n' >> "$target"

