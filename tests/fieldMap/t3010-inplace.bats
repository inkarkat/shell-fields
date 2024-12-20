#!/usr/bin/env bats

load fixture

setup()
{
    export FILE="${BATS_TMPDIR}/input.txt"
    cp -f "${BATS_TEST_DIRNAME}/tabbed.txt" "$FILE"
}

@test "concatenating fox to second and number of fields to last field in-place modifies the input file" {
    run -0 fieldMap --in-place -F $'\t' 2 '$fieldNr "fox"' 4 '$fieldNr NF' "$FILE"
    assert_output ''
    diff -y - --label expected "$FILE" <<'EOF'
foo	firstfox	100	A Here4
bar	no4fox	201	3
	fox		4
bzz	fox		last4
	fox		2
eof	fox		2
EOF
}

@test "concatenating fox to second and number of fields to last field in-place modifies the input file and writes a backup" {
    run -0 fieldMap --in-place=.bak -F $'\t' 2 '$fieldNr "fox"' 4 '$fieldNr NF' "$FILE"
    assert_output ''
    diff -y - --label expected "$FILE" <<'EOF'
foo	firstfox	100	A Here4
bar	no4fox	201	3
	fox		4
bzz	fox		last4
	fox		2
eof	fox		2
EOF

    assert_exists "${FILE}.bak"
    diff -y "${BATS_TEST_DIRNAME}/tabbed.txt" "${FILE}.bak"
}
