#!/usr/bin/env bats

load coproc

@test "coproc that duplicates lines" {
    run fieldMap -F $'\t' 1 "|$sedCommand -e 's/^\$/(empty)/' -e p" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
foo	no4	201
bar			
bar			last
(empty)
(empty)" ]
}

@test "coproc pipeline" {
    run fieldMap -F $'\t' 1 "|$uppercaseCommand | $sedCommand 's/.*/[&]/'" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "[FOO]	first	100	A Here
[BAR]	no4	201
[]			
[BZZ]			last
[]
[EOF]" ]
}
