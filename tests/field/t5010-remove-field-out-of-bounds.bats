#!/usr/bin/env bats

load fixture

@test "removing field number 0 removes nothing and prints all fields" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 0
    assert_output "$(cat "${BATS_TEST_DIRNAME}/tabbed.txt")"
}

@test "removing too large positive field (by one) is ignored" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1 5 4
    assert_output - <<'EOF'
first	100
second	201
third	333
EOF
}

@test "removing too large positive field (by many) is ignored" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1 10 4
    assert_output - <<'EOF'
first	100
second	201
third	333
EOF
}

@test "removing too large negative field (by one) is ignored" {
    run -0 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1 -5 4
    assert_output - <<'EOF'
first	100
second	201
third	333
EOF
}

@test "removing too large negative field (by many) is ignored" {
    run field --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove 1 -10 4
    assert_output - <<'EOF'
first	100
second	201
third	333
EOF
}
