#!/usr/bin/env bats

load coproc

@test "uppercasing first field" {
    run fieldMap -F $'\t' 1 "|$uppercaseCommand" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "FOO	first	100	A Here
BAR	no4	201
			
BZZ			last

EOF" ]
}

@test "transforming second field into uppercased first field" {
    run fieldMap -F $'\t' 2 "\$1|$uppercaseCommand" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	FOO	100	A Here
bar	BAR	201
			
bzz	BZZ		last
	
eof	EOF" ]
}

@test "uppercasing first field and counting last field" {
    run fieldMap -F $'\t' 1 "|$uppercaseCommand" -1 "|$countCommand" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "FOO	first	100	1
BAR	no4	2
			3
BZZ			4

5" ]
}

@test "same coproc for multiple fields is reused, not instantiated twice" {
    run fieldMap -F $'\t' 1 "|$countCommand" -1 "|$countCommand" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "1	first	100	2
3	no4	4
5			6
7			8
9
11" ]
}

@test "reuse of coproc can be prevented by adding whitespace" {
    run fieldMap -F $'\t' 1 "|$countCommand" -1 "| $countCommand" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "1	first	100	1
2	no4	2
3			3
4			4
5
5" ]
}
