#!/usr/bin/env bats

load fixture

@test "invalid AWK expression prints AWK error message" {
    run -1 fieldMap -F $'\t' 2 '++++' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_line -n 0 -e '^awk:'
    assert_line -n 1 -p '^ syntax error'
}
