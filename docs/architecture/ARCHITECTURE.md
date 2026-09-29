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
Iter (optional)
  |
  | typed reusable application-side primitives
  v
Application
```

Limen knows browser operations. Iter may know reusable navigation concepts. The application owns route meaning and business state.

## Core rule

**Capability is not authority.**

Iter may describe a navigation intent without performing it. It may parse a location without deciding what a screen means. It may format an application route without rendering anything.

## Initial model

The initial package contains:
- a typed `RouteCodec<'route>` abstraction;
- explicit parse failure;
- pure parse and format operations;
- typed push/replace navigation intent.

It contains no browser API access.

## Dependency direction

Allowed:

```text
Application -> Iter
Application -> Limen adapter/boundary
Future Iter site -> Limen + Forma
```

Forbidden:

```text
Limen -> Iter
Iter.Core -> Limen
Iter.Core -> Forma
Iter.Core -> ASP.NET/Blazor
Iter.Core -> browser APIs
```

## Growth policy

A new module must answer:
1. Is this repeated across multiple applications?
2. Is it application-side rather than browser-side?
3. Can it be pure?
4. Does centralizing it prevent meaningful duplication or correctness risk?
5. Is the public surface smaller than the repeated application-local implementations?

If the answer is not convincingly yes, keep it in the application.

## Packaging

The production library is one NuGet package, `EchelonFoundry.Iter`. The website, examples, governance artifacts, tests, and build tooling are not package runtime dependencies.

## Future website

The site will be a separate executable/build surface. It should use the current Echelon site architecture, Forma for reusable presentation, Limen for browser capability boundaries, Visual Engineering for UI decision evidence, and Communication Engineering for communication decisions.
