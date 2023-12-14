#!/usr/bin/env bats

@test "grep entire line in the last field" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" --line-regexp --regexp '[Hh]er[^ ]' -1
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A	Here" ]
}

@test "grep literal entire line in the last field" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" --ignore-case --fixed-strings --line-regexp --regexp 'here' -1
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A	Here" ]
}
