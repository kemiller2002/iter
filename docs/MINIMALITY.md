# Iter Minimality Contract

Iter is intentionally optimized for smallness, explicitness, and low conceptual load.

## Default answer to a new feature

No.

A capability enters Iter only after evidence shows repeated application-level need and a meaningful correctness or duplication benefit.

## Budget

Initial production budget:
- fewer than or equal to 1,000 non-generated F# source lines;
- zero external runtime dependencies;
- zero external test/build package dependencies unless specifically approved;
- one production NuGet package;
- no background runtime;
- no browser access;
- no reflection-based discovery;
- no rendering authority.

The CI build enforces the source-line budget. Package size is reported on every build.

Crossing each additional 1,000-line production boundary requires a deliberate architecture decision rather than incidental accumulation.

## Dependency permission

No external dependency is implicitly allowed.

A dependency may be introduced only after explicit human permission naming the dependency and intended scope/version. This applies to runtime packages, test frameworks, analyzers, source generators, tools, and vendored libraries. Echelon packages are not automatically exempt.

The .NET SDK/BCL and the F# platform supplied with the selected SDK are platform dependencies and do not require separate approval.

Dependency approval must not be inferred from approval of a feature.

## Placement test

Put a capability in:
- **Limen** when it is a minimal browser capability crossing the browser/application boundary;
- **Iter** when it is a small reusable application-side web primitive independent of rendering/business meaning;
- **Forma** when it is reusable presentation;
- **Aegis** when it is unexpected operational-failure handling;
- **the application** when it contains application meaning or does not recur enough to justify shared infrastructure.

Repetition alone is not enough. The concern must belong to Iter's authority.

## Current admitted family

- typed route parse/format;
- relative web location;
- web path/base-path handling;
- query parse/format;
- URI-component encoding needed by those primitives;
- typed push/replace navigation intent.

Everything else starts excluded.

## Anti-goal

Iter must never become "our React", "our Angular", "our Blazor", or a generic `Echelon.Common` dumping ground.

Its mature state should have very little reason to grow.
