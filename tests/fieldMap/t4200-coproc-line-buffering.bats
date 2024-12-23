#!/usr/bin/env bats

load coproc

@test "uppercasing via buffered command fails" {
    [ -t 0 ] || skip 'Not reading from terminal'
    run -124 timeout 2s fieldMap -F $'\t' 1 "|${uppercaseCommand/--unbuffered}" "${BATS_TEST_DIRNAME}/tabbed.txt"
}

@test "allocate pty to force line buffering in uppercasing command" {
    [ -t 0 ] || skip 'Not reading from terminal'
    run -0 fieldMap -F $'\t' 1 "+|${uppercaseCommand/--unbuffered}" "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'END'
FOO	first	100	A Here
BAR	no4	201
			
BZZ			last

EOF
END
}

@test "allocate pty with prepended AWK-EXPR" {
    [ -t 0 ] || skip 'Not reading from terminal'
    run -0 fieldMap -F $'\t' 4 '$1 "-" $2+|'"${uppercaseCommand/--unbuffered}" "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	FOO-FIRST
bar	no4	201	BAR-NO4
			-
bzz			BZZ-
			-
eof			EOF-
EOF
}
