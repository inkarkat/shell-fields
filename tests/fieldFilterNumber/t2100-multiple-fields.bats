#!/usr/bin/env bats

load fixture

@test "two greater than comparisons of int fields prints any matching line" {
    run -0 fieldFilterNumber -F $'\t' 2 -gt 2222 4 -gt 0 "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
bar	4711	1	5849	5.12
baz	1111	2	9876	2.56
quux	3333	4	-1001	1.11
EOF
}

@test "greater than and less than comparisons prints any matching line" {
    run -0 fieldFilterNumber -F $'\t' 2 -gt 2222 5 -lt 0 "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
bar	4711	1	5849	5.12
quux	3333	4	-1001	1.11
eof		0		-7.777
EOF
}
