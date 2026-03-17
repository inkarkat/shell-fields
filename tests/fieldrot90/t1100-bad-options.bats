#!/usr/bin/env bats

load fixture

@test "regular expression field separator prints a note" {
    run -0 --separate-stderr fieldrot90 --field-separator ' +' <<<'foo bar   baz'
    output="$stderr" assert_output 'Note: Using space as default output field separator; change via -s|--output-separator OS or pass a non-regular expression -F|--field-separator FS.'
}
