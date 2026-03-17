#!/usr/bin/env bats

load fixture

@test "adding two new fields does not affect -N addressing from behind" {
    run -0 fieldMap -F $'\t' 5 '"X"' 6 '"Y"' -1 '"[" fieldNr "]"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	[4]	X	Y
bar	no4	[3]		X	Y
			[4]	X	Y
bzz			[4]	X	Y
				X	Y
[1]				X	Y
EOF
}

@test "adding two new fields does not affect +N addressing from behind" {
    run -0 fieldMap -F $'\t' 5 '"X"' +2 '"Y"' -1 '"[" fieldNr "]"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	[4]	X	Y
bar	no4	[3]		Y
			[4]	X	Y
bzz			[4]	X	Y
	Y			X
[1]		Y		X
EOF
}

@test "adding two new fields affects -N addressing from behind after reparsing" {
    run -0 fieldMap -F $'\t' 5 '"X"' 6 '"Y"' --reparse -3 '"[" fieldNr "]"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	[4]	X	Y
bar	no4	201	[4]	X	Y
			[4]	X	Y
bzz			[4]	X	Y
			[4]	X	Y
eof			[4]	X	Y
EOF
}

@test "adding two new fields affects +N addressing from behind after reparsing" {
    run -0 fieldMap -F $'\t' 5 '"X"' +2 '"Y"' --reparse -3 '"[" fieldNr "]"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	[4]	X	Y
bar	no4	[3]		Y
			[4]	X	Y
bzz			[4]	X	Y
	Y	[3]		X
eof		[3]		X
EOF
}


@test "referencing a changed value containing FS yields all three modified fields" {
    run -0 fieldMap -F $'\t' 1 '"X\tY\tZ"' +1 '$1' $"${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
X	Y	Z	first	100	A Here	X	Y	Z
X	Y	Z	no4	201	X	Y	Z
X	Y	Z				X	Y	Z
X	Y	Z			last	X	Y	Z
X	Y	Z
X	Y	Z	X	Y	Z
EOF
}

@test "referencing a changed value containing FS yields only the first modified field after reparsing" {
    run -0 fieldMap -F $'\t' 1 '"X\tY\tZ"' --reparse +1 '$1' $"${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
X	Y	Z	first	100	A Here	X
X	Y	Z	no4	201	X
X	Y	Z				X
X	Y	Z			last	X
X	Y	Z	X
X	Y	Z	X
EOF
}

@test "referencing a changed value containing FS yields modified fields separately after reparsing" {
    run -0 fieldMap -F $'\t' 1 '"X\tY\tZ"' --reparse +1 '$3 "-" $1' $"${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
X	Y	Z	first	100	A Here	Z-X
X	Y	Z	no4	201	Z-X
X	Y	Z				Z-X
X	Y	Z			last	Z-X
X	Y	Z	Z-X
X	Y	Z	Z-X
EOF
}
