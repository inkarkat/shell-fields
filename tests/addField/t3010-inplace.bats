#!/usr/bin/env bats

load fixture

setup()
{
    export FILE="${BATS_TMPDIR}/input.txt"
    cp -f "${BATS_TEST_DIRNAME}/tabbed.txt" "$FILE"
}

@test "adding fox after second and number of fields after last field in-place modifies the input file" {
    run -0 addField --in-place -F $'\t' 2 '"fox"' 4 'NF' "$FILE"
    assert_output ''
    diff -y - --label expected "$FILE" <<'EOF'
foo	first	fox	100	A Here	4
bar	no4	fox	201		3
		fox			4
bzz		fox		last	4
		fox			0
eof		fox			1
EOF
}

@test "adding fox after second and number of fields after last field in-place modifies the input file and writes a backup" {
    run -0 addField --in-place=.bak -F $'\t' 2 '"fox"' 4 'NF' "$FILE"
    assert_output ''
    diff -y - --label expected "$FILE" <<'EOF'
foo	first	fox	100	A Here	4
bar	no4	fox	201		3
		fox			4
bzz		fox		last	4
		fox			0
eof		fox			1
EOF
    assert_exists "${FILE}.bak"
    diff -y "${BATS_TEST_DIRNAME}/tabbed.txt" "${FILE}.bak"
}
