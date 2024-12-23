#!/usr/bin/env bats

load coproc

@test "uppercasing first field" {
    run -0 fieldMap -F $'\t' 1 "|$uppercaseCommand" "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'END'
FOO	first	100	A Here
BAR	no4	201
			
BZZ			last

EOF
END
}

@test "transforming second field into uppercased first field" {
    run -0 fieldMap -F $'\t' 2 "\$1|$uppercaseCommand" "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	FOO	100	A Here
bar	BAR	201
			
bzz	BZZ		last
	
eof	EOF
EOF
}

@test "uppercasing first field and counting last field" {
    run -0 fieldMap -F $'\t' 1 "|$uppercaseCommand" -1 "|$countCommand" "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
FOO	first	100	1
BAR	no4	2
			3
BZZ			4

5
EOF
}

@test "same coproc for multiple fields is reused, not instantiated twice" {
    run -0 fieldMap -F $'\t' 1 "|$countCommand" -1 "|$countCommand" "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
1	first	100	2
3	no4	4
5			6
7			8
9
11
EOF
}

@test "reuse of coproc can be prevented by adding whitespace" {
    run -0 fieldMap -F $'\t' 1 "|$countCommand" -1 "| $countCommand" "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
1	first	100	1
2	no4	2
3			3
4			4
5
5
EOF
}
