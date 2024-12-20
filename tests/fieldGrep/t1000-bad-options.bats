#!/usr/bin/env bats

load fixture

@test "unknown option prints an error message" {
    run -2 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" --does-not-exist 2
    assert_line -n 0 'ERROR: Unknown option "--does-not-exist"!'
    assert_line -n 3 -e '^Usage:'
}

@test "missing regexp prints an error message" {
    run -2 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" 2
    assert_line -n 0 'ERROR: No PATTERN(s) passed.'
    assert_line -n 3 -e '^Usage:'
}

@test "regular expression field separator prints an error message" {
    run -2 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F ' +' --regexp . 2
    assert_output 'ERROR: The field separator has to be a literal string; it cannot be a regular expression.'
}

@test "a non-number argument at the end prints an error message" {
    run -2 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" --regexp . 2 x 3 y
    assert_output 'ERROR: Not a number: x'
}
