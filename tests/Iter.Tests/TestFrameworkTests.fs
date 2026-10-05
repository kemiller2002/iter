/// Tests of the runner's own exit-code policy, so a regression that lets an
/// empty or failing run look green is itself caught.
module EchelonFoundry.Iter.Tests.TestFrameworkTests

open EchelonFoundry.Iter.Tests.TestFramework

let tests =
    [ test "runner exit code fails an empty run" (fun () ->
          Assert.equal 2 (exitCode (summarize [])))
      test "runner exit code fails when any test fails" (fun () ->
          Assert.equal 1 (exitCode (summarize [ Passed "a"; Failed("b", "boom") ])))
      test "runner exit code passes only a non-empty all-passing run" (fun () ->
          Assert.equal 0 (exitCode (summarize [ Passed "a" ])))
      test "runner summary counts executed, passed and failed" (fun () ->
          Assert.equal
              { Executed = 3; Passed = 2; Failed = 1 }
              (summarize [ Passed "a"; Failed("b", "x"); Passed "c" ])) ]
