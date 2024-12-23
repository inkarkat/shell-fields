#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 fieldNormalizeDate
    assert_line -n 0 'ERROR: No [-]N [[-f|--format] FORMAT] passed.'
    assert_line -n 2 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 fieldNormalizeDate --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 2 -e '^Usage:'
}

@test "-h prints long usage help" {
  run -0 fieldNormalizeDate -h
    [ "${lines[0]%% *}" != 'Usage:' ]
}

@test "invalid --date-error prints an error message" {
    LC_ALL=C run -2 fieldNormalizeDate -F $'\t' --date-error doesNotExist 1 -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_line -n 0 'ERROR: Invalid value for --date-error: doesNotExist'
    assert_line -n 2 -e "^Usage:"
}
