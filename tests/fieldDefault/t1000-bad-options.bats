#!/usr/bin/env bats

load fixture

@test "unknown option prints an error message" {
    run -2 fieldDefault --file "${BATS_TEST_DIRNAME}/tabbed.txt" --value DEFAULT --does-not-exist 2
    assert_output 'ERROR: Unknown option "--does-not-exist"!'
}

@test "invalid LIST prints an error message" {
    run -2 fieldDefault --file "${BATS_TEST_DIRNAME}/tabbed.txt" --value DEFAULT 1-2-3
    assert_output 'ERROR: Invalid LIST: 1-2-3'
}

@test "missing value prints an error message" {
    run -2 fieldDefault --file "${BATS_TEST_DIRNAME}/tabbed.txt" 2
    assert_line -n 0 'ERROR: No -v|--value VAL passed.'
    assert_line -n 2 -e '^Usage:'
}

@test "missing LIST prints an error message" {
    run -2 fieldDefault --file "${BATS_TEST_DIRNAME}/tabbed.txt" --value DEFAULT
    assert_line -n 0 'ERROR: No LIST passed.'
    assert_line -n 2 -e '^Usage:'
}
