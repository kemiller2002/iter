# Iter Requirements

Status: initial approved baseline

## R0 - Minimality

R0.1 Iter SHALL remain an optional library and SHALL NOT become a required dependency of Limen.

R0.2 The core package SHALL target zero runtime package dependencies. A runtime dependency MAY be added only with documented evidence that the capability cannot reasonably remain small, deterministic, and maintainable without it.

R0.3 Every public API addition SHALL identify the repeated application problem it solves and SHALL be evaluated against a simpler application-local implementation.

R0.4 Iter SHALL NOT implement capability solely for parity with React, Angular, Blazor, or another framework.

R0.5 Iter SHALL NOT own rendering, DOM mutation, component lifecycle, dependency injection, application lifecycle, global application state, forms, templating, reconciliation, scheduling, or business-domain semantics.

R0.6 The package SHALL remain usable without the future Iter website.

## R1 - Architecture boundary

R1.1 Limen SHALL own browser capability access.

R1.2 Iter SHALL own only optional reusable interpretation/coordination above the Limen boundary.

R1.3 Browser effects SHALL be represented as data or application intent in Iter core; execution of those effects SHALL occur outside Iter core.

R1.4 Limen SHALL NOT reference or depend upon Iter.

R1.5 Iter SHALL NOT require Limen to use pure functionality such as parsing and formatting.

## R2 - Routing

R2.1 Iter SHALL provide a typed codec abstraction that allows an application-defined route type to be parsed from a location/URI representation and formatted back to that representation.

R2.2 Parsing failure SHALL be explicit data and SHALL NOT throw for ordinary invalid route input.

R2.3 Route formatting SHALL be deterministic for deterministic route values.

R2.4 A route codec SHOULD support a testable round-trip property: parse(format(route)) returns the original route for all supported route values.

R2.5 Iter SHALL NOT prescribe an application route discriminated union or route-table shape.

R2.6 Iter SHALL NOT require reflection-based route discovery.

R2.7 Routing SHALL remain independent of rendering.

## R3 - Navigation intent

R3.1 Iter MAY represent typed navigation intent such as push and replace.

R3.2 Navigation intent SHALL NOT directly invoke browser history APIs from the core package.

R3.3 Translation between Iter navigation intent and Limen history/location effects SHALL live in an adapter or consuming application boundary.

## R4 - URI, path, and query primitives

R4.1 Additional URI/path/query helpers MAY be introduced only when routing implementations demonstrate repeated need.

R4.2 Helpers SHALL preserve distinctions between missing, empty, invalid, and present values when those distinctions affect semantics.

R4.3 Query parsing SHALL NOT silently discard duplicate keys or malformed input unless the API explicitly states and types that policy.

R4.4 Percent encoding/decoding behavior SHALL be explicit and standards-aligned when implemented.

## R5 - F# and .NET

R5.1 The initial implementation SHALL be F#.

R5.2 Public .NET types SHOULD remain consumable from C# where doing so does not materially degrade the F# model.

R5.3 Invalid states SHOULD be made unrepresentable where practical through discriminated unions, constrained construction, and total functions.

R5.4 Warnings SHALL be treated as errors.

## R6 - Quality

R6.1 Core behavior SHALL have deterministic tests.

R6.2 Tests SHALL initially avoid third-party test-framework dependencies unless their value justifies the dependency.

R6.3 Public API behavior SHALL be covered before release.

R6.4 Packaging SHALL be verified in CI.

R6.5 Iter SHOULD dogfood Dokimos once Dokimos has a stable install/integration path for libraries.

## R7 - Packaging

R7.1 Iter SHALL be publishable as a NuGet package.

R7.2 The initial package identity SHALL be `EchelonFoundry.Iter`.

R7.3 Release publication SHALL occur through GitHub Actions rather than requiring a developer workstation.

R7.4 Package metadata SHALL identify the source repository and MIT license.

## R8 - Echelon governance

R8.1 Iter SHALL follow the current Ordo and Praxis governance.

R8.2 Visual Engineering and Communication Engineering SHALL govern the future public site and communication surfaces.

R8.3 Tutela SHALL govern security claims and security-specific invariants.

R8.4 Aegis SHALL be introduced only if Iter gains an effectful boundary where unexpected operational faults need shared handling; pure parsing/routing failures remain Iter domain outcomes.

R8.5 Forma and Limen SHALL be used for the future site when appropriate, without becoming runtime dependencies of the Iter NuGet library.

R8.6 Folio SHALL be used only if Iter later needs printable/paginated artifacts.

R8.7 Conditor SHOULD eventually be able to establish Iter's standard development environment from an empty repository.

## R9 - Website

R9.1 Iter SHALL eventually have a public site at an Echelon Foundry domain.

R9.2 The site SHALL be deployed through GitHub Actions and GitHub Pages unless a later requirement justifies a different host.

R9.3 The site SHALL share Echelon Foundry visual foundations and reusable site primitives.

R9.4 Site source, build dependencies, and assets SHALL remain isolated from the Iter NuGet package.

R9.5 The site SHALL use Limen only as a browser boundary and SHALL keep application meaning outside Limen.

## R10 - Size budgets

R10.1 The first routing release SHOULD keep the production library below 1,000 non-generated source lines.

R10.2 Any change that causes production source to cross a 1,000-line boundary increment SHALL require an explicit architecture review explaining the growth.

R10.3 The core package SHALL have zero transitive third-party runtime dependencies at initial release.

R10.4 CI SHALL report production source-line count and package size so growth is visible.
