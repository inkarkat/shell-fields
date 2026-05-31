#!/usr/bin/env bats

load fixture

@test "grep the last two fields with generic pattern yields all lines" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp . -2 -1
    assert_output "$(cat "${BATS_TEST_DIRNAME}/tabbed.txt")"
}

@test "grep the first two fields with fixed text yields one line with just the matching field and an empty one" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --fixed-strings --regexp oo 1 2
    assert_output 'foo		100	A Here'
}

@test "grep the first and last fields with fixed text yields the matching fields" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --fixed-strings --regexp r 1 -1
    assert_output - <<'EOF'
	first	100	A Here
bar	second	201	B There
EOF
}

@test "grep the first and last fields with regexp that matches both fields yields those lines" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp 'oo$\|^A' 1 -1
    assert_output 'foo	first	100	A Here'
}
