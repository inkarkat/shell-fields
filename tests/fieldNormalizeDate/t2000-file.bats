#!/usr/bin/env bats

@test "normalizing first field to default date format" {
    LC_ALL=C run fieldNormalizeDate -F $'\t' 1 -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "Wed Apr 20 00:00:00 CEST 2022	foo	@1649663333
Mon Apr 11 09:49:24 CEST 2022	now	@1111111111
Sat Jan  1 00:00:00 CET 2022	new year	@1111111111
Fri Apr  1 00:00:00 CEST 2022	joke	@1649666666" ]
}

@test "normalizing first field to epoch" {
    LC_ALL=C run fieldNormalizeDate -F $'\t' 1 %s -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "1650405600	foo	@1649663333
1649663364	now	@1111111111
1640991600	new year	@1111111111
1648764000	joke	@1649666666" ]
}

@test "normalizing first field to epoch with --format" {
    LC_ALL=C run fieldNormalizeDate -F $'\t' 1 --format -%s- -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "-1650405600-	foo	@1649663333
-1649663364-	now	@1111111111
-1640991600-	new year	@1111111111
-1648764000-	joke	@1649666666" ]
}

@test "normalizing first field and last field to default date format" {
    LC_ALL=C run fieldNormalizeDate -F $'\t' 1 -1 -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "Wed Apr 20 00:00:00 CEST 2022	foo	Mon Apr 11 09:48:53 CEST 2022
Mon Apr 11 09:49:24 CEST 2022	now	Fri Mar 18 02:58:31 CET 2005
Sat Jan  1 00:00:00 CET 2022	new year	Fri Mar 18 02:58:31 CET 2005
Fri Apr  1 00:00:00 CEST 2022	joke	Mon Apr 11 10:44:26 CEST 2022" ]
}

@test "normalizing first field and last field to custom date formats that create an additional field" {
    LC_ALL=C run fieldNormalizeDate -F $'\t' 1 '[%U/%Y]' -1 $'on %F\t%R' -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "[16/2022]	foo	on 2022-04-11	09:48
[15/2022]	now	on 2005-03-18	02:58
[00/2022]	new year	on 2005-03-18	02:58
[13/2022]	joke	on 2022-04-11	10:44" ]
}
