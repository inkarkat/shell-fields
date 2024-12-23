#!/usr/bin/env bats

load fixture

@test "adding 42 after last field" {
    run -0 addField -F $'\t' -1 42 "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	A Here	42
bar	no4	201	42
				42
bzz			last	42
42
eof	42
EOF
}


@test "adding X after second-to-last field" {
    run -0 addField -F $'\t' -2 '"X"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	X	A Here
bar	no4	X	201
			X	
bzz			X	last

X	eof
EOF
}

@test "adding X after third-to-last field" {
    run -0 addField -F $'\t' -3 '"X"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	X	100	A Here
bar	X	no4	201
		X		
bzz		X		last

eof
EOF
}
