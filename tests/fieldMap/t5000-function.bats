#!/usr/bin/env bats

load fixture

@test "replacing third field with concatenation of first two fields via function" {
    run -0 fieldMap -F $'\t' --function 'concatenate(arg1, arg2) {
    return arg1 arg2
}' 3 'concatenate($1, $2)' "${BATS_TEST_DIRNAME}/tabbed.txt"

    assert_output - <<'EOF'
foo	first	foofirst	A Here
bar	no4	barno4
			
bzz		bzz	last
		
eof		eof
EOF
}

@test "accumulating first field values via function" {
    run -0 fieldMap -F $'\t' --function 'accumulate1() {
    accu = accu $1
    return accu
}' 1 'accumulate1()' "${BATS_TEST_DIRNAME}/tabbed.txt"

    assert_output - <<'EOF'
foo	first	100	A Here
foobar	no4	201
foobar			
foobarbzz			last
foobarbzz
foobarbzzeof
EOF
}

@test "using multiple functions" {
    run -0 fieldMap -F $'\t' --function 'shout(text) { return toupper(text); }' --function 'wrap(text) { return "[" text "]"; }' 1 'toupper($fieldNr)' -1 'wrap(toupper($fieldNr))' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
FOO	first	100	[A HERE]
BAR	no4	[201]
			[]
BZZ			[LAST]

[EOF]
EOF
}
