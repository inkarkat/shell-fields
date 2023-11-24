#!/usr/bin/env bats

setup()
{
    export FILE="${BATS_TMPDIR}/input.txt"
    cp -f "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt" "$FILE"
}

@test "file marker command is applied to all fields to uppercase all fields in-place" {
    run eachField --in-place --exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ {} \; "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$FILE")" = "FOO	ONE	HAHA
BAR	TWO	HEHE
BAZ	THREE	HIHI
END	FOUR	HOHO" ]
}

@test "file marker command is applied to all fields to uppercase all fields in-place and writes a backup" {
    run eachField --in-place=.bak --exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ {} \; "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$FILE")" = "FOO	ONE	HAHA
BAR	TWO	HEHE
BAZ	THREE	HIHI
END	FOUR	HOHO" ]
    [ -e "${FILE}.bak" ]
    cmp -- "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt" "${FILE}.bak"
}
