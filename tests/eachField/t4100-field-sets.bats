#!/usr/bin/env bats

@test "apply different commands to individual fields" {
    run eachField \
	--exec sed -e 's/.*/[&]/' \; 1 3 \
	--exec sed -e 's/.*/<&>/' \; 3 2 \
	"${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "[foo]	[haha]	<haha>	<one>
[bar]	[hehe]	<hehe>	<two>
[baz]	[hihi]	<hihi>	<three>
[end]	[hoho]	<hoho>	<four>" ]
}

@test "apply different commands to sets of fields" {
    run eachField \
	--exec sed -e 's/.*/[&]/' \; 1,3 \
	--exec sed -e 's/.*/<&>/' \; 3,2 \
	"${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "[foo	haha]	<haha	one>
[bar	hehe]	<hehe	two>
[baz	hihi]	<hihi	three>
[end	hoho]	<hoho	four>" ]
}

@test "sets of fields from behind " {
    run eachField \
	--exec sed -e 's/.*/[&]/' \; 1,-1 \
	--exec sed -e 's/.*/<&>/' \; -1,2 \
	"${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "[foo	haha]	<haha	one>
[bar	hehe]	<hehe	two>
[baz	hihi]	<hihi	three>
[end	hoho]	<hoho	four>" ]
}

@test "set of duplicate fields" {
    run eachField \
	--exec sed -e 's/.*/[&]/' \; -1,2,3,2 \
	"${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "[haha	one	haha	one]
[hehe	two	hehe	two]
[hihi	three	hihi	three]
[hoho	four	hoho	four]" ]
}
