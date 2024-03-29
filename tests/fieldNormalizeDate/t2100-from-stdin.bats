#!/usr/bin/env bats

stdinNormalizeDate()
{
    cat -- "${BATS_TEST_DIRNAME}/tabbed.txt" | fieldNormalizeDate "$@"
}

@test "normalizing first field from stdin to epoch" {
    LC_ALL=C run stdinNormalizeDate -F $'\t' 1 %s
    [ $status -eq 0 ]
    [ "$output" = "1650405600	foo	@1649663333
1649663364	now	@1111111111
1640991600	new year	@1111111111
1648764000	joke	@1649666666" ]
}
