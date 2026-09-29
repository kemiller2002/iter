# Iter Requirements

Status: expanded planning baseline

The detailed cross-repository evidence and placement decisions are recorded in `requirements/COMMONALITIES.md`.

## R0 - Minimality

R0.1 Iter SHALL remain an optional library and SHALL NOT become a required dependency of Limen.

R0.2 Iter SHALL have zero external package dependencies by default. No runtime, build, test, analyzer, source-generator, or other package dependency MAY be added without explicit human permission for that specific dependency.

R0.3 Every public API addition SHALL identify the repeated application problem it solves and SHALL be evaluated against a simpler application-local implementation.

R0.4 Iter SHALL NOT implement capability solely for parity with React, Angular, Blazor, or another framework.

R0.5 Iter SHALL NOT own rendering, DOM mutation, component lifecycle, dependency injection, application lifecycle, global application state, forms, templating, reconciliation, scheduling, or business-domain semantics.

R0.6 The package SHALL remain usable without the future Iter website.

R0.7 Feature count, abstraction count, public API size, source size, package size, and dependency count SHALL all be treated as costs.

R0.8 The default response to a proposed feature is exclusion until placement and repeated need are demonstrated.

## R1 - Architecture boundary

R1.1 Limen SHALL own browser capability access.

R1.2 Iter SHALL own only optional reusable interpretation/coordination above the Limen boundary.

R1.3 Browser effects SHALL be represented as data or application intent in Iter core; execution of those effects SHALL occur outside Iter core.

R1.4 Limen SHALL NOT reference or depend upon Iter.

R1.5 Iter SHALL NOT require Limen to use pure functionality such as parsing and formatting.

R1.6 Application/domain state, route meaning, authorization, legal transitions, obligations, and business rules SHALL remain application-owned.

R1.7 A reusable concern SHALL NOT move into Iter merely because it appears in multiple engineering tools. It must be an application-side web primitive.

## R2 - Routing

R2.1 Iter SHALL provide a typed codec abstraction that allows an application-defined route type to be parsed from a location representation and formatted back to a relative web URL/location representation.

R2.2 Parsing failure SHALL be explicit data and SHALL NOT throw for ordinary invalid route input.

R2.3 Route formatting SHALL be deterministic for deterministic route values.

R2.4 A route codec SHOULD support a testable round-trip property: parsing a formatted supported route returns the original route.

R2.5 Iter SHALL NOT prescribe an application route discriminated union or route-table shape.

R2.6 Iter SHALL NOT require reflection, attributes, runtime discovery, source generation, or registration containers for routing.

R2.7 Routing SHALL remain independent of rendering.

R2.8 Route parsing SHALL be syntactic. Whether a syntactically valid route names an existing domain entity remains application state/resolution logic.

R2.9 Route precedence and ambiguity resolution SHALL be explicit in application-owned parsing rather than hidden in Iter registration order.

R2.10 Route parameter conversion SHALL use caller-owned parsers/codecs or small Iter primitives. Iter SHALL NOT maintain a global conversion registry.

R2.11 Canonicalization, when used, SHALL be explicit and pure. Parsing MUST NOT silently rewrite a location.

## R3 - Relative location and navigation intent

R3.1 Iter MAY represent typed navigation intent such as push and replace.

R3.2 Navigation intent SHALL NOT directly invoke browser history APIs from the core package.

R3.3 Translation between Iter navigation intent and Limen history/location effects SHALL live in an adapter or consuming application boundary.

R3.4 Iter SHOULD provide a pure relative-location value composed of path, query, and fragment without origin authority.

R3.5 Relative-location values SHALL be constructible and usable without Limen.

R3.6 Iter SHALL NOT perform cross-origin navigation or decide whether navigation is allowed by the browser.

R3.7 Browser-originated location adoption SHALL NOT automatically create push/replace intent. The application must be able to adopt Back/Forward location changes without creating a navigation loop.

R3.8 Iter MAY provide a pure way to detect navigation to the already-current canonical relative URL so consumers can avoid duplicate history entries.

R3.9 Back and Forward browser operations remain Limen capabilities unless repeated .NET application evidence demonstrates a missing application-side abstraction.

## R4 - Paths and base paths

R4.1 Iter SHALL provide only the path primitives required by proven routing use cases.

R4.2 Path handling SHALL distinguish encoded input from decoded segment values where that distinction affects round-trip correctness.

R4.3 Path parsing SHALL define behavior for root paths, empty segments, repeated separators, and trailing separators. These cases SHALL NOT be silently collapsed unless the caller selects an explicit normalization operation.

R4.4 Path formatting SHALL be deterministic.

R4.5 A base path SHALL be an explicit value rather than an undocumented string convention.

R4.6 Combining an application path with a base path SHALL produce a relative URL under that base and SHALL NOT accidentally target the site root.

R4.7 Base-path behavior SHALL support applications hosted beneath a subdirectory, including static hosting such as GitHub Pages.

R4.8 Iter SHALL NOT provide a route-table DSL, controller system, page registry, middleware pipeline, or server routing framework.

## R5 - Query strings

R5.1 Iter SHALL provide a small query representation when the routing slice reaches query support.

R5.2 Query parsing SHALL preserve duplicate keys.

R5.3 Query parsing SHALL preserve the distinction between a key with no value and a key with an empty value when the input syntax distinguishes them.

R5.4 Query parsing SHALL NOT silently discard malformed input.

R5.5 Query formatting SHALL be deterministic.

R5.6 Query parsing/formatting SHALL define whether source ordering is preserved. The initial implementation SHOULD preserve pair order because duplicate-key order can be meaningful to consuming applications.

R5.7 Convenience accessors MAY provide first, last, all, or single-value interpretations, but those interpretations MUST be explicit and MUST NOT change the canonical representation.

R5.8 Query support SHALL NOT become a form binding, model binding, validation, or request framework.

## R6 - URI component encoding

R6.1 Percent encoding and decoding behavior SHALL be explicit and standards-aligned.

R6.2 Iter SHALL use .NET platform URI functionality where sufficient rather than adding an external URI dependency.

R6.3 Path-segment encoding and query-component encoding SHALL NOT be conflated if their escaping rules differ.

R6.4 Decode failure SHALL be represented explicitly rather than replaced with the undecoded input without notice.

R6.5 Iter SHALL NOT normalize or decode an entire URL in a way that loses component boundaries.

## R7 - F# and .NET

R7.1 The initial implementation SHALL be F#.

R7.2 Public .NET types SHOULD remain consumable from C# where doing so does not materially degrade the F# model.

R7.3 Invalid states SHOULD be made unrepresentable where practical through discriminated unions, constrained construction, and total functions.

R7.4 Warnings SHALL be treated as errors.

R7.5 Pure functions SHALL be preferred over service objects, inheritance hierarchies, mutable registries, or ambient state.

R7.6 Public APIs SHALL avoid reflection requirements.

## R8 - Quality

R8.1 Core behavior SHALL have deterministic tests.

R8.2 Tests SHALL use only the .NET/F# platform by default. A third-party test framework requires the same explicit dependency permission as a runtime dependency.

R8.3 Public API behavior SHALL be covered before release.

R8.4 Packaging SHALL be verified in CI.

R8.5 Iter SHOULD dogfood Dokimos once Dokimos has a stable install/integration path for libraries.

R8.6 Route, path, query, and location codecs SHALL include round-trip/property-style coverage over representative edge cases without requiring a third-party property-testing package.

R8.7 Tests SHALL cover encoded delimiters, Unicode, empty values, duplicate query keys, root paths, base paths, trailing separators, malformed escapes, and canonicalization behavior when those capabilities exist.

R8.8 A bug found in multiple consumers SHOULD first be evaluated as evidence for an Iter primitive rather than copied into another application.

## R9 - Packaging

R9.1 Iter SHALL be publishable as a NuGet package.

R9.2 The initial package identity SHALL be `EchelonFoundry.Iter`.

R9.3 Release publication SHALL occur through GitHub Actions rather than requiring a developer workstation.

R9.4 Package metadata SHALL identify the source repository and MIT license.

R9.5 The NuGet package SHALL contain only production library artifacts and required package metadata.

R9.6 Website, tests, governance state, examples, and generated reports SHALL NOT become package runtime content unless explicitly required.

## R10 - Echelon governance and website

R10.1 Iter SHALL follow the current Ordo and Praxis governance.

R10.2 Visual Engineering and Communication Engineering SHALL govern the future public site and communication surfaces.

R10.3 Tutela SHALL govern security claims and security-specific invariants.

R10.4 Aegis SHALL be introduced only if Iter gains an effectful boundary where unexpected operational faults need shared handling. Pure parsing/routing failures remain Iter outcomes.

R10.5 Forma and Limen SHALL be used for the future site when appropriate, without becoming runtime dependencies of the Iter NuGet library.

R10.6 Folio SHALL be used only if Iter later needs printable/paginated artifacts.

R10.7 Conditor SHOULD eventually be able to establish Iter's standard development environment from an empty repository.

R10.8 The future site SHALL be deployed through GitHub Actions and GitHub Pages unless a later requirement justifies a different host.

R10.9 Site source, build dependencies, and assets SHALL remain isolated from the Iter NuGet package.

R10.10 The site SHALL prefer static HTML/CSS when interaction does not justify a WASM/browser application.

## R11 - Size budgets

R11.1 The first routing release SHOULD keep the production library at or below 1,000 non-generated source lines.

R11.2 Any change that causes production source to cross a 1,000-line boundary increment SHALL require an explicit architecture review explaining the growth.

R11.3 The core package SHALL have zero external runtime dependencies unless a specific exception has been explicitly approved.

R11.4 CI SHALL report production source-line count and package size so growth is visible.

R11.5 CI SHOULD report public API surface growth once a stable public API baseline exists.

R11.6 Optional modules SHALL NOT cause consumers of unrelated primitives to acquire new runtime behavior or dependencies.

## R12 - Dependency permission and governance

R12.1 No external dependency MAY be added without explicit human permission.

R12.2 For this rule, an external dependency includes any explicit NuGet `PackageReference`, .NET tool, analyzer, source generator, test package, vendored external library, or equivalent code dependency not supplied by the selected .NET SDK/BCL/F# platform.

R12.3 The implicit F#/.NET platform, including `FSharp.Core` as supplied by the F# SDK, is not treated as an external dependency for this rule.

R12.4 Echelon packages are NOT automatically exempt. Adding Limen-related, Aegis, Forma, Folio, or any other Echelon package to an Iter production/test project still requires explicit permission if it creates a package/code dependency.

R12.5 Permission SHALL identify the dependency, intended version, scope, and purpose. Permission for one dependency SHALL NOT authorize another.

R12.6 An approved dependency SHALL be pinned to an exact released version or immutable artifact. Floating/range versions SHALL NOT be used for an approved Iter dependency unless separately approved.

R12.7 The approval decision SHALL record why the .NET platform or a small local implementation is insufficient, what alternatives were considered, the transitive dependency impact, license/security implications, size impact, and removal/exit path.

R12.8 Vendoring or copying external source SHALL NOT be used to bypass dependency approval.

R12.9 A transitive dependency tree introduced by an approved direct dependency is part of the approval scope and SHALL be reviewed before acceptance.

R12.10 CI SHALL fail if an Iter project gains an unapproved external package/tool dependency.

R12.11 The current approved external dependency set for Iter production and test projects is empty.

R12.12 Future site dependencies are governed separately from the NuGet library, but new non-platform site/build dependencies still require explicit permission and exact pinning.

## R13 - Admission rule for new Iter capabilities

R13.1 A proposed new Iter module SHOULD have evidence from at least two independent consuming applications, unless it is strictly necessary to complete an already-admitted primitive.

R13.2 An admission proposal SHALL identify the duplicated problem and the repositories demonstrating it.

R13.3 The proposal SHALL explain why the concern belongs above Limen and below application/domain meaning.

R13.4 The proposal SHALL identify the smallest API that removes the duplication.

R13.5 The proposal SHALL estimate production source-line growth, public API growth, package-size effect, and dependency effect.

R13.6 The proposal SHALL compare the shared primitive with leaving the implementation application-local.

R13.7 If the placement test is ambiguous, the feature SHALL remain application-local until stronger evidence exists.

R13.8 An API that primarily exists to save a few lines of obvious application code SHALL NOT be admitted unless it also removes a demonstrated correctness or interoperability risk.

## R14 - Explicit exclusions

The following SHALL NOT be added to Iter without a new owner-approved architecture decision that changes Iter's mission:

- generic typed identifier framework;
- clock/time/date/timezone framework;
- generic validation framework;
- JSON serializer or general wire-schema framework;
- HTTP client wrapper, retry, cache, authentication, or policy layer;
- generic effect runtime or correlation system;
- application store/state-management framework;
- remote-data/loading-state framework;
- persistence/repository/storage layer;
- dependency injection;
- component model;
- rendering/DOM abstraction;
- forms framework;
- event bus;
- scheduler/background-job runtime;
- logging/telemetry framework;
- filesystem/process/Git/package-management utilities;
- semver/package-resolution utilities.

These concerns may be common across Echelon systems while still belonging to their application, boundary owner, Ordo, Aegis, Limen, Forma, Praxis, or another purpose-built library.

## R15 - Limen interoperability placement

R15.1 Iter SHALL NOT become the canonical .NET representation of the Limen browser/engine protocol.

R15.2 Repeated .NET/F# duplication of Limen protocol DTOs/effect shapes SHALL be treated as a Limen-owned interoperability gap.

R15.3 A future Limen .NET companion contract/package MAY be evaluated under Limen governance.

R15.4 Iter MAY accept or produce plain application-side values that can be translated by a Limen adapter, but Iter SHALL NOT own Limen protocol versioning or capability negotiation.
