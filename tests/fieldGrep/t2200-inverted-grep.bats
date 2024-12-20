#!/usr/bin/env bats

load fixture

@test "grep the last field with inverted pattern that does not match yields all lines" {
    run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-match --regexp doesNotMatch -1
    assert_output - < "${BATS_TEST_DIRNAME}/tabbed.txt"
}

@test "grep the first field with inverted fixed text yields one line" {
    run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --fixed-strings --invert-match --regexp ba 1
    assert_output 'foo	first	100	A Here'
}

@test "grep the second from last field with an inverted text-only regexp yields two lines" {
    run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-match --regexp 3 -2
    assert_output - <<'EOF'
foo	first	100	A Here
bar	second	201	B There
EOF
}

@test "grep the second field with a regexp yields two lines" {
    run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' -v --regexp '^......$' 2
    assert_output - <<'EOF'
foo	first	100	A Here
baz	third	333	C U
EOF
}

@test "grep the last field with an inverted generic pattern yields nothing and exits with 1" {
    run -1 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-match --regexp . -1
    assert_output ''
}

@test "grep the first field with inverted fixed text that also matches in other columns yields two lines with incomplete fields" {
    run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-match --fixed-strings --regexp r 1
    assert_output - <<'EOF'
foo		100
baz		333	C U
EOF
}

@test "grep the first field with inverted match that primitively ensures to exclude other columns yields full two lines" {
    run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-match --regexp '^[^0-9	]\+r' 1
    assert_output - <<'EOF'
foo	first	100	A Here
baz	third	333	C U
EOF
}

@test "grep the first field with inverted match that excludes other columns via PCRE yields full two lines" {
    run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-match --perl-regexp --regexp '^(?!\d+\t).*r' 1
    assert_output - <<'EOF'
foo	first	100	A Here
baz	third	333	C U
EOF
}
