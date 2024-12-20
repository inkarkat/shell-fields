#!/usr/bin/env bats

load fixture

@test "print the first field from stdin" {
    run -0 field -F $'\t' 1 < "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo
bar
baz
EOF
}

@test "print everything but the first field from stdin" {
    run -0 field -F $'\t' --remove 1 < "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
first	100	A Here
second	201	B There
third	333	C U
EOF
}
