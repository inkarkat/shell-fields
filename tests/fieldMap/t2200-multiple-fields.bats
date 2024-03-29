#!/usr/bin/env bats

@test "concatenating fox to second and fun to fourth field" {
    run fieldMap -F $'\t' 2 '$fieldNr "fox"' 4 '$fieldNr "fun"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	firstfox	100	A Herefun
bar	no4fox	201	fun
	fox		fun
bzz	fox		lastfun
	fox		fun
eof	fox		fun" ]
}

@test "replacing second with fox and last with number of fields" {
    run fieldMap -F $'\t' 2 '"fox"' 4 'NF' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	fox	100	4
bar	fox	201	3
	fox		4
bzz	fox		4
	fox		2
eof	fox		2" ]
}

@test "replacing last with number and second with fox of fields" {
    run fieldMap -F $'\t' 4 'NF' 2 '"fox"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	fox	100	4
bar	fox	201	3
	fox		4
bzz	fox		4
	fox		0
eof	fox		1" ]
}

@test "concatenating X, Y, Z all after the same second field uses each in sequence" {
    run fieldMap -F $'\t' 2 '$fieldNr "X"' 2 '$fieldNr "Y"' 2 '$fieldNr "Z"'  "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	firstXYZ	100	A Here
bar	no4XYZ	201
	XYZ		
bzz	XYZ		last
	XYZ
eof	XYZ" ]
}

@test "concatenating X, Z both after the same second field and Y after the second-to-last field uses each in sequence" {
    run fieldMap -F $'\t' 2 '$fieldNr "X"' -2 '$fieldNr "Y"' 2 '$fieldNr "Z"'  "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	firstXZ	100Y	A Here
bar	no4XYZ	201
	XZ	Y	
bzz	XZ	Y	last
	XZ
eof	XZ" ]
}
