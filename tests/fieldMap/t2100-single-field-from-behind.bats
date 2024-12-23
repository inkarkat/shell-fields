#!/usr/bin/env bats

load fixture

@test "adding 42 to third field" {
    run -0 fieldMap -F $'\t' 3 '$fieldNr + 42' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	142	A Here
bar	no4	243
		42	
bzz		42	last
		42
eof		42
EOF
}

@test "concatenating X to second-to-last field" {
    run -0 fieldMap -F $'\t' -2 '$fieldNr "X"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100X	A Here
bar	no4X	201
		X	
bzz		X	last

eof
EOF
}

@test "concatenating X after third-to-last field" {
    run -0 fieldMap -F $'\t' -3 '$fieldNr "X"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	firstX	100	A Here
barX	no4	201
	X		
bzz	X		last

eof
EOF
}
