#!/usr/bin/env bats

@test "drop middle field" {
    run eachField 1 3 "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ "$status" -eq 0 ]
    [ "$output" = "foo	haha
bar	hehe
baz	hihi
end	hoho" ]
}

@test "reorder fields" {
    run eachField 3 1 2 "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ "$status" -eq 0 ]
    [ "$output" = "haha	foo	one
hehe	bar	two
hihi	baz	three
hoho	end	four" ]
}

@test "address fields from behind" {
    run eachField -1 -2 "${BATS_TEST_DIRNAME}/jagged-tabbed.txt"
    [ "$status" -eq 0 ]
    [ "$output" = "one	foo
more	two
three	baz
fields	more
gap	no
six	end" ]
}

@test "address non-existing fields from behind" {
    run eachField -111 -1 -10 -2 -33 "${BATS_TEST_DIRNAME}/jagged-tabbed.txt"
    [ "$status" -eq 0 ]
    [ "$output" = "one	foo
more	two
three	baz
fields	more
gap	no
six	end" ]
}
