#!/usr/bin/env bats

load fixture

@test "unknown option prints an error message" {
    run -2 addField --does-not-exist -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_line -n 0 'ERROR: Unknown option "--does-not-exist"!'
    assert_line -n 2 -e '^Usage:'
}

@test "no N prints an error message" {
    run -2 addField "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_line -n 0 'ERROR: No [+-]N AWK-EXPR passed.'
    assert_line -n 2 -e '^Usage:'
}
