#!/usr/bin/env bats

load fixture

@test "print the first two fields with custom separator" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 - 2
    assert_output - <<'EOF'
foo-first
bar-second
baz-third
EOF
}

@test "print the first, second and last fields with custom separators" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 @ 2 - -1
    assert_output - <<'EOF'
foo@first-A Here
bar@second-B There
baz@third-C U
EOF
}

@test "print all fields in reverse order with custom and original separators" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 4 3 - 2 1
    assert_output - <<'EOF'
A Here	100-first	foo
B There	201-second	bar
C U	333-third	baz
EOF
}

@test "print all fields in reverse order with custom separators containing and consisting of whitespace" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 4 '  ' 3 ' - ' 2 $'\t' 1
    assert_output - <<'EOF'
A Here  100 - first	foo
B There  201 - second	bar
C U  333 - third	baz
EOF
}

@test "print all fields in reverse order with special custom separators" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 4 \" 3 \\ 2 $'\n' 1
    assert_output - <<'EOF'
A Here"100\first
foo
B There"201\second
bar
C U"333\third
baz
EOF
}

@test "print all fields in reverse order with empty separators" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 4 '' 3 '' 2 '' 1
    assert_output - <<'EOF'
A Here100firstfoo
B There201secondbar
C U333thirdbaz
EOF
}
