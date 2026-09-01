#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 fieldFilterNumber
    assert_line -n 0 'ERROR: No comparison(s) passed.'
    assert_line -n 2 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 fieldFilterNumber --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 2 -e '^Usage:'
}

@test "-h prints long usage help" {
    run -0 fieldFilterNumber -h
    refute_line -n 0 -e '^Usage:'
}
