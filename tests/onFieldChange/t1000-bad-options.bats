#!/usr/bin/env bats

load fixture

@test "unknown option prints an error message" {
    run -2 onFieldChange --does-not-exist
    assert_line -n 0 'ERROR: Unknown option "--does-not-exist"!'
    assert_line -n 2 -e '^Usage:'
}

@test "regular expression field separator prints a note" {
    run -0 --separate-stderr onFieldChange --field-separator ' +' --unbuffered --command 'echo vvv' 4 <<<'foo bar   baz'
    output="$stderr" assert_output 'Note: Using space as default output field separator; change via -s|--output-separator OS or pass a non-regular expression -F|--field-separator FS.'
}
