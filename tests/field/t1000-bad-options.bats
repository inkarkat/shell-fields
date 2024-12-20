#!/usr/bin/env bats

load fixture

@test "unknown option prints an error message" {
    run -2 field --input "${BATS_TEST_DIRNAME}/tabbed.txt" --does-not-exist 2
    assert_line -n 0 'ERROR: Unknown option "--does-not-exist"!'
    assert_line -n 3 -e '^Usage:'
}

@test "a non-number argument at the end when removing prints an error message" {
    run -2 field --input "${BATS_TEST_DIRNAME}/tabbed.txt" --remove 2 x 3 y
    assert_output 'ERROR: Not a number: x'
}
