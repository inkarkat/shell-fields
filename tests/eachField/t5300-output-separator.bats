#!/usr/bin/env bats

load fixture

@test "parenthesizing to dash separator" {
    run -0 eachField --output-separator - --exec sed -e 's/.*/(&)/' \; "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output - <<'EOF'
(foo)-(one)-(haha)
(bar)-(two)-(hehe)
(baz)-(three)-(hihi)
(end)-(four)-(hoho)
EOF
}

@test "parenthesizing to space-dash-space separator" {
    run -0 eachField --output-separator ' - ' --exec sed -e 's/.*/(&)/' \; "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output - <<'EOF'
(foo) - (one) - (haha)
(bar) - (two) - (hehe)
(baz) - (three) - (hihi)
(end) - (four) - (hoho)
EOF
}

@test "parenthesizing to newline separator" {
    run -0 eachField --output-separator $'\n' --exec sed -e 's/.*/(&)/' \; "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output - <<'EOF'
(foo)
(one)
(haha)
(bar)
(two)
(hehe)
(baz)
(three)
(hihi)
(end)
(four)
(hoho)
EOF
}
