# Changelog

## v0.3.0 - 2026-09-16

- Added "Co-authored by Codex and Claude" to the README and to the generated architecture
  and technical documents.
- Credited both Claude and Codex in the README.
- Added sync.sh to propagate the skill payload from the canonical bootwitch-agents repo.

- Renamed the invoked skill from `agents` to `bootwitch-agents` to avoid collisions with
  other installed skills. **Breaking:** reinstall to `~/.claude/skills/bootwitch-agents`
  (or `~/.codex/skills/bootwitch-agents`) and invoke with `/bootwitch-agents`.
- Updated README, Claude, and Codex installation metadata for the new name.

## v0.2.0 - 2026-09-16

- Added a session overview/documentation role for every touched project.
- Added a generated documentation ledger to each session.
- Required evidence-based updates to project READMEs, architecture diagrams, and technical notes.
- Assigned reviewed versioning, commits, and pushes to the architecture/integration lead.
- Added project follow-up notes to the architecture template.

## v0.1.1 - 2026-09-16

- Replaced a machine-specific Claude Code installation path with portable GitHub installation metadata.
- Added Claude Code installation instructions to the public README.

## v0.1.0 - 2026-09-16

- Published the initial AGENTS coordination skill.
- Added bounded assignment, agent notes, handoff, architecture, and status templates.
- Added append-only shared-note conventions and a lock-protected append helper.
- Added a session generator for repeatable multi-agent runs.
- Documented integration-lead authority and evidence requirements.
