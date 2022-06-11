#!/usr/bin/env bats

@test "unknown option prints an error message" {
    run fieldMap --does-not-exist -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Unknown option \"--does-not-exist\"!" ]
    [ "${lines[2]%% *}" = "Usage:" ]
}

@test "no N and no --filter prints an error message" {
    run fieldMap "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No AWK-EXPR passed (for filtering or mapping)." ]
    [ "${lines[2]%% *}" = "Usage:" ]
}

@test "invalid --coprocess-error prints an error message" {
    run fieldMap -F $'\t' --coprocess-error doesNotExist 1 '|doesNotExist' "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Invalid value for --coprocess-error: doesNotExist" ]
    [ "${lines[2]%% *}" = "Usage:" ]
}
