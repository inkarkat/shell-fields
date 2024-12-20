#!/usr/bin/env bats

load fixture

@test "grep the first field with fixed text from stdin yields one line" {
    run -0 fieldGrep -F $'\t' --fixed-strings --regexp oo 1 < "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output 'foo	first	100	A Here'
}
