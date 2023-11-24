#!/usr/bin/env bats

@test "file marker command is applied to all fields to uppercase all fields" {
    run eachField --exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ {} {} \; "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "FOO	ONE	HAHA
BAR	TWO	HEHE
BAZ	THREE	HIHI
END	FOUR	HOHO
FOO	ONE	HAHA
BAR	TWO	HEHE
BAZ	THREE	HIHI
END	FOUR	HOHO" ]
}

@test "file marker commandline is applied to all fields to uppercase all fields" {
    run eachField --command 'cat {} {} | sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "FOO	ONE	HAHA
BAR	TWO	HEHE
BAZ	THREE	HIHI
END	FOUR	HOHO
FOO	ONE	HAHA
BAR	TWO	HEHE
BAZ	THREE	HIHI
END	FOUR	HOHO" ]
}

@test "apply mixed file marker command and commandlines" {
    run eachField \
	--command 'sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ {}' \
	--exec sed -e 's/.*/[&]/' - {} \; \
	--command "sed -e 's/\$/!/'" \
	1 \
	"${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "[FOO]!
[BAR]!
[BAZ]!
[END]!
[foo]!
[bar]!
[baz]!
[end]!" ]
}
