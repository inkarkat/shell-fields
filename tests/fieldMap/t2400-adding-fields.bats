#!/usr/bin/env bats

@test "adding a fixed fifth field with fixed value X" {
    run fieldMap -F $'\t' 5 '"X"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here	X
bar	no4	201		X
				X
bzz			last	X
				X
eof				X" ]
}

@test "adding a new field with fixed value X" {
    run fieldMap -F $'\t' +1 '"X"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here	X
bar	no4	201	X
				X
bzz			last	X
X
eof	X" ]
}

@test "adding a fixed sixth field with fixed value X" {
    run fieldMap -F $'\t' 6 '"X"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here		X
bar	no4	201			X
					X
bzz			last		X
					X
eof					X" ]
}

@test "adding two new fields first one indirectly with fixed values empty and X" {
    run fieldMap -F $'\t' +2 '"X"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here		X
bar	no4	201		X
					X
bzz			last		X
	X
eof		X" ]
}
