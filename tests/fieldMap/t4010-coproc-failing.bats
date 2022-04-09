#!/usr/bin/env bats

load coproc

@test "uppercasing first field failing after first line yields empty fields" {
    run fieldMap -F $'\t' 1 "|$uppercaseCommand -e 'q 42'" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "FOO	first	100	A Here
	no4	201
			
			last" ]
}

@test "coproc command that does not exist yields empty fields" {
    runStdout fieldMap -F $'\t' 1 '|doesNotExist' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "	first	100	A Here
	no4	201
			
			last" ]
}
@test "coproc command that does not exist prints shell error to stderr" {
    runStderr fieldMap -F $'\t' 1 '|doesNotExist' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "sh: 1: doesNotExist: not found" ]
}
