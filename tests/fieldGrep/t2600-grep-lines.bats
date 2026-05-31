#!/usr/bin/env bats

load fixture

@test "grep entire line in the last field" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" --line-regexp --regexp '[Hh]er[^ ]' -1
    assert_output "foo	first	100	A	Here"
}

@test "grep literal entire line in the last field" {
    type -t toLiteralRegexp >/dev/null || skip 'toLiteralRegexp is not available'
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" --ignore-case --fixed-strings --line-regexp --regexp 'here' -1
    assert_output "foo	first	100	A	Here"
}

@test "grep entire lines from file in the last field" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" --line-regexp --file <(printf '[Hh]er[^ ]\n[UVW]\n') -1
    assert_output - <<'EOF'
foo	first	100	A	Here
baz	third	333	C	U
EOF
}

@test "grep literal entire lines from file in the last field" {
    type -t toLiteralRegexp >/dev/null || skip 'toLiteralRegexp is not available'
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" --ignore-case --fixed-strings --line-regexp --file <(printf 'here\nU\n') -1
    assert_output - <<'EOF'
foo	first	100	A	Here
baz	third	333	C	U
EOF
}
