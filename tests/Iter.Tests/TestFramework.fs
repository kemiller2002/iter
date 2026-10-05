/// Dependency-free test runner (R0.2, R8.2, R12.11: no third-party test
/// framework). Tests are immutable named values; the runner is the only place
/// that performs effects (console output and the process exit code).
module EchelonFoundry.Iter.Tests.TestFramework

open System

type TestCase = { Name: string; Run: unit -> unit }

type TestOutcome =
    | Passed of name: string
    | Failed of name: string * message: string

type RunSummary =
    { Executed: int
      Passed: int
      Failed: int }

let test name run = { Name = name; Run = run }

[<RequireQualifiedAccess>]
module Assert =
    let fail (message: string) : 'a = raise (InvalidOperationException message)

    let equal<'value when 'value: equality> (expected: 'value) (actual: 'value) =
        if expected <> actual then
            fail $"expected {expected}; actual {actual}"

let private execute (case: TestCase) =
    try
        case.Run()
        Passed case.Name
    with error ->
        Failed(case.Name, error.Message)

let summarize (outcomes: TestOutcome list) =
    let failed =
        outcomes
        |> List.filter (function
            | Failed _ -> true
            | Passed _ -> false)
        |> List.length

    { Executed = outcomes.Length
      Passed = outcomes.Length - failed
      Failed = failed }

/// Exit-code policy: success requires at least one executed test and no
/// failures. An empty run is a failure so a broken harness cannot look green.
let exitCode summary =
    if summary.Executed = 0 then 2
    elif summary.Failed > 0 then 1
    else 0

let run (suite: string) (tests: TestCase list) =
    let outcomes = tests |> List.map execute

    for outcome in outcomes do
        match outcome with
        | Passed name -> printfn "PASS %s" name
        | Failed(name, message) -> eprintfn "FAIL %s\n  %s" name message

    let summary = summarize outcomes
    printfn "%s: %d executed; %d passed; %d failed" suite summary.Executed summary.Passed summary.Failed

    if summary.Executed = 0 then
        eprintfn "%s: zero tests executed; failing the run" suite

    exitCode summary
