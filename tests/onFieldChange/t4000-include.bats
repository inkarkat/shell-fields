#!/usr/bin/env bats

load markers

@test "include first value" {
    run onFieldChange -F $'\t' --include-first --exec echo 'Change from {--} to {+}' \; 1 "${BATS_TEST_DIRNAME}/pasta.txt"
    [ $status -eq 0 ]
    [ "$output" = "Change from  to ramen
ramen	3
ramen	5
ramen	3
Change from ramen 3 to penne
penne	3
Change from penne 3 to ravioli
ravioli	3
ravioli	2" ]
}

@test "include last value" {
    run onFieldChange -F $'\t' --include-last --exec echo 'Change from {-} to {++}' \; 1 "${BATS_TEST_DIRNAME}/pasta.txt"
    [ $status -eq 0 ]
    [ "$output" = "ramen	3
ramen	5
ramen	3
Change from ramen to penne 3
penne	3
Change from penne to ravioli 3
ravioli	3
ravioli	2
Change from ravioli to " ]
}
