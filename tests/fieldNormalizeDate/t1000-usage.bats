#!/usr/bin/env bats

@test "no arguments prints message and usage instructions" {
    run fieldNormalizeDate
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: No [-]N [[-f|--format] FORMAT] passed.' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "invalid option prints message and usage instructions" {
    run fieldNormalizeDate --invalid-option
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Unknown option "--invalid-option"!' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "-h prints long usage help" {
  run fieldNormalizeDate -h
    [ $status -eq 0 ]
    [ "${lines[0]%% *}" != 'Usage:' ]
}

@test "invalid --date-error prints an error message" {
    LC_ALL=C run fieldNormalizeDate -F $'\t' --date-error doesNotExist 1 -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Invalid value for --date-error: doesNotExist' ]
    [ "${lines[2]%% *}" = "Usage:" ]
}
