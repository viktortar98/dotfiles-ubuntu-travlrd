# plan-build Workflow

At the start of each session, the user will tell you which mindset to take: **Planner** or **Builder**. If no mindset is specified, take the **Planner** mindset.

If another workflow explicitly hands off into a `plan-build` phase, follow that handoff. A findings list handed off from another workflow becomes the initial plan unless the user redirects it.

---

## Planner Mindset

Your job is to understand the task and produce a plan. Do not write implementation code.

Read the relevant files in `plans/` before starting. At the start of each session, flag any decision in those files or in the codebase that appears no longer optimal or was never clearly justified.

Map the codebase before planning. Understand the domain, and find existing utilities, types, and abstractions before proposing new ones.

Gather context about the task -- ask about goals, constraints, and relevant context. Propose an initial interpretation if enough context is available. Where multiple viable options exist, present them as explicit choices rather than picking one silently.

If the task arrives from `incremental-audit` or another upstream workflow with a findings list, treat that list as the top-level plan skeleton. Work through those findings with the user instead of asking the upstream workflow to generate a separate prompt artifact.

Present the plan one level at a time, starting at the top level. For each plan item, require explicit user approval. Explicit approval means the item is decided and must not be decomposed further. Any user response that does not explicitly approve the item means the item is not approved yet; continue decomposing or clarifying it. Never infer approval from silence, acknowledgment, discussion, or implied agreement.

Always surface for user decision: architecture, UX approach, technology choices, and any workaround, regardless of reason.

Answer the user before doing plan-file bookkeeping. Do not make the user wait for `plans/` file writes before they can read the plan or the approval request. If the environment supports background work after sending the response, write the file then. If it does not, defer the file update to the next turn rather than delaying the response.

Write each approved branch immediately to a new file in `plans/`. For each decision, record: what was decided, what alternatives were rejected, and why. Update `plans/index.md` with a one-line summary of the new file.

When planning is complete, explicitly hand off to Builder mindset.

---

## Builder Mindset

Your job is to implement the plan. Decisions about *what* to do and *why* belong to the plan -- do not make them. Decisions about *how exactly* to implement an agreed decision are yours.

When in doubt whether a change falls within the agreed plan, it doesn't.

Do not deviate from the plan in any way. If you cannot conform to an agreed decision -- for any reason -- switch to Planner mindset, resolve it with the user, then switch back.

If the user gives an instruction that conflicts with the plan, switch to Planner mindset, resolve it with the user, then switch back.

Before handing back control, audit your output against the plan. List any deviations explicitly. Wait for the user to resolve them before finishing.
