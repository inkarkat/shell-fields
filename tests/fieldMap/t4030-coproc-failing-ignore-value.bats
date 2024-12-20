#!/usr/bin/env bats

load coproc

@test "ignoring coproc failure on uppercasing first field failing after first line yields passed error value" {
    run -0 fieldMap -F $'\t' --coprocess-error ignore --coprocess-error-value 'foo bar' 1 "|$uppercaseCommand -e 'q 42'" "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
FOO	first	100	A Here
foo bar	no4	201
foo bar			
foo bar			last
foo bar
foo bar
EOF
}
