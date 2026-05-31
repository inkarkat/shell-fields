#!/usr/bin/env bats

load fixture

@test "print everyting from the second field with original separators" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 2...
    assert_output - <<'EOF'
first	100	A Here
second	201	B There
third	333	C U
EOF
}

@test "print the first, second and then everyting from the third field with custom separators" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 @ 2 - 3...
    assert_output - <<'EOF'
foo@first-100-A Here
bar@second-201-B There
baz@third-333-C U
EOF
}
