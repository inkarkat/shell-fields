#!/usr/bin/env bats

load fixture

@test "adding a fixed fifth field with fixed value X" {
    run -0 fieldMap -F $'\t' 5 '"X"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	A Here	X
bar	no4	201		X
				X
bzz			last	X
				X
eof				X
EOF
}

@test "adding a new field with fixed value X" {
    run -0 fieldMap -F $'\t' +1 '"X"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	A Here	X
bar	no4	201	X
				X
bzz			last	X
X
eof	X
EOF
}

@test "adding a fixed sixth field with fixed value X" {
    run -0 fieldMap -F $'\t' 6 '"X"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	A Here		X
bar	no4	201			X
					X
bzz			last		X
					X
eof					X
EOF
}

@test "adding two new fields first one indirectly with fixed values empty and X" {
    run -0 fieldMap -F $'\t' +2 '"X"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	A Here		X
bar	no4	201		X
					X
bzz			last		X
	X
eof		X
EOF
}
