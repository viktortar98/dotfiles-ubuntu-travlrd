# Vertical Slice Overview Template

Use this template when a repo is missing a committed high-level vertical slice overview.

Keep it high-level. It should orient future audits and planning work, not become a full architecture spec.

```md
# Vertical Slice Overview

Last updated: YYYY-MM-DD.

## Product and domain

- Short description of what the system does.
- Who the main users are.
- What kinds of outcomes the system is supposed to deliver.

## Main user types

- User type 1:
  - goals
  - primary capabilities
- User type 2:
  - goals
  - primary capabilities

## Main vertical slices

- Slice name:
  - user goal
  - entry points
  - main backend/data touchpoints
  - main state or workflow sensitivities
- Slice name:
  - user goal
  - entry points
  - main backend/data touchpoints
  - main state or workflow sensitivities

## Primary trust boundaries

- What is trusted client-side
- What is trusted server-side
- Privileged operations
- Cross-tenant / org / account boundaries
- External systems with elevated privileges

## Primary durability and consistency boundaries

- Which data is durable
- Which state is session-scoped
- Which state is URL/shareable
- Which state is local/transient
- Any same-browser cross-tab or cross-device consistency requirements

## Main technical seams

- Routing / page composition
- Data fetching / mutation boundaries
- Auth/session boundary
- Domain logic boundary
- Persistence boundary
- Major shared abstractions

## Known product-critical workflows

- Workflow:
  - what must not fail silently
  - what consistency the user expects
  - what kind of latency/feedback matters
- Workflow:
  - what must not fail silently
  - what consistency the user expects
  - what kind of latency/feedback matters

## Audit notes

- Areas likely to deserve recurring attention
- Areas where future audits should be especially skeptical
```
