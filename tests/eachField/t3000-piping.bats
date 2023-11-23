#!/usr/bin/env bats

@test "command is applied to all fields to uppercase all fields" {
    run eachField --exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ \; "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "FOO	ONE	HAHA
BAR	TWO	HEHE
BAZ	THREE	HIHI
END	FOUR	HOHO" ]
}

@test "pick second field and uppercase it" {
    run eachField --exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ \; 2 "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "ONE
TWO
THREE
FOUR" ]
}

@test "pick second field and uppercase it, pass the others" {
    run eachField 1 --exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ \; 2 --pass 3 "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "foo	ONE	haha
bar	TWO	hehe
baz	THREE	hihi
end	FOUR	hoho" ]
}

@test "deletion of words with a is applied to all fields" {
    run eachField --exec grep -v a \; "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "foo	one	hehe
end	two	hihi
	three	hoho
	four	" ]
}
