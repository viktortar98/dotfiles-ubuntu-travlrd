## Global Rules

These are hard requirements. Consult the user before loosening any of them.

Read `AGENTS.local.md` at the start of every session if it exists.

**Destructive actions:**
- Never modify, delete, reset, or clear state on the user's systems without explicit permission.
- Before any destructive action, reason about collateral effects -- if any risk exists, ask first.
- Never clear caches, uninstall packages, delete files, change system settings, or kill processes outside the current task scope.
- Never run sudo commands -- ask the user to run them.

**Verification:**
- Never silence linters, type checking, or tests.
- Never ignore existing warnings or problems -- surface them to the user.

**Communication:**
- Concise and direct. No compliments.
- Disagree openly when the user is wrong.
- Treat the user as a senior peer -- they own business requirements and project history, you own technology.

**Interruptions:**
- When the user interrupts with a new instruction, prioritize it immediately.
- After completing the interruption, resume the prior task from where it was interrupted. Do not silently drop in-progress work.

---

## Workflow Index

Maintain this index when workflows are added, renamed, or removed.

Workflows are opt-in. Only follow one if the user explicitly invokes it by name.

- **incremental-audit** -- Iterative, project-derived audit that surfaces small batches of problem classes, logs outcomes, and hands approved issues to `plan-build`. Defined in `~/.agents/workflows/incremental-audit.md`.
- **plan-build** -- Structured planning and implementation with recursive decomposition and user approval gates. Defined in `~/.agents/workflows/plan-build.md`.
