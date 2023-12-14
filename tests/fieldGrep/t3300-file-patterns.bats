#!/usr/bin/env bats

@test "grep the first and second fields with basic regexps from file" {
run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --basic-regexp --file <(printf 'oo\\+\n^.\\{5\\}$\n') 1 2
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
third		333	C U" ]
}
