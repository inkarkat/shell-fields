#!/usr/bin/env bats

load markers

@test "field is removed" {
    run -0 onFieldChange -F $'\t' --remove-fields --command "touch ${MARKER_ONE@Q}" 3 "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_exists "$MARKER_ONE"
    assert_output - <<'EOF'
foo	1	X
foo	0	X
bar	0	X	#
bar	0	X
	1	X	#
bar	1	X
bar	0	X	@
	0	X	@
	1	X
EOF
}

@test "multiple fields are removed" {
    run -0 onFieldChange -F $'\t' --remove-fields --command : 1 --command : 3 --command : 5 "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
1	X
0	X
0	X
0	X
1	X
1	X
0	X
0	X
1	X
EOF
}
