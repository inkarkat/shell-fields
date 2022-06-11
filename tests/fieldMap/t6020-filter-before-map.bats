#!/usr/bin/env bats

@test "filtering happens before mapping" {
    run fieldMap -F $'\t' 1 '++counter' --filter '$0 ~ /\S/' "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "1	first	100	A Here
2	no4	201
3			last
4" ]
}
