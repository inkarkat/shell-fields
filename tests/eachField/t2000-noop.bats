#!/usr/bin/env bats

@test "noop processing of rectangular tabbed file" {
    run eachField "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ "$status" -eq 0 ]
    [ "$output" = "$(cat -- "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt")" ]
}
