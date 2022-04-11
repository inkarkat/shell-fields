#!/usr/bin/env bats

load fixture

stdinNormalizeDate()
{
    cat -- "${BATS_TEST_DIRNAME}/tabbed.txt" | fieldNormalizeDate "$@"
}

@test "normalizing first field from stdin to epoch" {
    runStdout stdinNormalizeDate -F $'\t' 1 %s
    [ $status -eq 0 ]
    [ "$output" = "1650405600	foo	@1649663333
1649663364	now	@1111111111
not a date	invalid	@1111111111
1648764000	joke	@1649666666" ]
}
