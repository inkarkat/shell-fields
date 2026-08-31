#!/usr/bin/env bats

load fixture

@test "outside range via two smaller-or-larger comparisons of int field prints any matching line" {
    run -0 fieldFilterNumber -F $'\t' 2 -lt 2000 2 -gt 4000 "${BATS_TEST_DIRNAME}/tabbed.txt"
	assert_output - <<'EOF'
foo	1337	3	-4321	1.11
bar	4711	1	5849	5.12
baz	1111	2	9876	2.56
eof		0		-7.777
EOF
}

@test "inside range via two larger-or-smaller comparisons of int field prints any matching line" {
    skip
    run -0 fieldFilterNumber -F $'\t' 2 -gt 2000 2 -lt 4000 "${BATS_TEST_DIRNAME}/tabbed.txt"
	assert_output - <<'EOF'
quux	3333	4	-1001	1.11
EOF
}

@test "additional superfluous comparisions do not change result" {
    skip
    run -0 fieldFilterNumber -F $'\t' 2 -gt 2000 2 -gt 3500 2 -lt 4000 2 -lt 5000 "${BATS_TEST_DIRNAME}/tabbed.txt"
	assert_output - <<'EOF'
quux	3333	4	-1001	1.11
EOF
}
