# negotiate Protocol

Use this protocol only when the user explicitly invokes `negotiate`, or when another protocol explicitly hands off into it.

Your job is to understand the task and produce an approved plan. Do not write implementation code.

Read the relevant files in `plans/` before starting. At the start of each session, flag any decision in those files or in the codebase that appears no longer optimal or was never clearly justified.

Map the codebase before planning. Understand the domain, and find existing utilities, types, and abstractions before proposing new ones.

Gather context about the task. Ask about goals, constraints, and relevant context when needed. Propose an initial interpretation if enough context is available. Where multiple viable options exist, present them as explicit choices rather than picking one silently.

If the task arrives from `audit` or another upstream protocol with a findings list, treat that list as the top-level plan skeleton. Work through those findings with the user instead of asking the upstream protocol to generate a separate prompt artifact.

Present the plan one level at a time, starting at the top level. At each level, surface all currently pending sibling plan items together in one response so the user can decide multiple or all of them in the same message. Do not force the user through one-by-one approval turns when multiple pending items already exist at the current level.

Number every presented plan item and every presented option using hierarchical Arabic notation so the user can reference any item precisely. Use `1`, `2`, `3` for top-level items, `1.1`, `1.2` for children of item `1`, `1.1.1` for grandchildren, and so on. When presenting options under a plan item, number them within that item's hierarchy so the user can reply with references like `2.1` or `3.2.1` unambiguously.

For each plan item, require explicit user approval. Explicit approval means the item is decided and must not be decomposed further. Any user response that does not explicitly approve the item means the item is not approved yet; continue decomposing or clarifying it. Never infer approval from silence, acknowledgment, discussion, or implied agreement.

When the user responds to a batched set of pending items, resolve every item they addressed in that same turn. Re-present only the still-pending items, along with any new child items created by decomposition, again grouped together by the current level.

Always surface for user decision: architecture, UX approach, technology choices, and any workaround, regardless of reason.

Do not update `plans/` during iterative decomposition or approval turns. Keep the working plan in the conversation until every decomposed item in the selected branch is explicitly approved.

When planning is complete, create the plan file in one go right before handing off to `execute`. Write a new file in `plans/` that records the full approved branch, including for each decision: what was decided, what alternatives were rejected, and why. Update `plans/index.md` with a one-line summary of the new file as part of that same finalization step.

Only hand off to `execute` after the final approved plan has been written to `plans/`.
