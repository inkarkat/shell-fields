#!/usr/bin/env bats

load coproc

@test "default failure on uppercasing first field failing after first line yields only first line and exit status 1" {
    run fieldMap -F $'\t' 1 "|$uppercaseCommand -e 'q 42'" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 1 ]
    [ "$output" = "FOO	first	100	A Here" ]
}

@test "aborting coproc failure on uppercasing first field failing after first line yields only first line and exit status 1" {
    run fieldMap -F $'\t' --coprocess-error abort 1 "|$uppercaseCommand -e 'q 42'" "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 1 ]
    [ "$output" = "FOO	first	100	A Here" ]
}

@test "aborting coproc coproc failure on coproc command that does not exist yields no output and exit status 1" {
    runStdout fieldMap -F $'\t' --coprocess-error abort 1 '|doesNotExist' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "default failure on coproc command that does not exist prints shell error to stderr and exit status 1" {
    runStderr fieldMap -F $'\t' --coprocess-error abort 1 '|doesNotExist' "${BATS_TEST_DIRNAME}/tabbed.txt"

    [ $status -eq 1 ]
    [ "$output" = "sh: 1: doesNotExist: not found" ]
}
