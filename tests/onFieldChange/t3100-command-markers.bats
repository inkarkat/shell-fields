#!/usr/bin/env bats

load fixture

@test "command references line number" {
    run -0 onFieldChange -F $'\t' --exec echo 'Change in {}' \; 1 "${BATS_TEST_DIRNAME}/pasta.txt"
    assert_output - <<'EOF'
ramen	3
ramen	5
ramen	3
Change in 4
penne	3
Change in 5
ravioli	3
ravioli	2
EOF
}

@test "command references previous value" {
    run -0 onFieldChange -F $'\t' --exec echo 'Change from {-}' \; 1 "${BATS_TEST_DIRNAME}/pasta.txt"
    assert_output - <<'EOF'
ramen	3
ramen	5
ramen	3
Change from ramen
penne	3
Change from penne
ravioli	3
ravioli	2
EOF
}

@test "command references new value" {
    run -0 onFieldChange -F $'\t' --exec echo 'Change to {+}' \; 1 "${BATS_TEST_DIRNAME}/pasta.txt"
    assert_output - <<'EOF'
ramen	3
ramen	5
ramen	3
Change to penne
penne	3
Change to ravioli
ravioli	3
ravioli	2
EOF
}

@test "command references previous line" {
    run -0 onFieldChange -F $'\t' --exec echo 'Change from {--}' \; 1 "${BATS_TEST_DIRNAME}/pasta.txt"
    assert_output - <<'EOF'
ramen	3
ramen	5
ramen	3
Change from ramen 3
penne	3
Change from penne 3
ravioli	3
ravioli	2
EOF
}

@test "command references new line" {
    run -0 onFieldChange -F $'\t' --exec echo 'Change to {++}' \; 1 "${BATS_TEST_DIRNAME}/pasta.txt"
    assert_output - <<'EOF'
ramen	3
ramen	5
ramen	3
Change to penne 3
penne	3
Change to ravioli 3
ravioli	3
ravioli	2
EOF
}

@test "command references multiple" {
    run -0 onFieldChange -F $'\t' --exec echo 'Change in {} from {-} to {+} yields {++}' \; 1 "${BATS_TEST_DIRNAME}/pasta.txt"
    assert_output - <<'EOF'
ramen	3
ramen	5
ramen	3
Change in 4 from ramen to penne yields penne 3
penne	3
Change in 5 from penne to ravioli yields ravioli 3
ravioli	3
ravioli	2
EOF
}
