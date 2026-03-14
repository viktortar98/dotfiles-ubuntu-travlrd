# incremental-audit Workflow

Use this workflow only when the user explicitly invokes `incremental-audit`.

Supporting artifacts installed with this workflow:
- Prompt: `~/.agents/prompts/project-derived-incremental-audit.md`
- Templates:
  - `~/.agents/templates/vertical-slice-overview-template.md`
  - `~/.agents/templates/problem-log-template.md`

## Purpose

This workflow replaces a one-shot audit plus one-shot remediation plan with an iterative loop:

1. discover a small related batch of meaningful problem classes
2. stop for user decision
3. if a problem class should be addressed now, hand it off to a dedicated remediation `plan-build` session
4. log every surfaced problem class and its outcome
5. resume discovery from the next high-leverage unexplored area

The audit should identify what deserves intervention. It should not silently design fixes during the audit itself.

## Audit shape

The audit should:
- be project-derived, not checklist-derived
- use first-principles discovery
- treat prewritten examples as illustrative, not exhaustive
- avoid hidden full-repo audits before surfacing the first batch

The audit should surface:
- roughly 3-6 problem classes per batch
- grouped by related surface or concern where possible

Each surfaced problem class should include:
- title
- why it matters
- violated principle
- evidence
- likely scope
- recommendation:
  - `address_now`
  - `defer`
  - `ignore`
  - `monitor`

The audit must not include:
- implementation plans
- detailed remediation design
- example-only fix suggestions disguised as broad recommendations

Implementation planning belongs in the remediation `plan-build` session.

## Fixed core

Always include:
- trust boundaries and authorization
- static verification rigor
- architecture and boundaries

## Strongly recommended dimensions

The agent must actively consider these and include the relevant ones for the project:
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

If a strongly recommended dimension is omitted, the audit should say why.

## Cross-cutting lenses

Apply these across the audit instead of treating them as mandatory standalone dimensions:
- UX continuity and feedback quality
- whether existing abstractions help or hurt
- whether new abstractions, layers, patterns, or technology are justified
- whether the current technical choices align with the UX the app must provide
- whether the team is harvesting the benefits of the chosen stack

## How to choose what to inspect next

The audit should not try to fully audit everything before surfacing the first batch.

Choose the next inspection target intentionally, in this order:
1. highest-risk surfaces
2. highest-fan-out surfaces
3. most product-critical vertical slices
4. localized or secondary concerns

Good starting surfaces often include:
- auth/session
- privileged backend operations
- cross-cutting data access
- primary user workflows
- places where static guarantees are weak
- shared infrastructure and reused abstractions

Prefer surfaces where one finding is likely to reveal a broader problem class.

## Completeness expectation

When a problem class is surfaced, the audit should be:
- locally exhaustive within the currently inspected slice or surface
- not necessarily globally exhaustive across the entire repo yet

This avoids both:
- sample-only auditing
- hidden giant audits

Repo-wide completeness for a problem class belongs to the dedicated remediation session when that problem is approved for action.

## Vertical slice overview

Each repo should ideally contain a committed high-level vertical slice overview.

If it is missing:
- the agent should propose one
- this proposal belongs in the first audit batch
- it should only be saved after user agreement
- the starter shape is available at `~/.agents/templates/vertical-slice-overview-template.md`

## Problem log

The audit should consult the problem log before surfacing something as new.

The problem log is intentionally lightweight. Each entry should include:
- title
- status
- recommendation
- severity
- rationale
- `where`: file and line
- `git_commit_id`
- evidence

Recommended common statuses:
- `new`
- `triaged`
- `in_progress`
- `resolved`
- `deferred`
- `ignored`

The set of statuses and fields may be extended per repo as needed.

Use `~/.agents/templates/problem-log-template.md` as the starter shape when a repo does not already have one.

## Recommendation semantics

Use:
- `address_now`
  - the issue is severe enough and concrete enough to justify immediate remediation planning
- `defer`
  - the issue is real, but fixing it now is likely premature or likely to encode the wrong abstraction
- `ignore`
  - the issue is not worth addressing
- `monitor`
  - the issue is plausible but not yet well-enough evidenced for remediation

Decision criteria should be based primarily on:
- severity
- questionability

Questionability means whether the issue unquestionably needs to be addressed now, versus being real but still context-sensitive or premature.

## Remediation handoff

For each problem class recommended for action, the audit should emit a dedicated remediation `plan-build` prompt.

That remediation prompt must carry forward:
- problem-class title
- why it matters
- violated principle
- evidence
- likely scope
- recommendation from the audit
- explicit note if the issue is questionable or context-sensitive

If the recommendation is `defer`:
- still log the problem class
- do not emit a remediation prompt unless the user asks for one

## Remediation session responsibility

The remediation `plan-build` session is responsible for:
- finding and addressing all instances of the problem class within the agreed scope
- not just fixing the examples from the audit

The remediation session may challenge the audit recommendation if the class turns out to be:
- over-broad
- mis-scoped
- premature

By default, full instance-finding belongs to the Builder phase.

If the Planner sees meaningful risk that the fix should not be applied uniformly across all matching cases, the Planner should ask the user to decide before handing off.
