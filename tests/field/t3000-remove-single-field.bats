#!/usr/bin/env bats

load fixture

@test "print everything but the first field" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1
    assert_output - <<'EOF'
first	100	A Here
second	201	B There
third	333	C U
EOF
}

@test "print everything but the last field" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove -1
    assert_output - <<'EOF'
foo	first	100
bar	second	201
baz	third	333
EOF
}

@test "print everything but the second from last field" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove -2
    assert_output - <<'EOF'
foo	first	A Here
bar	second	B There
baz	third	C U
EOF
}
