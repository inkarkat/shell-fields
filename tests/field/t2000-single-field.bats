#!/usr/bin/env bats

load fixture

@test "print the first field" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1
    assert_output - <<'EOF'
foo
bar
baz
EOF
}

@test "print the last field" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' -1
    assert_output - <<'EOF'
A Here
B There
C U
EOF
}

@test "print the second from last field" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' -2
    assert_output - <<'EOF'
100
201
333
EOF
}
