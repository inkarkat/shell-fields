#!/usr/bin/env bats

stdinEachField()
{
    cat -- "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt" | eachField "$@"
}

@test "apply mixed file marker command and commandlines" {
    run stdinEachField \
	--command 'sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ {}' \
	--exec sed -e 's/.*/[&]/' - {} \; \
	--command "sed -e 's/\$/!/'" \
	1
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
