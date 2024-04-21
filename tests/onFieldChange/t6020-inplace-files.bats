#!/usr/bin/env bats

setup()
{
    export FILE1="${BATS_TMPDIR}/input1.txt"
    export FILE2="${BATS_TMPDIR}/input2.txt"
    cp -f "${BATS_TEST_DIRNAME}/pasta.txt" "$FILE1"
    cp -f "${BATS_TEST_DIRNAME}/tabbed.txt" "$FILE2"
}

@test "second field is removed in all files in-place" {
    run onFieldChange --in-place -F $'\t' --remove-fields --command 'echo >&2 Change in {}' 2 "$FILE1" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "Change in 2
Change in 3
Change in 6
Change in 7
Change in 8
Change in 11
Change in 13
Change in 15" ]
    [ "$(cat "$FILE1")" = "ramen
ramen
ramen
penne
ravioli
ravioli" ]
    [ "$(cat "$FILE2")" = "foo	low	X
foo	low	X
bar	low	X	#
bar	low	X
	low	X	#
bar	low	X
bar	high	X	@
	high	X	@
	high	X" ]
}
