#!/usr/bin/env bats

load fixture

@test "no passed field prints an error message" {
    run -2 field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t'
    assert_line -n 0 'ERROR: No field number N passed.'
    assert_line -n 4 -e '^Usage:'
}

@test "no passed field only separators prints an error message" {
    run -2 field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' ' ' ' '
    assert_line -n 0 'ERROR: No field number N passed.'
    assert_line -n 4 -e '^Usage:'
}

@test "no passed field to remove prints an error message" {
    run -2 field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove
    assert_line -n 0 'ERROR: No field number N passed.'
    assert_line -n 4 -e '^Usage:'
}
