# Iter Project Charter

## Mission

Provide the smallest useful set of typed .NET application-side web primitives that repeatedly occur above the Limen browser boundary.

## Success

Iter succeeds when F# and other .NET applications can reuse small, deterministic primitives such as routing without adopting a framework, hidden runtime, rendering model, or application architecture.

## Primary constraint: minimality

Smallness is an architectural requirement.

A feature is not justified by convenience alone. Every public capability must demonstrate that it:
1. recurs across applications;
2. belongs above Limen rather than inside the browser boundary;
3. can remain independent of rendering and business-domain semantics;
4. materially reduces duplicated correctness-sensitive code; and
5. cannot be expressed more simply by application code.

## Boundaries

Iter owns optional application-side primitives.

Iter does not own:
- browser capability access, which belongs to Limen;
- application/domain state, which belongs to the consuming application;
- UI components or presentation, which belong to Forma/application code;
- printable document primitives, which belong to Folio;
- engineering workflow, which belongs to Praxis;
- engineering/state methodology, which belongs to Ordo.

## Initial vertical slice

Typed routing is the first capability:
1. route parsing;
2. route formatting;
3. round-trip guarantees where a codec supports them;
4. typed navigation intent;
5. zero browser effects in the core.

## Future site

Iter will eventually have a public site. The site is a separate presentation concern and must not cause browser/UI dependencies to enter the library package.
