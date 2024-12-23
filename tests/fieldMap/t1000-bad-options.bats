#!/usr/bin/env bats

load fixture

@test "unknown option prints an error message" {
    run -2 fieldMap --does-not-exist -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_line -n 0 'ERROR: Unknown option "--does-not-exist"!'
    assert_line -n 2 -e '^Usage:'
}

@test "no N and no --filter prints an error message" {
    run -2 fieldMap "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_line -n 0 'ERROR: No AWK-EXPR passed (for filtering or mapping).'
    assert_line -n 2 -e '^Usage:'
}

@test "invalid --coprocess-error prints an error message" {
    run -2 fieldMap -F $'\t' --coprocess-error doesNotExist 1 '|doesNotExist' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_line -n 0 'ERROR: Invalid value for --coprocess-error: doesNotExist'
    assert_line -n 2 -e '^Usage:'
}
