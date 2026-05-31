#!/usr/bin/env bats

load fixture

@test "grep the last field with generic pattern yields all lines" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . -1
    assert_output "$(cat "${BATS_TEST_DIRNAME}/tabbed.txt")"
}

@test "grep the first field with fixed text yields one line" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --fixed-strings --regexp oo 1
    assert_output 'foo	first	100	A Here'
}

@test "grep the second from last field with a text-only regexp yields two lines" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp 0 -2
    assert_output - <<'EOF'
foo	first	100	A Here
bar	second	201	B There
EOF
}

@test "grep the second field with a regexp yields two lines" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp '^.....$' 2
    assert_output - <<'EOF'
foo	first	100	A Here
baz	third	333	C U
EOF
}

@test "grep the last field with a non-matching pattern yields nothing and exits with 1" {
    run -1 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp doesNotMatch -1
    assert_output ''
}
