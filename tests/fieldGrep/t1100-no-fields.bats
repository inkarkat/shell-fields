#!/usr/bin/env bats

load fixture

@test "no passed field prints an error message" {
    run -2 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp .
    assert_line -n 0 'ERROR: No field number N passed.'
    assert_line -n 3 -e '^Usage:'
}

@test "no inverted passed field prints an error message" {
    run -2 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-fields --regexp .
    assert_line -n 0 'ERROR: No field number N passed.'
    assert_line -n 3 -e '^Usage:'
}
