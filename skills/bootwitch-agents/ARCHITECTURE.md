# Coordination Architecture

## Information flow

```mermaid
flowchart LR
    J[Session owner] --> L[Integration lead]
    L --> O[Session overview and acceptance gates]
    L --> A[Architecture traces]
    O --> W[Bounded agent assignments]
    A --> W
    O --> DOC[Session overview and documentation agent]

    W --> N1[Agent 1 notes]
    W --> N2[Agent 2 notes]
    W --> N3[Agent N notes]

    N1 --> H[Evidence-backed handoffs]
    N2 --> H
    N3 --> H
    N1 --> S[Append-only shared notes]
    N2 --> S
    N3 --> S

    S --> L
    H --> L
    L --> V[Independent verification]
    V --> T[Mutable session status]
    T --> DOC
    DOC --> PD[Project README, architecture, and technical docs]
    PD --> L
    L --> G[Reviewed commit, version, and push]
    T --> A
    A --> W
```

## File authority

| Artifact | Writers | Purpose |
|---|---|---|
| `OVERVIEW.md` | Session owner or integration lead | Goal, scope, constraints, and acceptance gates |
| `ARCHITECTURE.md` | Integration lead | Current, backward, and target traces |
| `DOCUMENTATION.md` | Session overview agent | Touched-project inventory and documentation readiness |
| `STATUS.md` | Integration lead | Accepted decisions and verified state |
| `agents/*/ASSIGNMENT.md` | Integration lead | Bounded ownership and dependencies |
| `agents/*/NOTES.md` | Assigned agent | Detailed working record and local findings |
| `agents/*/HANDOFF.md` | Assigned agent | Evidence-backed completion report |
| `handoffs/shared_notes.md` | All agents, append only | Cross-agent messages, dependencies, and corrections |
| Project `README.md`, `ARCHITECTURE.md`, diagrams, and `TECHNICAL.md` | Session overview agent, reviewed by integration lead | Verified public and technical project documentation |

## Shared-note protocol

Every entry has a stable ID, timestamp, session, sender, recipients, scope, evidence, requested action, and status. Entries are never changed after append.

If an entry is wrong:

1. Append a correction.
2. Set `Supersedes` to the earlier entry ID.
3. Explain what changed and why.
4. Let the integration lead update the mutable status and architecture if the correction is accepted.

This preserves the reasoning trail without making the current state hard to find.

## Architecture traces

Each session should maintain three views:

- **Current trace:** what the repository actually does now.
- **Backward trace:** what must have happened for the final observable result to exist.
- **Target trace:** the smallest corrected flow that satisfies the acceptance gates.

Color nodes and connections by evidence:

- Green: proved end to end.
- Amber: component works, connection or failure behavior is not proved.
- Red: broken, missing, or contradicted by evidence.
- Gray: outside the current repair scope or not yet inspected.

## Follow-up notes

Use the session architecture map's follow-up table for project ideas, technical debt, and questions that should survive the session but do not belong in its current scope. These notes are not accepted work until moved into a future session's scope and acceptance gates.
