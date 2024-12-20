#!/usr/bin/env bats

load fixture

@test "grep whole words in the last field" {
    run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --ignore-case --word-regexp --regexp here -1
    assert_output 'foo	first	100	A Here'
}
