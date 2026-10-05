module EchelonFoundry.Iter.Tests.Program

open EchelonFoundry.Iter.Tests.TestFramework

[<EntryPoint>]
let main _ =
    RoutingTests.tests @ TestFrameworkTests.tests |> run "Iter.Tests"
