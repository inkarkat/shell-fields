#!/usr/bin/env bats

@test "input from stdin" {
    run onFieldChange -F $'\t' --exec echo 'Change in {}' \; 1 "${BATS_TEST_DIRNAME}/pasta.txt" < "${BATS_TEST_DIRNAME}/pasta.txt" 
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
