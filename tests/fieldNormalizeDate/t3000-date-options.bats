#!/usr/bin/env bats

@test "--utc applies to following FORMAT" {
    LC_ALL=C TZ='Europe/Berlin' run fieldNormalizeDate -F $'\t' 1 --utc -1 -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "Wed Apr 20 00:00:00 CEST 2022	foo	Mon Apr 11 07:48:53 UTC 2022
Mon Apr 11 09:49:24 CEST 2022	now	Fri Mar 18 01:58:31 UTC 2005
Sat Jan  1 00:00:00 CET 2022	new year	Fri Mar 18 01:58:31 UTC 2005
Fri Apr  1 00:00:00 CEST 2022	joke	Mon Apr 11 08:44:26 UTC 2022" ]
}
