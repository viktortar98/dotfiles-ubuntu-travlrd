# Project-Derived Incremental Audit Prompt

Use this prompt when starting an incremental codebase quality audit.

```text
Run an incremental, project-derived audit of this codebase.

Use the `incremental-audit` workflow from `~/.agents/workflows/incremental-audit.md`.

Do not run a giant one-shot audit. Do not start by producing a full implementation plan.

Your job is to discover meaningful problem classes in small related batches, stop for user decision, and then switch directly into the `plan-build` Planner phase with the current findings batch as the initial plan.

Core stance:
- use first-principles discovery
- do not let prewritten examples narrow the search space
- do not confuse passing checks with real quality
- prefer enforceable structure over convention, luck, or team memory
- do not silently design fixes during audit

Process:
1. Inspect the codebase and infer the most important vertical slices, trust boundaries, and architectural seams.
2. If the repo does not already contain a high-level vertical slice overview, include a proposed one in the first batch. Use `~/.agents/templates/vertical-slice-overview-template.md` for the shape.
3. Choose the next inspection target intentionally:
   - highest-risk surfaces first
   - then highest-fan-out surfaces
   - then most product-critical vertical slices
   - then more localized concerns
4. Surface a small related batch of roughly 3-6 problem classes.
5. Stop for user decision after each batch, then switch into the `plan-build` Planner phase.
6. Treat the current findings batch as the initial plan. Do not generate a separate remediation prompt first.
7. Log every surfaced problem class and its outcome.
8. Consult the problem log before surfacing something as new. Use `~/.agents/templates/problem-log-template.md` as the starter shape if the repo does not already have a committed log.

Fixed core to always include:
- trust boundaries and authorization
- static verification rigor
- architecture and boundaries

Strongly recommended dimensions to consider and include when relevant:
- state ownership by lifetime and fan-out
- data flow and async flow
- error handling and failure semantics
- loading/performance behavior
- pattern system quality and consistency
- idiomatic stack usage / stack alignment
- product-fit of technical choices
- domain invariants / workflow correctness
- operational / observability concerns
- data model / migration safety
- integration boundaries
- concurrency / idempotency

Cross-cutting lenses:
- UX continuity and feedback quality
- whether existing abstractions help or hurt
- whether new abstractions, layers, patterns, or technology are justified
- whether current technical choices align with the UX the app must provide
- whether the team is harvesting the benefits of the chosen stack

For each surfaced problem class, include:
- title
- why it matters
- violated principle
- evidence
- likely scope
- recommendation:
  - address_now
  - defer
  - ignore
  - monitor

Decision criteria:
- severity
- questionability

Questionability means whether the issue unquestionably needs to be addressed now, versus being real but context-sensitive, premature, or likely to produce the wrong abstraction if fixed immediately.

Completeness expectation:
- each surfaced problem class should be locally exhaustive within the currently inspected slice or surface
- do not wait for full repo-wide exhaustiveness before surfacing the class

Audit constraints:
- do not include implementation plans in the audit batch
- do not prewrite the later plan or generate a remediation prompt artifact
- if a strongly recommended dimension is omitted, say why
- stay open to project-derived dimensions outside the prewritten categories
- omission from the prompt does not imply lower importance

When switching into `plan-build` planning, carry each finding forward as a top-level plan item with:
- problem-class title
- why it matters
- violated principle
- evidence
- likely scope
- audit recommendation
- explicit note if the issue is questionable or context-sensitive

The planning phase that follows the audit must:
- find and address all instances of the problem class within the agreed scope
- not just fix the examples from the audit
- challenge the recommendation if the class turns out to be over-broad, mis-scoped, or premature
- keep `defer`, `ignore`, and `monitor` findings as explicit disposition items until the user approves them
```
