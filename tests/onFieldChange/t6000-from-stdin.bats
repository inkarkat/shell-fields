#!/usr/bin/env bats

stdinOnFieldChange()
{
    cat -- "${BATS_TEST_DIRNAME}/pasta.txt" | onFieldChange "$@"
}

@test "input from stdin" {
    run stdinOnFieldChange -F $'\t' --exec echo 'Change in {}' \; 1 "${BATS_TEST_DIRNAME}/pasta.txt"
    [ $status -eq 0 ]
    [ "$output" = "ramen	3
ramen	5
ramen	3
Change in 4
penne	3
Change in 5
ravioli	3
ravioli	2" ]
}
