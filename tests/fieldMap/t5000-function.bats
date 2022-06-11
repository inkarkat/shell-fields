#!/usr/bin/env bats

@test "replacing third field with concatenation of first two fields via function" {
    run fieldMap -F $'\t' --function 'concatenate(arg1, arg2) {
    return arg1 arg2
}' 3 'concatenate($1, $2)' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	foofirst	A Here
bar	no4	barno4
			
bzz		bzz	last
		
eof		eof" ]
}

@test "accumulating first field values via function" {
    run fieldMap -F $'\t' --function 'accumulate1() {
    accu = accu $1
    return accu
}' 1 'accumulate1()' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here
foobar	no4	201
foobar			
foobarbzz			last
foobarbzz
foobarbzzeof" ]
}

@test "using multiple functions" {
    run fieldMap -F $'\t' --function 'shout(text) { return toupper(text); }' --function 'wrap(text) { return "[" text "]"; }' 1 'toupper($fieldNr)' -1 'wrap(toupper($fieldNr))' "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "FOO	first	100	[A HERE]
BAR	no4	[201]
			[]
BZZ			[LAST]
[]
[EOF]" ]
}
