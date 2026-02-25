#!/usr/bin/env bats

load fixture

@test "print the first two fields with custom output separator" {
    run -0 field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --output-separator -,- 1 2
    assert_output - <<'EOF'
foo-,-first
bar-,-second
baz-,-third
EOF
}

@test "print everything but the first field with custom output separator" {
    run -0 field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --output-separator , --remove 1
    assert_output - <<'EOF'
first,100,A Here
second,201,B There
third,333,C U
EOF
}
