#!/usr/bin/env bats

@test "apply multiple commands to fields" {
    run eachField \
	--exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ \; 1 \
	--exec sed -e 's/.*/[&]/' \; \
	--exec sed -e 's/$/!/' \; 3 \
	"${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "FOO	[haha]!
BAR	[hehe]!
BAZ	[hihi]!
END	[hoho]!" ]
}
