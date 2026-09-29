# Iter Cross-Repository Commonality Review

Status: planning baseline
Date: 2026-09-29

## Purpose

This review identifies repeated implementation concerns across current Echelon systems and decides which ones belong in Iter.

The test is not "is this useful?" or "have we written it before?" The test is whether the concern is:

1. repeated across independent applications;
2. application-side web behavior;
3. independent of application/domain meaning;
4. expressible as a small pure primitive;
5. safer or clearer when centralized; and
6. unlikely to pull framework authority into Iter.

A repeated concern that fails those tests does not belong in Iter.

## Repositories reviewed

Representative current implementations and requirements were reviewed from:

- Limen
- Helix Note
- Chrona
- Summa
- Time Entry
- Vigila
- Strata
- Ordo
- Praxis
- Dokimos
- Conditor
- Aegis

The review intentionally distinguishes application commonality from engineering-tool commonality.

## Admit to Iter

### 1. Typed route codecs

Observed:
- Helix Note has an application-wide typed route union.
- Limen documents application-owned route parsing/formatting and explicitly refuses to become a router.
- Iter already has the first pure `RouteCodec<'route>` implementation.

Decision:
- Iter owns the reusable parse/format abstraction.
- The consuming application owns the route union and what every route means.
- Iter does not own a route table, controller model, page model, or rendering.

### 2. Relative web location

Observed:
- Limen exposes path, query, and fragment as browser location data.
- Multiple applications need to convert browser location into typed application state.

Decision:
- Iter should provide a small application-side representation of a relative web location:
  - path;
  - query;
  - fragment.
- It must not contain origin authority or browser APIs.
- It should be constructible from plain data so it does not require Limen.

### 3. Path handling

Observed:
- Helix Note contains repeated route path shapes and typed path parameters.
- Limen routing guidance requires base-path correctness for subdirectory deployment.
- GitHub Pages and similar hosts make base-path handling correctness-sensitive.

Decision:
- Iter should provide path splitting/composition and base-path-safe relative path construction.
- It should not provide a route-table DSL or reflection/attribute discovery.
- Path parameter interpretation remains application-owned through caller-provided parsers/codecs.

### 4. Query-string handling

Observed:
- Summa manually builds query strings, including repeated keys.
- Limen routing explicitly supports query-based routing for static hosting.
- Browser applications need deterministic query parse/format behavior.

Decision:
- Iter should provide a query representation and parser/formatter that:
  - preserves duplicate keys;
  - distinguishes missing value from empty value;
  - defines encoding explicitly;
  - formats deterministically;
  - does not silently discard malformed input.

This is infrastructure for typed routing/filter state, not a forms framework.

### 5. URI-component encoding

Observed:
- Current applications manually call platform URL encoders or construct URL strings.
- Routing, query parameters, IDs, and shareable links all depend on correct escaping.

Decision:
- Iter may wrap .NET platform URI-component encoding/decoding behind narrow pure helpers where doing so gives one consistent contract.
- No third-party URI library is justified by the current evidence.

### 6. Base paths

Observed:
- Limen explicitly identifies subdirectory hosting as a common routing failure.
- Echelon sites and GitHub Pages deployments make this a recurring concern.

Decision:
- Base path should be an explicit value, not a string convention.
- Combining a base path with an application route must not accidentally target the site root.
- Base-path operations must be pure.

### 7. Typed navigation intent

Observed:
- Limen supports browser history push/replace.
- Vigila duplicates navigation request vocabulary on the .NET application side.
- Iter already represents typed push/replace intent.

Decision:
- Iter may represent application navigation intent over typed routes.
- It must not execute history operations.
- Browser-originated location changes remain input to application state and must not automatically produce a push/replace loop.

## Common, but do not put in Iter

### Typed identifiers

Vigila, Time Entry, Ordo, Strata, Praxis, and other systems use strong IDs.

Decision: do not add generic typed-ID machinery to Iter.

Reason: identity is domain meaning, not a web primitive. Generic ID abstractions would broaden Iter into a general-purpose foundation library.

### Time and clock abstractions

Vigila, Ordo, and Chrona model time explicitly.

Decision: do not add clock, instant, timezone, date, duration, or scheduling abstractions to Iter.

Reason: these are domain/runtime concerns and are already governed by application/Ordo design.

### Validation frameworks

Helix Note, Strata, Ordo, Time Entry, and Vigila all validate inputs.

Decision: do not create a generic Iter validation framework.

Reason: most validation is domain-specific. Small local parsing functions are preferable to a framework until a specifically web-oriented repeated primitive is proven.

### JSON/wire codecs

Ordo, Praxis, Vigila, Time Entry, Dokimos, Strata, and others have explicit wire formats.

Decision: do not put generic JSON serialization or schema/wire machinery in Iter.

Reason: wire contracts carry system authority and version semantics. Centralizing them in Iter would create coupling and hidden policy.

### HTTP clients

Helix Note and other applications contain HTTP plumbing.

Decision: do not add HTTP client wrappers, retries, caching, authentication, headers, or response policy to Iter.

Reason:
- browser HTTP capability belongs to Limen;
- server/host HTTP uses .NET/platform boundaries;
- unexpected operational failures belong to Aegis;
- response/domain interpretation belongs to the application.

### Effects and correlation IDs

Vigila, Time Entry, Strata, Ordo, and Limen use explicit effects/correlation.

Decision: do not create a generic effect system in Iter.

Reason: effect vocabulary belongs to the owning boundary. Iter may return pure navigation intent, but it must not become an effect runtime.

### Application state / remote-resource state

Several applications model loading, loaded, missing, unavailable, conflict, and similar states.

Decision: do not introduce a state-management library, remote-data abstraction, store, reducer framework, or lifecycle runtime into Iter.

Reason: these states often carry application semantics and Ordo obligations.

### Persistence and storage

Time Entry and other browser systems use storage.

Decision: do not add persistence, storage repositories, cache layers, or local-storage wrappers to Iter.

Reason: Limen owns browser storage capability and the application owns persisted meaning.

### UI, forms, and components

Decision: explicitly excluded.

Forma owns reusable presentation. Native HTML owns semantics. Iter does not own components, forms, rendering, validation lifecycle, touched/dirty state, view models, or DOM behavior.

### Process, filesystem, Git, package, and semver utilities

Praxis, Ordo, Conditor, and other engineering tools share these concerns.

Decision: do not add them to Iter.

Reason: they are engineering/tooling concerns, not application-side web primitives.

## Commonality that should be solved elsewhere

### .NET Limen protocol contracts

Time Entry and Vigila both contain .NET/F# types that mirror Limen browser/engine protocol concepts.

This is a genuine duplication risk, especially as the Limen protocol evolves.

Decision:
- do not put the Limen protocol in Iter;
- treat this as a Limen-owned compatibility concern;
- evaluate a small Limen .NET companion contract/package or generated compatibility fixtures under Limen governance;
- Iter may consume plain application-side values produced by such an adapter, but must not become the protocol authority.

## Admission rule for future Iter modules

A proposed Iter module must present evidence from at least two independent consuming applications, unless the capability is required to complete another already-admitted Iter primitive.

The proposal must state:
- the duplicated code/problem;
- the repositories demonstrating it;
- why the BCL alone is insufficient at the call sites;
- why the concern belongs above Limen;
- the smallest API that removes the duplication;
- expected production LOC increase;
- public API increase;
- whether any dependency is proposed;
- why application-local code is worse.

Without that evidence, the feature stays application-local.

## Dependency conclusion

The current commonality scan found no external package dependency necessary for Iter's admitted scope.

Routing, relative locations, paths, query strings, percent encoding, base paths, and navigation intent can be built with F# and the .NET platform libraries.

Therefore the default and current requirement is zero external dependencies.
