open System
open EchelonFoundry.Iter

type TestRoute =
    | Home
    | Customer of int

let fail message =
    raise (InvalidOperationException message)

let equal expected actual label =
    if expected <> actual then
        fail $"{label}: expected {expected}; actual {actual}"

let parseRoute input =
    match input with
    | "/" -> Ok Home
    | value when value.StartsWith("/customers/", StringComparison.Ordinal) ->
        let raw = value.Substring("/customers/".Length)
        match Int32.TryParse raw with
        | true, id when id > 0 -> Ok (Customer id)
        | _ -> Error { Input = input; Reason = "customer id must be a positive integer" }
    | _ -> Error { Input = input; Reason = "route not recognized" }

let formatRoute route =
    match route with
    | Home -> "/"
    | Customer id -> $"/customers/{id}"

let codec = RouteCodec.create parseRoute formatRoute

let routes = [ Home; Customer 1; Customer 42 ]

for route in routes do
    let formatted = RouteCodec.format codec route
    match RouteCodec.parse codec formatted with
    | Ok parsed -> equal route parsed "route round trip"
    | Error error -> fail $"round trip unexpectedly failed: {error}"

match RouteCodec.parse codec "/customers/nope" with
| Ok route -> fail $"invalid route unexpectedly parsed: {route}"
| Error error ->
    equal "/customers/nope" error.Input "parse error preserves input"

equal NavigationMode.Push (Navigation.push Home).Mode "push mode"
equal NavigationMode.Replace (Navigation.replace Home).Mode "replace mode"

printfn "Iter.Tests: all tests passed"
