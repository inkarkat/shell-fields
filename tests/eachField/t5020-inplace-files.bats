#!/usr/bin/env bats

setup()
{
    export FILE1="${BATS_TMPDIR}/input1.txt"
    export FILE2="${BATS_TMPDIR}/input2.txt"
    cp -f "${BATS_TEST_DIRNAME}/jagged-tabbed.txt" "$FILE1"
    cp -f "${BATS_TEST_DIRNAME}/gapped-tabbed.txt" "$FILE2"
}

@test "file marker command is applied to all files in-place" {
    run eachField --in-place --exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ {} \; "$FILE1" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$FILE1")" = "FOO	ONE			
BAR	TWO	MORE		
BAZ	THREE			
QUUX	FOUR	EVEN	MORE	FIELDS
LULLI	FIVE	NO	GAP	
END	SIX			" ]
    [ "$(cat "$FILE2")" = "FOO	ONE			
BAR	TWO	MORE		
BAZ	THREE			
QUUX	FOUR	EVEN	MORE	FIELDS
LULLI	FIVE	GAP		
END	SIX	FINAL		" ]
}
