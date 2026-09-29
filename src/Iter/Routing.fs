namespace EchelonFoundry.Iter

/// A parsing failure for an application-defined route.
[<StructuralEquality; StructuralComparison>]
type RouteParseError =
    {
        Input: string
        Reason: string
    }

/// A pure mapping between a location string and an application-defined route type.
type RouteCodec<'route> =
    private
        {
            ParseRoute: string -> Result<'route, RouteParseError>
            FormatRoute: 'route -> string
        }

[<RequireQualifiedAccess>]
module RouteCodec =
    /// Creates a route codec from application-owned parse and format functions.
    let create parse format : RouteCodec<'route> =
        {
            ParseRoute = parse
            FormatRoute = format
        }

    /// Parses a location into an application-defined route.
    let parse (codec: RouteCodec<'route>) location =
        codec.ParseRoute location

    /// Formats an application-defined route as a location string.
    let format (codec: RouteCodec<'route>) route =
        codec.FormatRoute route

/// How a navigation request should affect browser history when interpreted by a boundary adapter.
[<RequireQualifiedAccess>]
type NavigationMode =
    | Push
    | Replace

/// Pure navigation intent. Iter does not execute this against a browser.
[<StructuralEquality; StructuralComparison>]
type NavigationIntent<'route> =
    {
        Mode: NavigationMode
        Route: 'route
    }

[<RequireQualifiedAccess>]
module Navigation =
    /// Creates an intent to push a new history entry.
    let push route : NavigationIntent<'route> =
        {
            Mode = NavigationMode.Push
            Route = route
        }

    /// Creates an intent to replace the current history entry.
    let replace route : NavigationIntent<'route> =
        {
            Mode = NavigationMode.Replace
            Route = route
        }
