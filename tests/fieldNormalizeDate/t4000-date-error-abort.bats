#!/usr/bin/env bats

load fixture

@test "invalid date in first field aborts processing by default and exits with status 1" {
    LC_ALL=C run -1 --separate-stderr fieldNormalizeDate -F $'\t' 1 -- "${BATS_TEST_DIRNAME}/bad.txt"
    assert_output ''
}

@test "invalid date in first field aborts processing with --date-error abort and exits with status 1" {
    LC_ALL=C run -1 --separate-stderr fieldNormalizeDate -F $'\t' --date-error abort 1 -- "${BATS_TEST_DIRNAME}/bad.txt"
    assert_output ''
}

@test "invalid date in first field aborts processing with --date-error abort and prints date error message" {
    LC_ALL=C run -1 --separate-stderr fieldNormalizeDate -F $'\t' --date-error abort 1 -- "${BATS_TEST_DIRNAME}/bad.txt"
    output="$stderr" assert_output "date: invalid date '01-01-1000'"
}
