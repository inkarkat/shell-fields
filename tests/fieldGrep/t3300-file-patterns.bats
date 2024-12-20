#!/usr/bin/env bats

load fixture

@test "grep the first and second fields with basic regexps from file" {
run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --basic-regexp --file <(printf 'oo\\+\n^.\\{5\\}$\n') 1 2
    assert_output - <<'EOF'
foo	first	100	A Here
third		333	C U
EOF
}
