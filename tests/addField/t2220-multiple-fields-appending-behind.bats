#!/usr/bin/env bats

@test "adding fox and fun both after the last field" {
    run addField -F $'\t' -1 '"fox"' -1 '"fun"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here	fox
bar	no4	201	fox
				fox
bzz			last	fox
fox
eof	fox" ]
}

@test "appending fox and fun both after the last field" {
    run addField -F $'\t' +0 '"fox"' +0 '"fun"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here	fox	fun
bar	no4	201	fox	fun
				fox	fun
bzz			last	fox	fun
fox	fun
eof	fox	fun" ]
}

@test "appending fox and fun both after the last field with mixed addressing" {
    run addField -F $'\t' -1 '"fox"' +0 '"fun"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here	fox	fun
bar	no4	201	fox	fun
				fox	fun
bzz			last	fox	fun
fox	fun
eof	fox	fun" ]
}

@test "adding fox after the last and fun with empty field" {
    run addField -F $'\t' -1 '"fox"' +1 '"fun"' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here	fox		fun
bar	no4	201	fox		fun
				fox		fun
bzz			last	fox		fun
fox		fun
eof	fox		fun" ]
}
