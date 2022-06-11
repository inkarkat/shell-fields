#!/usr/bin/env bats

load coproc

readonly filterNonO0Command="$sedCommand -e 's/.*[0oO].*/1/' -e t -e 's/.*/0/'"

@test "turning first field to 0 and filtering lines without 0 or 0 via coproc" {
    run fieldMap -F $'\t' --filter "|$filterNonO0Command" 1 0 "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "0	first	100	A Here
0	no4	201
0" ]
}

@test "filtering lines without 0 or o via coproc" {
    run fieldMap -F $'\t' --filter "|$filterNonO0Command" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
bar	no4	201
eof" ]
}

@test "filtering lines where the first field has no 0 or o via coproc" {
    run fieldMap -F $'\t' --filter "\$1|$filterNonO0Command" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
eof" ]
}
