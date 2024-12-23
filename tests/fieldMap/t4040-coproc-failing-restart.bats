#!/usr/bin/env bats

load coproc

@test "restarting coproc failure on uppercasing first field failing yields empty field then restarts" {
    run -0 fieldMap -F $'\t' --coprocess-error restart 1 "|$sedCommand -e '/b/Q 42' -e 's/^\$/DEFAULT/' -e t -e 's/.*/-&-/'" "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
-foo-	first	100	A Here
	no4	201
DEFAULT			
			last
DEFAULT
-eof-
EOF
}

@test "restarting coproc failure on uppercasing first field failing yields passed error value then restarts" {
    run -0 fieldMap -F $'\t' --coprocess-error restart --coprocess-error-value 'foo bar' 1 "|$sedCommand -e '/b/Q 42' -e 's/^\$/DEFAULT/' -e t -e 's/.*/-&-/'" "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
-foo-	first	100	A Here
foo bar	no4	201
DEFAULT			
foo bar			last
DEFAULT
-eof-
EOF
}
