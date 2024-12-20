#!/usr/bin/env bats

load fixture

setup()
{
    export FILE1="${BATS_TMPDIR}/input1.txt"
    export FILE2="${BATS_TMPDIR}/input2.txt"
    cp -f "${BATS_TEST_DIRNAME}/pasta.txt" "$FILE1"
    cp -f "${BATS_TEST_DIRNAME}/tabbed.txt" "$FILE2"
}

@test "second field is removed in all files in-place" {
    run -0 onFieldChange --in-place -F $'\t' --remove-fields --command 'echo >&2 Change in {}' 2 "$FILE1" "$FILE2"
    assert_output - <<'EOF'
Change in 2
Change in 3
Change in 6
Change in 7
Change in 8
Change in 11
Change in 13
Change in 15
EOF
    diff -y - --label expected "$FILE1" <<'EOF'
ramen
ramen
ramen
penne
ravioli
ravioli
EOF
    diff -y - --label expected "$FILE2" <<'EOF'
foo	low	X
foo	low	X
bar	low	X	#
bar	low	X
	low	X	#
bar	low	X
bar	high	X	@
	high	X	@
	high	X
EOF
}
