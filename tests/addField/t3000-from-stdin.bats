#!/usr/bin/env bats

load fixture

@test "adding fox after second and number of fields after last field from stdin" {
    run -0 addField -F $'\t' 2 '"fox"' 4 'NF' < "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	fox	100	A Here	4
bar	no4	fox	201		3
		fox			4
bzz		fox		last	4
		fox			0
eof		fox			1
EOF
}
