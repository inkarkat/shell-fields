#!/usr/bin/env bats

load fixture

@test "invalid date in first field gets replaced with message with --date-error message" {
    LC_ALL=C runStdout fieldNormalizeDate -F $'\t' --date-error message 1 -- "${BATS_TEST_DIRNAME}/bad.txt"
    [ $status -eq 0 ]
[ "$output" = "date: invalid date '01-01-1000'	foo	@1649663333
Mon Apr 11 09:49:24 CEST 2022	now	\"\"
date: invalid date 'not a date'	new year	neither this
Fri Apr  1 00:00:00 CEST 2022	joke	@1649666666" ]
}

@test "invalid date in first field with --date-error message does not print date error messages" {
    LC_ALL=C runStderr fieldNormalizeDate -F $'\t' --date-error message 1 -- "${BATS_TEST_DIRNAME}/bad.txt"
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "replacing invalid date with --date-error message also applies to following field" {
    LC_ALL=C runStdout fieldNormalizeDate -F $'\t' --date-error message 1 -1 -- "${BATS_TEST_DIRNAME}/bad.txt"
    [ $status -eq 0 ]
[ "$output" = "date: invalid date '01-01-1000'	foo	Mon Apr 11 09:48:53 CEST 2022
Mon Apr 11 09:49:24 CEST 2022	now	date: invalid date '\"\"'
date: invalid date 'not a date'	new year	date: invalid date 'neither this'
Fri Apr  1 00:00:00 CEST 2022	joke	Mon Apr 11 10:44:26 CEST 2022" ]
}

@test "replacing invalid date with --date-error message can be reverted to abort for following field" {
    LC_ALL=C runStdout fieldNormalizeDate -F $'\t' --date-error message 1 --date-error abort -1 -- "${BATS_TEST_DIRNAME}/bad.txt"
    [ $status -eq 1 ]
[ "$output" = "date: invalid date '01-01-1000'	foo	Mon Apr 11 09:48:53 CEST 2022" ]
}

@test "replacing invalid date with --date-error message can be changed to ignore for following field" {
    LC_ALL=C runStdout fieldNormalizeDate -F $'\t' --date-error message 1 --date-error ignore -1 -- "${BATS_TEST_DIRNAME}/bad.txt"
    [ $status -eq 0 ]
[ "$output" = "date: invalid date '01-01-1000'	foo	Mon Apr 11 09:48:53 CEST 2022
Mon Apr 11 09:49:24 CEST 2022	now	\"\"
date: invalid date 'not a date'	new year	neither this
Fri Apr  1 00:00:00 CEST 2022	joke	Mon Apr 11 10:44:26 CEST 2022" ]
}
