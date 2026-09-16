# Sessions

Each folder here is one bounded multi-agent run. Use a stable identifier such as `2026-09-16-storage-repair`.

Create a session with:

```bash
../scripts/start_session.sh storage-repair agent-1 agent-2 agent-3
```

The generated session contains shared architecture, documentation, and status files plus a project-specific assignment, notes file, and handoff for each named agent.

Name a session overview agent in `OVERVIEW.md`. That agent maintains `DOCUMENTATION.md` and updates the README, architecture diagrams, and technical notes for every project touched by the session. After evidence and documentation review, the architecture/integration lead performs any authorized commit, version, and push.

Session shared notes are append-only. When a lesson should persist beyond one run, append a concise version to `AGENTS/handoffs/shared_notes.md` and include the session ID.
