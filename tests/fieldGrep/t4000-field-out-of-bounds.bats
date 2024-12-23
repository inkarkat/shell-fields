#!/usr/bin/env bats

load fixture

@test "grep field 0 with generic pattern yields nothing" {
    run -1 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . 0
    assert_output ''
}

@test "grep too large positive field (by one) with generic pattern yields nothing" {
    run -1 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . 5
    assert_output ''
}

@test "grep too large positive field (by many) with generic pattern yields nothing" {
    run -1 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . 10
    assert_output ''
}

@test "grep too large negative field (by one) with generic pattern yields nothing" {
    run -1 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . -5
    assert_output ''
}

@test "grep too large negative field (by many) with generic pattern yields nothing" {
    run -1 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . -10
    assert_output ''
}
