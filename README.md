# Iter

Iter is Echelon Foundry's small, optional .NET library for typed application-side web primitives.

Its first responsibility is routing. Iter interprets application navigation above the Limen boundary; Limen remains a tiny, language-neutral browser capability boundary.

## Design rule

**Iter provides reusable application primitives, not a web framework.**

Iter does not own rendering, the DOM, components, application lifecycle, dependency injection, state management, forms, or business-domain semantics.

## Initial capability

The first vertical slice is typed routing:

- parse a URI/location into an application-defined route;
- format an application-defined route into a URI;
- represent navigation intent without performing browser effects;
- keep browser history/location effects behind Limen;
- make invalid navigation states difficult to represent in F#.

## Architecture

```text
Browser
  |
  | location/history capabilities
  v
Limen
  |
  | typed boundary messages
  v
Iter
  |
  | typed routing/navigation primitives
  v
Application
```

Iter is optional. Limen must never depend on Iter.

## Implementation constraints

- F# / .NET.
- Prefer pure functions and explicit types.
- Zero runtime dependencies unless a dependency is demonstrably justified.
- No ASP.NET Core, Blazor, React, Angular, or UI-framework dependency.
- No hidden global state.
- External effects remain outside the core.
- Warnings are errors.
- Public API growth is intentional and reviewed against the minimality budget.

See `PROJECT-CHARTER.md`, `requirements/REQUIREMENTS.md`, and `docs/architecture/ARCHITECTURE.md`.

## Website

Iter will eventually have a public Echelon Foundry site. Website implementation is intentionally deferred until the library's routing surface is stable. Site work will use the Echelon browser/design stack rather than adding web concerns to the Iter library.
