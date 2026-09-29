# Iter Minimality Contract

Iter is intentionally optimized for smallness, explicitness, and low conceptual load.

## Default answer to a new feature

No.

A capability enters Iter only after evidence shows repeated application-level need and a meaningful correctness or duplication benefit.

## Budget

Initial production budget:
- fewer than or equal to 1,000 non-generated F# source lines;
- zero third-party runtime package dependencies;
- one production NuGet package;
- no background runtime;
- no browser access;
- no reflection-based discovery;
- no rendering authority.

The CI build enforces the source-line budget. Package size is reported on every build.

Crossing each additional 1,000-line production boundary requires a deliberate architecture decision rather than incidental accumulation.

## Placement test

Put a capability in:
- **Limen** when it is a minimal browser capability crossing the browser/application boundary;
- **Iter** when it is a small reusable application-side web primitive independent of rendering/business meaning;
- **Forma** when it is reusable presentation;
- **the application** when it contains application meaning or does not recur enough to justify shared infrastructure.

## Anti-goal

Iter must never become "our React", "our Angular", or "our Blazor". Its mature state should have very little reason to grow.
