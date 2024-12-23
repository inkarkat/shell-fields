#!/usr/bin/env bats

load coproc

@test "ignoring coproc failure on uppercasing first field failing after first line yields empty fields" {
    run -0 fieldMap -F $'\t' --coprocess-error ignore 1 "|$uppercaseCommand -e 'q 42'" "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
FOO	first	100	A Here
	no4	201
			
			last
EOF
}

@test "ignoring coproc failure on coproc command that does not exist yields empty fields" {
    run -0 --separate-stderr fieldMap -F $'\t' --coprocess-error ignore 1 '|doesNotExist' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
	first	100	A Here
	no4	201
			
			last
EOF
}

@test "ignoring coproc failure on coproc command that does not exist prints shell error to stderr" {
    run -0 --separate-stderr fieldMap -F $'\t' --coprocess-error ignore 1 '|doesNotExist' "${BATS_TEST_DIRNAME}/tabbed.txt"
    output="$stderr" assert_output 'sh: 1: doesNotExist: not found'
}
