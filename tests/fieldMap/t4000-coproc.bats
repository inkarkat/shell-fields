#!/usr/bin/env bats

readonly uppercaseCommand='sed --unbuffered y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/'

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
