# Iter Architecture

## Boundary

Iter sits above Limen and below the consuming application.

```text
Browser
  |
  | browser capabilities
  v
Limen
  |
  | typed messages / effects
  v
Application boundary / adapter
  |
  | plain application-side values
  v
Iter (optional pure primitives)
  |
  v
Application domain
```

Limen knows browser operations. Iter knows only small reusable application-side web value transformations. The application owns route meaning, business state, authorization, legal transitions, and domain resolution.

## Core rule

**Capability is not authority.**

Iter may describe a navigation intent without performing it. It may parse a relative web location without deciding what a screen means. It may format an application route without rendering anything.

## Planned module surface

The intended first release family is deliberately small.

### `RouteCodec`

Already present.

Owns:
- application-supplied parse;
- application-supplied format;
- typed route round-trip contract.

Does not own:
- route union;
- route discovery;
- route table;
- page/controller model;
- entity lookup;
- rendering.

### `WebLocation`

Planned.

A pure relative location composed of:
- path;
- query;
- fragment.

No origin, browser object, history handle, or ambient state.

### `WebPath`

Planned.

Owns only:
- path parse/format;
- path segments;
- explicit normalization;
- base-path-safe composition.

It does not become a route matcher DSL.

### `Query`

Planned.

Owns only:
- parse/format;
- duplicate key preservation;
- missing-value versus empty-value distinction;
- deterministic accessors/formatting.

It does not become model binding or form state.

### `UriComponent`

Planned only as needed by Path/Query.

Owns a consistent narrow contract over .NET platform escaping/decoding. It does not justify an external URI package.

### `NavigationIntent`

Already present in minimal form.

Owns typed application intent such as push/replace. It never executes browser history.

## Dependency direction

Allowed:

```text
Application -> Iter
Application boundary -> Limen
Future Iter site -> Limen + Forma (site only, separately approved)
```

Forbidden:

```text
Limen -> Iter
Iter -> Limen runtime/package
Iter -> Forma
Iter -> ASP.NET/Blazor
Iter -> browser APIs
Iter -> application domain
Iter -> persistence/runtime framework
```

## Dependency rule

The default dependency graph is:

```text
EchelonFoundry.Iter
    -> .NET / F# platform only
```

No explicit package, tool, analyzer, source generator, test framework, or vendored library may be introduced without specific human approval.

An Echelon package is still an external dependency from Iter's point of view and does not receive an automatic exemption.

A proposed dependency must first demonstrate why the BCL/F# platform plus a small local implementation is insufficient. Approval must cover the exact dependency/version and its transitive impact.

## Placement matrix

| Concern | Owner |
| --- | --- |
| Browser history/location/storage/HTTP/clipboard capability | Limen |
| Relative path/query/location interpretation | Iter |
| Typed route meaning | Application |
| Domain entity resolution | Application |
| Legal states/transitions/obligations | Application + Ordo method |
| Unexpected operational failure | Aegis |
| Interactive presentation | Forma |
| Printable presentation | Folio |
| Engineering workflow/provenance | Praxis |
| Security claims/invariants | Tutela |

## Why some repeated code stays out

Cross-repository repetition is evidence, not ownership.

Typed IDs, clocks, JSON/wire codecs, validation, HTTP clients, persistence, effect algebras, process execution, and file-path utilities appear repeatedly across Echelon repositories. They remain outside Iter because they are not narrow application-side web primitives.

In particular, .NET applications currently repeat Limen protocol representations. That is a real interoperability issue, but the protocol belongs to Limen. If centralized, it should become a Limen-owned .NET companion contract rather than an Iter subsystem.

## Growth policy

A new module must answer:

1. Is this repeated across at least two independent applications?
2. Is it application-side web behavior?
3. Is it independent of rendering and business meaning?
4. Can it remain pure?
5. Does centralizing it remove a meaningful correctness/interoperability risk?
6. Is the proposed shared API smaller and conceptually simpler than the duplicated implementations?
7. Can it be implemented with the platform only?
8. What is the exact LOC/API/package-size cost?

If the answer is not convincingly favorable, keep it in the application.

## Packaging

The production library is one NuGet package, `EchelonFoundry.Iter`, until evidence demonstrates that package splitting reduces consumer cost or authority.

Optional conceptual modules do not imply separate packages.

The website, examples, governance artifacts, tests, and build tooling are not package runtime dependencies.

## Future website

The site is a separate executable/build surface. It should use the current Echelon site architecture, Forma for reusable presentation, Limen for browser capability boundaries, Visual Engineering for UI decision evidence, and Communication Engineering for communication decisions.

The site must not be used as evidence that a presentation or browser concern belongs in the Iter library.
