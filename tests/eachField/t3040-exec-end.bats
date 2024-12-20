#!/usr/bin/env bats

load fixture

@test "pick second field and uppercase it" {
    EACHFIELD_EXEC_END=END run -0 eachField --exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ END 2 "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output - <<'EOF'
ONE
TWO
THREE
FOUR
EOF
}
