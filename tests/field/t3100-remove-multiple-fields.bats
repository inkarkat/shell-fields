#!/usr/bin/env bats

load fixture

@test "print everything but the first two fields" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1 2
    assert_output - <<'EOF'
100	A Here
201	B There
333	C U
EOF
}

@test "print everything but the second and last fields" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 2 -1
    assert_output - <<'EOF'
foo	100
bar	201
baz	333
EOF
}

@test "remove everything but the second field prints just the second field" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1 3 4
    assert_output - <<'EOF'
first
second
third
EOF
}

@test "removing all fields prints nothing" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 4 3 2 1
    assert_output ''
}
