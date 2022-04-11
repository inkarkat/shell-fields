#!/usr/bin/env bats

load fixture

@test "normalizing first field to default date format" {
    runStdout fieldNormalizeDate -F $'\t' 1 -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "Wed 20. Apr 2022 00:00:00 CEST	foo	@1649663333
Mon 11. Apr 2022 09:49:24 CEST	now	@1111111111
not a date	invalid	@1111111111
Fri 1. Apr 2022 00:00:00 CEST	joke	@1649666666" ]
}

@test "normalizing first field to epoch" {
    runStdout fieldNormalizeDate -F $'\t' 1 %s -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "1650405600	foo	@1649663333
1649663364	now	@1111111111
not a date	invalid	@1111111111
1648764000	joke	@1649666666" ]
}

@test "normalizing first field and last field to default date format" {
    runStdout fieldNormalizeDate -F $'\t' 1 -1 -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "Wed 20. Apr 2022 00:00:00 CEST	foo	Mon 11. Apr 2022 09:48:53 CEST
Mon 11. Apr 2022 09:49:24 CEST	now	Fri 18. Mar 2005 02:58:31 CET
not a date	invalid	Fri 18. Mar 2005 02:58:31 CET
Fri 1. Apr 2022 00:00:00 CEST	joke	Mon 11. Apr 2022 10:44:26 CEST" ]
}

@test "normalizing first field and last field to custom date formats that create an additional field" {
    skip
    runStdout fieldNormalizeDate -F $'\t' 1 '[%U/%Y]' -1 $'on %F\t%R' -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "[16/2022]	foo	on 2022-04-11	09:48
[15/2022]	now	on 2005-03-18	02:58
not a date	invalid	on 2005-03-18	02:58
[13/2022]	joke	on 2022-04-11	10:44" ]
}
