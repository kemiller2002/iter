# Iter Requirements Implementation Plan

Status: planned
Date: 2026-09-29

This plan sequences implementation so Iter gains primitives only when the previous layer proves the next one is necessary.

## P0 - Guard the boundary first

Before adding new functionality:

1. Add a dependency-policy CI check.
2. Fail when an Iter production/test project gains an unapproved external package/tool dependency.
3. Keep the approved dependency set empty.
4. Preserve the existing source-line/package-size reporting.
5. Add a simple public-surface snapshot/report before the public API becomes large enough for accidental growth to hide.

Acceptance:
- current source builds/tests/packs;
- dependency gate reports zero approved and zero observed external dependencies;
- no new package is introduced to implement the gate.

## P1 - Relative web location

Add the smallest useful relative location model.

Proposed concepts:
- `WebLocation`
- path
- query
- fragment

Constraints:
- no origin;
- no browser API;
- no Limen dependency;
- no implicit normalization;
- pure parse/format only.

Acceptance:
- deterministic round trip;
- root/empty query/empty fragment cases;
- malformed encoding represented explicitly.

## P2 - Web path and base path

Add path primitives required by typed routing.

Proposed concepts:
- `WebPath`
- `PathSegment`
- `BasePath`

Required behavior:
- root path;
- segment parse/format;
- encoded delimiter handling;
- Unicode;
- explicit trailing-separator behavior;
- explicit normalization operation, if needed;
- combine route path under a base path;
- cannot accidentally escape to site root through ordinary composition.

Do not add:
- route table;
- route-template DSL;
- reflection;
- controller/page abstraction.

## P3 - Query representation

Add a loss-aware query representation.

Required behavior:
- preserve duplicate keys;
- preserve pair order initially;
- distinguish `?flag` from `?flag=`;
- explicit malformed-input failure;
- deterministic formatting;
- explicit first/last/all/single accessors only if demonstrated useful.

Do not add:
- form binding;
- object model binding;
- validation rules;
- automatic conversion registry.

## P4 - URI component encoding

Implement only what P2/P3 require.

Use .NET platform functions where correct.

Required tests:
- spaces;
- plus;
- percent;
- slash inside a segment;
- ampersand/equal characters in query data;
- Unicode;
- malformed percent escapes;
- round trip of encoded reserved characters.

No external URI dependency.

## P5 - RouteCodec integration

Evolve the existing `RouteCodec<'route>` only as necessary to operate over the new location/path/query primitives.

Required behavior:
- route union remains application-owned;
- syntactic parse only;
- explicit parse errors;
- deterministic format;
- supported routes round-trip;
- no runtime registration;
- no global route table;
- no reflection/attributes;
- no domain entity lookup.

Compatibility:
- avoid breaking the simple string-based API unless the replacement demonstrably improves correctness enough to justify a major-version change;
- a compatibility shim is preferable to dual long-term abstractions if it remains tiny.

## P6 - Navigation planning

Keep navigation as data.

Required behavior:
- typed Push;
- typed Replace;
- pure conversion from route + codec + base path to relative URL;
- optional pure duplicate-navigation detection;
- browser-originated location adoption does not cause a new push/replace.

Defer Back/Forward wrappers until a real .NET consumer demonstrates value beyond calling Limen directly.

## P7 - Consumer proofs

Before declaring the routing family stable:

1. Exercise the primitives against at least one existing typed-route application such as Helix Note.
2. Exercise path/query/base-path behavior against a Limen/static-hosting style application.
3. Capture any missing primitive as a requirement before adding it.
4. Reject application-specific convenience methods from the shared API.
5. Record production LOC and package size before and after each proof.

A proof may initially be a compatibility fixture rather than a production dependency if changing the consuming application is not yet appropriate.

## P8 - Freeze the first surface

Once P1-P7 are proven:

- publish the first stable API inventory;
- document what Iter deliberately does not do;
- set a public-surface ratchet;
- require architecture review for removals or broadening;
- prefer bug fixes over new modules.

## P9 - Website

Only after the library surface is stable:

- build the public site;
- use static HTML/CSS where sufficient;
- use Forma for shared presentation;
- use Limen only when browser interaction justifies it;
- keep all site dependencies out of the NuGet library;
- require explicit permission for any new external site/build dependency.

## Separate Limen work

The repeated F#/.NET duplication of Limen protocol DTOs/effect shapes should be evaluated in the Limen repository.

Potential direction:
- a Limen-owned .NET companion contract;
- versioned wire fixtures;
- compatibility tests against the canonical Limen protocol;
- zero or near-zero dependency implementation.

This work is intentionally not an Iter phase because Limen must remain the authority for its own protocol.
