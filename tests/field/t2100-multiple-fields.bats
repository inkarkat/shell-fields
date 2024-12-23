#!/usr/bin/env bats

load fixture

@test "print the first two fields with original separators" {
    run -0 field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 2
    assert_output - <<'EOF'
foo	first
bar	second
baz	third
EOF
}

@test "print the second and last fields with original separators" {
    run -0 field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 2 -1
    assert_output - <<'EOF'
first	A Here
second	B There
third	C U
EOF
}

@test "print all fields in reverse order with original separators" {
    run -0 field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 4 3 2 1
    assert_output - <<'EOF'
A Here	100	first	foo
B There	201	second	bar
C U	333	third	baz
EOF
}
