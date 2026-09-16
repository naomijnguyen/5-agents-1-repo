# Shared Notes

This is the durable cross-session ledger for AGENTS. It is append-only.

## Rules

1. Never edit, delete, reorder, or silently clarify an existing entry.
2. Append corrections as new entries and reference the original ID in `Supersedes`.
3. Put detailed investigation in the agent's own `NOTES.md`; use this ledger for information another agent or session needs.
4. Treat entries as reported evidence until the integration lead records an accepted decision in the session `STATUS.md`.
5. Prefer `scripts/append_shared_note.sh` for concurrent writes.

---

<!-- Append new entries below this line. -->

