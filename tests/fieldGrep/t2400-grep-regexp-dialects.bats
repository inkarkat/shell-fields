#!/usr/bin/env bats

load fixture

@test "grep the first and second fields with basic regexp" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --basic-regexp --regexp 'oo\+' --regexp '^.\{5\}$' 1 2
    assert_output - <<'EOF'
foo	first	100	A Here
third		333	C U
EOF
}

@test "grep the first and second fields with extended regexp" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --extended-regexp --regexp 'oo+' --regexp '^.{5}$' 1 2
    assert_output - <<'EOF'
foo	first	100	A Here
third		333	C U
EOF
}

@test "grep the first and second fields with Perl regexp" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --perl-regexp --regexp 'oo+|^.{5}$' 1 2
    assert_output - <<'EOF'
foo	first	100	A Here
third		333	C U
EOF
}
