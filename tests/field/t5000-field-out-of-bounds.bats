#!/usr/bin/env bats

load fixture

@test "field number 0 prints all fields" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 0
    assert_output "$(cat "${BATS_TEST_DIRNAME}/tabbed.txt")"
}

@test "too large positive field (by one) is treated as empty" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 5 2
    assert_output - <<'EOF'
foo		first
bar		second
baz		third
EOF
}

@test "too large positive field (by many) is treated as empty" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 10 2
    assert_output - <<'EOF'
foo		first
bar		second
baz		third
EOF
}

@test "too large negative field (by one) is treated as empty" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 -5 2
    assert_output - <<'EOF'
foo		first
bar		second
baz		third
EOF
}

@test "too large negative field (by many) is treated as empty" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 -10 2
    assert_output - <<'EOF'
foo		first
bar		second
baz		third
EOF
}
