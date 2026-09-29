# Iter Agent Guide

Iter is Echelon Foundry's small, optional .NET library for typed application-side web primitives.

## Start here

Read, in order:
1. `PROJECT-CHARTER.md`
2. `requirements/REQUIREMENTS.md`
3. `docs/architecture/ARCHITECTURE.md`
4. `context/CURRENT-STATE.md`

Then read and obey any installed Ordo, Praxis, Visual Engineering, Communication Engineering, and Tutela instructions.

## Non-negotiable rules

- Keep Iter small. Feature growth is a cost, not a success metric.
- Iter is not a web framework.
- Limen remains the browser/application boundary; Iter must not absorb Limen authority.
- Limen must never depend on Iter.
- Iter must not own rendering, DOM mutation, components, application lifecycle, dependency injection, state management, forms, templating, reconciliation, scheduling, or business semantics.
- Prefer pure F# and explicit domain types.
- Runtime dependencies default to zero. Any proposed dependency requires explicit architectural justification.
- External effects stay outside the core.
- Warnings are errors.
- Public API additions require tests and a minimality review.
- Do not add capability merely because React, Angular, Blazor, or another framework has it.
- A capability belongs in Iter only when it is reusable application-side interpretation or coordination above the browser boundary.

## Repository behavior

- Follow Ordo for state/engineering legality.
- Use Praxis for work state, checkpoints, provenance, and handoff once installed.
- Commit and push durable checkpoints frequently enough that another agent can resume.
- Record uncertainty instead of inventing evidence.
- Keep future website work separated from the library package.
