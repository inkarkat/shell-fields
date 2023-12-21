#!/usr/bin/env bats

@test "appending 42 after last field" {
    run addField -F $'\t' +0 42 "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here	42
bar	no4	201	42
				42
bzz			last	42
42
eof	42" ]
}


@test "appending X with empty field after last field" {
    run addField -F $'\t' +1 '"X"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here		X
bar	no4	201		X
					X
bzz			last		X
	X
eof		X" ]
}

@test "appending X with two empty fields after last field" {
    run addField -F $'\t' +2 '"X"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here			X
bar	no4	201			X
						X
bzz			last			X
		X
eof			X" ]
}
