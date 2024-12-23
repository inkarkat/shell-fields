#!/usr/bin/env bats

load fixture

@test "concatenating fox to second and number of fields to last field from stdin" {
    run -0 fieldMap -F $'\t' 2 '$fieldNr "fox"' 4 '$fieldNr NF' < "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	firstfox	100	A Here4
bar	no4fox	201	3
	fox		4
bzz	fox		last4
	fox		2
eof	fox		2
EOF
}
