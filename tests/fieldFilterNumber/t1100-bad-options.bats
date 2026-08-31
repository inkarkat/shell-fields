#!/usr/bin/env bats

load fixture

@test "additional contradicting comparisons with the same value for a field are not accepted" {
    run -2 --separate-stderr fieldFilterNumber -F $'\t' 2 -gt 3333 2 -gt 3333 "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output ''
    output="$stderr" assert_output 'ERROR: Value 3333 already given in -gt comparison for field 2.'

    run -2 --separate-stderr fieldFilterNumber -F $'\t' 2 -ge 3333 2 -le 3333 "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output ''
    output="$stderr" assert_output 'ERROR: Value 3333 already given in -ge comparison for field 2.'

    run -2 --separate-stderr fieldFilterNumber -F $'\t' 2 -ne 1111 2 -eq 1111 "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output ''
    output="$stderr" assert_output 'ERROR: Value 1111 already given in -ne comparison for field 2.'
}

@test "the same value for different fields are accepted" {
    run -0 fieldFilterNumber -F $'\t' 2 -gt 3333 4 -gt 3333 "${BATS_TEST_DIRNAME}/tabbed.txt"
}
