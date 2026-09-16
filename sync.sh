#!/usr/bin/env bash
#
# Sync the skill payload from the canonical bootwitch-agents repository into
# this plugin's skills/bootwitch-agents/ directory.
#
# bootwitch-agents is canonical. Edit the skill there, then run this to
# propagate. Manifests, README, and CHANGELOG in this repo are NOT touched --
# they are plugin-specific and intentionally diverge.
#
#   ./sync.sh              show what would change (default; writes nothing)
#   ./sync.sh --apply      write the changes
#   SOURCE=/path ./sync.sh use a different source checkout

set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
source_dir=${SOURCE:-$(CDPATH= cd -- "$repo_dir/../../AGENTS" 2>/dev/null && pwd || true)}
dest_dir="$repo_dir/skills/bootwitch-agents"

apply=0
case "${1:-}" in
  --apply) apply=1 ;;
  ''|--dry-run) ;;
  *) printf 'Usage: %s [--apply]\n' "$0" >&2; exit 64 ;;
esac

[ -n "$source_dir" ] && [ -d "$source_dir" ] || {
  printf 'Source checkout not found. Set SOURCE=/path/to/bootwitch-agents\n' >&2
  exit 66
}
[ -f "$source_dir/SKILL.md" ] || {
  printf 'Not a bootwitch-agents checkout (no SKILL.md): %s\n' "$source_dir" >&2
  exit 66
}

# Payload only. sessions/ carries just its README; generated sessions stay local.
items="SKILL.md OVERVIEW.md ARCHITECTURE.md templates scripts handoffs sessions/README.md"

changed=0
for item in $items; do
  src="$source_dir/$item"
  dst="$dest_dir/$item"
  [ -e "$src" ] || { printf 'missing in source, skipped: %s\n' "$item" >&2; continue; }
  if diff -qr "$src" "$dst" >/dev/null 2>&1; then
    continue
  fi
  changed=1
  printf '\n=== %s ===\n' "$item"
  diff -ru "$dst" "$src" 2>/dev/null | head -40 || true
  if [ "$apply" -eq 1 ]; then
    mkdir -p "$(dirname -- "$dst")"
    rm -rf "$dst"
    cp -R "$src" "$dst"
  fi
done

find "$dest_dir" -name '.DS_Store' -delete 2>/dev/null || true

if [ "$changed" -eq 0 ]; then
  printf 'Already in sync with %s\n' "$source_dir"
elif [ "$apply" -eq 1 ]; then
  printf '\nApplied. Review with: git -C %s diff\n' "$repo_dir"
else
  printf '\nNothing written. Re-run with --apply to sync.\n'
fi
