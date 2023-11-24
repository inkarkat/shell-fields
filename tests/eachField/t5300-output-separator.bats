#!/usr/bin/env bats

@test "parenthesizing to dash separator" {
    run eachField --separator - --exec sed -e 's/.*/(&)/' \; "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "(foo)-(one)-(haha)
(bar)-(two)-(hehe)
(baz)-(three)-(hihi)
(end)-(four)-(hoho)" ]
}

@test "parenthesizing to space-dash-space separator" {
    run eachField --separator ' - ' --exec sed -e 's/.*/(&)/' \; "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "(foo) - (one) - (haha)
(bar) - (two) - (hehe)
(baz) - (three) - (hihi)
(end) - (four) - (hoho)" ]
}

@test "parenthesizing to newline separator" {
    run eachField --separator $'\n' --exec sed -e 's/.*/(&)/' \; "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"

    [ $status -eq 0 ]
    [ "$output" = "(foo)
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
(hoho)" ]
}
