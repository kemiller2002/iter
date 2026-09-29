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

## CI observation discipline

- Keep incremental commits and pushes at coherent recovery boundaries.
- Do not wait for remote CI after every push; continue independent in-scope work while CI batches or runs.
- Inspect remote CI at the final implementation boundary by default.
- Inspect it earlier only when its result gates the next action, protects a high-risk boundary, or is required for merge/release/publication.
- Never treat queued, cancelled, unavailable, or unobserved CI as passing.

## Repository behavior

- Follow Ordo for state/engineering legality.
- Use Praxis for work state, checkpoints, provenance, and handoff once installed.
- Commit and push durable checkpoints frequently enough that another agent can resume.
- Record uncertainty instead of inventing evidence.
- Keep future website work separated from the library package.

<!-- BEGIN echelon:visual-engineering -->
## Visual Engineering UI research

Managed by `npx @echelon-foundry/visual-engineering`. Do not edit inside this block.

Before designing, implementing, or reviewing UI:

1. Run `npx @echelon-foundry/visual-engineering verify` and stop if it reports a failure.
2. Read `.visual-engineering/AGENT-INSTRUCTIONS.md`.
3. Read `.visual-engineering/UI-FOUNDATIONS.md`.
4. Read `.visual-engineering/UI-DECISION-CHECKLIST.md`.
5. Read `.visual-engineering/UI-ANTI-PATTERNS.md`.
6. Consult `.visual-engineering/RESEARCH-INDEX.md` for provenance and deeper evidence.
7. Inspect the product and its existing design system.
8. Apply the research as decision criteria, not as a visual style.
9. Report the context version, source commit, principles applied, verification
   performed, and justified deviations.

Do not copy Visual Engineering research into this repository by hand.
<!-- END echelon:visual-engineering -->

<!-- echelon:communication-engineering:start -->
## Communication Engineering

Communication Engineering is installed as evidence-bounded operational guidance.
Before producing consequential communication, read:

- `.communication-engineering/COMMUNICATION-FOUNDATIONS.md`
- `.communication-engineering/COMMUNICATION-DECISION-CHECKLIST.md`
- `.communication-engineering/PURPOSE-OUTCOME-MATRIX.md`
- `.communication-engineering/COMMUNICATION-ANTI-PATTERNS.md`
- `.communication-engineering/RESEARCH-STATUS.md`

Treat research maturity as a constraint. Do not turn provisional findings into universal rules, optimize persuasion at the expense of user autonomy, or substitute style for proof obligations.
<!-- echelon:communication-engineering:end -->

<!-- echelon:tutela:start -->
## Tutela security engineering

Tutela is installed as the repository security-engineering discipline.
Before making or changing a security claim, read:

- `.tutela/README.md`
- `.tutela/SECURITY-PROFILE.md`
- the applicable schema under `.tutela/schemas/`

Security claims are evidence-scoped. Unknown security effects remain unknown,
self-certification is not sufficient evidence, and an unsupported claim must
not be upgraded to a passing release posture.
<!-- echelon:tutela:end -->
