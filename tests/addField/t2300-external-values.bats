#!/usr/bin/env bats

@test "adding external var1 after second and var2 after fourth field" {
    run addField -v var1=fox -v var2=fun -F $'\t' 2 'var1' 4 'var2' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "foo	first	fox	100	A Here	fun
bar	no4	fox	201		fun
		fox			fun
bzz		fox		last	fun
		fox			fun
eof		fox			fun" ]
}
