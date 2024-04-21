#!/usr/bin/env bats

@test "constant field does not change the output" {
    run onFieldChange -F $'\t' --unbuffered --command 'echo vvv' 4 "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "$(cat -- "${BATS_TEST_DIRNAME}/tabbed.txt")" ]
}

@test "printing vvv before single field change" {
    run onFieldChange -F $'\t' --unbuffered --command 'echo vvv' 3 "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "foo	1	low	X
foo	0	low	X
bar	0	low	X	#
bar	0	low	X
	1	low	X	#
bar	1	low	X
vvv
bar	0	high	X	@
	0	high	X	@
	1	high	X" ]
}

@test "printing vvv before every field change" {
    run onFieldChange -F $'\t' --unbuffered --command 'echo vvv' 2 "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "foo	1	low	X
vvv
foo	0	low	X
bar	0	low	X	#
bar	0	low	X
vvv
	1	low	X	#
bar	1	low	X
vvv
bar	0	high	X	@
	0	high	X	@
vvv
	1	high	X" ]
}
