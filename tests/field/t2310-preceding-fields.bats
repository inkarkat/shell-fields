#!/usr/bin/env bats

load fixture

@test "print everyting from the second-to-last field with original separators" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' -2...
    assert_output - <<'EOF'
foo	first	100
bar	second	201
baz	third	333
EOF
}

@test "print everyting from the third-to-last and second-to-last fields with original separators" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' -3... -2
    assert_output - <<'EOF'
foo	first	100
bar	second	201
baz	third	333
EOF
}

@test "print everyting from the third-to-last, second-to-last and last fields with custom separators" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' -3... - -2 @ -1
    assert_output - <<'EOF'
foo-first-100@A Here
bar-second-201@B There
baz-third-333@C U
EOF
}

@test "print everyting from the third-to-last, second-to-last and last fields with one custom separator" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' -3... - -2 -1
    assert_output - <<'EOF'
foo-first-100	A Here
bar-second-201	B There
baz-third-333	C U
EOF
}

@test "print everyting from the second-to-last with one custom separator" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' -2... -
    assert_output - <<'EOF'
foo-first-100
bar-second-201
baz-third-333
EOF
}
