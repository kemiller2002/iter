# Iter Current State

Date: 2026-09-29

## Established

- Public repository exists.
- Project charter and initial requirements are defined.
- Minimality is Requirement 0.
- F#/.NET 10 is the implementation direction.
- Typed routing is the first vertical slice.
- The first pure route codec and typed navigation intent compile and pass the repository test executable.
- NuGet packaging is configured as `EchelonFoundry.Iter` version `0.1.0`.
- CI builds, tests, enforces the initial 1,000 production-line budget, and inspects package contents.
- A release workflow is present for NuGet publishing.
- Future public site requirements and GitHub Pages deployment expectations are documented.
- Iter is optional and must not become a Limen dependency.

## Installed Echelon governance

Installed and verified through each owning lifecycle tool:

- Praxis / Repository Operating System: 3.6.0
- Ordo / State-Directed Engineering: 1.4.0
- Visual Engineering: 1.0.0
- Communication Engineering: 1.0.0
- Tutela: 0.1.0

The desired baseline is recorded in `.echelon/desired-components.json`, and the native engineering toolchain is pinned in `.echelon/toolchain.json`.

## Recorded current Echelon application systems

The repository also records the current Limen, Forma, Folio, Aegis, Dokimos, and Conditor versions/revisions for integration planning. They are deliberately not Iter runtime dependencies.

- Limen is reserved for the future site's browser boundary.
- Forma is reserved for future site presentation.
- Folio is reserved for a future print requirement, if one appears.
- Aegis is reserved for a future effectful operational boundary, if one appears.
- Dokimos is planned for quality dogfooding when its library integration path is stable.
- Conditor is the intended empty-repository orchestration path once its compatibility catalog qualifies the current Praxis/Ordo releases.

## Next

1. Keep the routing API deliberately small while proving it in a real consuming application.
2. Add URI/path/query primitives only when the routing proof demonstrates repeated need.
3. Keep production source below the initial 1,000-line budget.
4. Create the public site only after the routing surface stabilizes.
5. Register Iter with broader Echelon administration/inventory when that integration path is available.
