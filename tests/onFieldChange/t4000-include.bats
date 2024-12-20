#!/usr/bin/env bats

load markers

@test "include first value" {
    run -0 onFieldChange -F $'\t' --include-first --exec echo 'Change from {--} to {+}' \; 1 "${BATS_TEST_DIRNAME}/pasta.txt"
    assert_output - <<'EOF'
Change from  to ramen
ramen	3
ramen	5
ramen	3
Change from ramen 3 to penne
penne	3
Change from penne 3 to ravioli
ravioli	3
ravioli	2
EOF
}

@test "include last value" {
    run -0 onFieldChange -F $'\t' --include-last --exec echo 'Change from {-} to {++}' \; 1 "${BATS_TEST_DIRNAME}/pasta.txt"
    assert_output - <<'EOF'
ramen	3
ramen	5
ramen	3
Change from ramen to penne 3
penne	3
Change from penne to ravioli 3
ravioli	3
ravioli	2
Change from ravioli to 
EOF
}

@test "include with default value equal to first does not trigger on first" {
    run -0 onFieldChange -F $'\t' --default-value 3 --include-first --include-last --exec echo 'Change from {-} to {+}' \; 2 "${BATS_TEST_DIRNAME}/pasta.txt"
    assert_output - <<'EOF'
ramen	3
Change from 3 to 5
ramen	5
Change from 5 to 3
ramen	3
penne	3
ravioli	3
Change from 3 to 2
ravioli	2
Change from 2 to 3
EOF
}

@test "include with default value equal to last does not trigger on last" {
    run -0 onFieldChange -F $'\t' --default-value 2 --include-first --include-last --exec echo 'Change from {-} to {+}' \; 2 "${BATS_TEST_DIRNAME}/pasta.txt"
    assert_output - <<'EOF'
Change from 2 to 3
ramen	3
Change from 3 to 5
ramen	5
Change from 5 to 3
ramen	3
penne	3
ravioli	3
Change from 3 to 2
ravioli	2
EOF
}
