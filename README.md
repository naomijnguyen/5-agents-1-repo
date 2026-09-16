# 5 Agents, 1 Repo

**Five agents, one repo.** A Claude Code plugin for coordinating parallel coding agents
working in the same repository without overwriting each other's assumptions.

Bootwitch AGENTS turns a multi-agent repair or implementation into an evidence-producing workflow. It gives each agent bounded ownership, keeps cross-agent communication in an append-only ledger, and reserves architecture reconciliation for one integration lead.

The method grew out of **Bootwitch Doctor**, a five-agent repository repair experiment. The useful part was not simply running several agents at once. It was making their dependencies, handoffs, and proof visible enough to integrate safely.

## What It Provides

- current, backward, and target architecture traces;
- bounded assignment templates;
- project-specific agent notes;
- evidence-backed handoffs;
- append-only shared notes for cross-agent messages;
- a documentation ledger for every project touched by a session;
- evidence-based README, architecture-diagram, and technical-note updates;
- mutable status reports maintained by an integration lead;
- scripts for creating sessions and safely appending shared notes.

## Install

```bash
/plugin marketplace add naomijnguyen/5-agents-1-repo
/plugin install 5-agents-1-repo
```

Invoke the skill with `/bootwitch-agents`.

For Codex, or to install as a plain skill without the plugin system, use the sibling
repository [bootwitch-agents](https://github.com/naomijnguyen/bootwitch-agents).

## Start A Session

```bash
skills/bootwitch-agents/scripts/start_session.sh \
  storage-repair \
  architect storage boundary runtime verification
```

The generated directory contains shared architecture, documentation, and status files plus separate assignment, notes, and handoff documents for each agent. The session overview agent keeps project documentation synchronized; the architecture/integration lead reviews and performs authorized versioning, commits, and pushes.

## Append A Cross-Agent Note

Prepare an entry using `templates/shared-note-entry.md`, then append it through the lock-protected helper:

```bash
skills/bootwitch-agents/scripts/append_shared_note.sh \
  skills/bootwitch-agents/sessions/2026-09-16-storage-repair/handoffs/shared_notes.md \
  /tmp/agent-note.md
```

Existing entries are never rewritten. Corrections are new entries that reference the entry they supersede.

## Repository Layout

```text
.
├── .claude-plugin/plugin.json
├── config/{claude,openai}.yaml
└── skills/bootwitch-agents/
    ├── SKILL.md
    ├── OVERVIEW.md
    ├── ARCHITECTURE.md
    ├── handoffs/shared_notes.md
    ├── scripts/
    ├── sessions/
    └── templates/
```

See [OVERVIEW.md](skills/bootwitch-agents/OVERVIEW.md) for the working method and [ARCHITECTURE.md](skills/bootwitch-agents/ARCHITECTURE.md) for the coordination flow and file-authority model.

## Design Principles

1. Map before editing.
2. Fix connections, not only components.
3. Give every agent bounded ownership.
4. Preserve cross-agent history through append-only notes.
5. Require success, failure, and runtime evidence.
6. Reconcile accepted state through one integration lead.
7. Update touched-project documentation from accepted evidence.
8. Keep shared-checkout Git operations serial and owned by the integration lead.

## License

MIT. See [LICENSE](LICENSE).

Created by Jennifer Naomi Nguyen, built in collaboration with Claude (Anthropic) and Codex (OpenAI). The coordination method it describes was developed by working with both.
