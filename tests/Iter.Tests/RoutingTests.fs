module EchelonFoundry.Iter.Tests.RoutingTests

open System
open EchelonFoundry.Iter
open EchelonFoundry.Iter.Tests.TestFramework

type TestRoute =
    | Home
    | Customer of int

let parseRoute input =
    match input with
    | "/" -> Ok Home
    | value when value.StartsWith("/customers/", StringComparison.Ordinal) ->
        let raw = value.Substring("/customers/".Length)

        match Int32.TryParse raw with
        | true, id when id > 0 -> Ok(Customer id)
        | _ ->
            Error
                { Input = input
                  Reason = "customer id must be a positive integer" }
    | _ ->
        Error
            { Input = input
              Reason = "route not recognized" }

let formatRoute route =
    match route with
    | Home -> "/"
    | Customer id -> $"/customers/{id}"

let codec = RouteCodec.create parseRoute formatRoute

let private roundTrip route () =
    let formatted = RouteCodec.format codec route

    match RouteCodec.parse codec formatted with
    | Ok parsed -> Assert.equal route parsed
    | Error error -> Assert.fail $"round trip unexpectedly failed: {error}"

let tests =
    [ test "route codec round-trips Home" (roundTrip Home)
      test "route codec round-trips Customer 1" (roundTrip(Customer 1))
      test "route codec round-trips Customer 42" (roundTrip(Customer 42))
      test "route parse error preserves the rejected input" (fun () ->
          match RouteCodec.parse codec "/customers/nope" with
          | Ok route -> Assert.fail $"invalid route unexpectedly parsed: {route}"
          | Error error -> Assert.equal "/customers/nope" error.Input)
      test "Navigation.push yields Push mode" (fun () ->
          Assert.equal NavigationMode.Push (Navigation.push Home).Mode)
      test "Navigation.replace yields Replace mode" (fun () ->
          Assert.equal NavigationMode.Replace (Navigation.replace Home).Mode) ]
