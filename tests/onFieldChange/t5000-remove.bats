#!/usr/bin/env bats

load markers

@test "field is removed" {
    run onFieldChange -F $'\t' --remove-fields --command "touch ${MARKER_ONE@Q}" 3 "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ -e "$MARKER_ONE" ]
    [ "$output" = "foo	1	X
foo	0	X
bar	0	X	#
bar	0	X
	1	X	#
bar	1	X
bar	0	X	@
	0	X	@
	1	X" ]
}

@test "multiple fields are removed" {
    run onFieldChange -F $'\t' --remove-fields --command : 1 --command : 3 --command : 5 "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "1	X
0	X
0	X
0	X
1	X
1	X
0	X
0	X
1	X" ]
}
