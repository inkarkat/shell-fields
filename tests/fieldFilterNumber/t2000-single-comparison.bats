#!/usr/bin/env bats

load fixture

@test "greater than comparison of int field" {
    run -0 fieldFilterNumber -F $'\t' 2 -gt 2222 "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
bar	4711	1	5849	5.12
quux	3333	4	-1001	1.11
EOF
}

@test "equal comparison of float field" {
    run -0 fieldFilterNumber -F $'\t' 5 -eq 1.11 "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	1337	3	-4321	1.11
quux	3333	4	-1001	1.11
EOF
}

@test "not equal comparison of float field from behind" {
    run -0 fieldFilterNumber -F $'\t' -1 -ne 1.11 "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
bar	4711	1	5849	5.12
baz	1111	2	9876	2.56
xxx	42x	-	splunge	catch-22
eof		0		-7.777
EOF
}
