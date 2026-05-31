#!/usr/bin/env bats

load fixture

@test "unknown option prints an error message" {
    run -2 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" --does-not-exist 2
    assert_line -n 0 'ERROR: Unknown option "--does-not-exist"!'
    assert_line -n 4 -e '^Usage:'
}

@test "a non-number argument at the end when removing prints an error message" {
    run -2 field --file "${BATS_TEST_DIRNAME}/tabbed.txt" --remove 2 x 3 y
    assert_output 'ERROR: Not a number: x'
}

@test "regular expression field separator prints a note" {
    run -0 --separate-stderr field --field-separator ' +' 1 <<<'foo bar   baz'
    output="$stderr" assert_output 'Note: Using space as default output field separator; change via -s|--output-separator OS or pass a non-regular expression -F|--field-separator FS.'
}
