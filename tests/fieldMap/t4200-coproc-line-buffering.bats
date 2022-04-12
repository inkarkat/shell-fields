#!/usr/bin/env bats

load coproc

@test "uppercasing via buffered command fails" {
    run timeout 2s fieldMap -F $'\t' 1 "|${uppercaseCommand/--unbuffered}" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 124 ]
}

@test "allocate pty to force line buffering in uppercasing command" {
    run fieldMap -F $'\t' 1 "+|${uppercaseCommand/--unbuffered}" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "FOO	first	100	A Here
BAR	no4	201
			
BZZ			last

EOF" ]
}

@test "allocate pty with prependec AWK-EXPR" {
    run fieldMap -F $'\t' 4 '$1 "-" $2+|'"${uppercaseCommand/--unbuffered}" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	FOO-FIRST
bar	no4	201	BAR-NO4
			-
bzz			BZZ-
			-
eof			EOF-" ]
}
