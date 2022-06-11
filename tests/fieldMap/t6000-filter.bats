#!/usr/bin/env bats

@test "turning first field to 0 and filtering empty lines" {
    run fieldMap -F $'\t' --filter '$0 ~ /\S/' 1 0 "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "0	first	100	A Here
0	no4	201
0			last
0" ]
}

@test "only filtering empty lines" {
    run fieldMap -F $'\t' --filter '$0 ~ /\S/' "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	no4	201
bzz			last
eof" ]
}
