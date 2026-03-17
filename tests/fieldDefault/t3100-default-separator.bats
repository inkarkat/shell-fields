#!/usr/bin/env bats

load fixture

@test "default the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a single space" {
    run -0 fieldDefault --value X 2 -2 <<'EOF'
the fox	jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF

    assert_output - <<'EOF'
the fox jumps over the lazy dog
my X    X
our hound can jump the many hoops
EOF
}

@test "default the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run -0 fieldDefault --value X 2 -2 <<'EOF'
the	fox jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF

    assert_output - <<'EOF'
the	fox	jumps	over	the	lazy	dog
my	X				X
our	hound	can	jump	the	many	hoops
EOF
}

@test "regular expression field separator prints a note" {
    run -0 --separate-stderr fieldDefault --field-separator ' +' --value DEFAULT 1 <<<'foo bar   baz'
    output="$stderr" assert_output 'Note: Using space as default output field separator; change via -s|--output-separator OS or pass a non-regular expression -F|--field-separator FS.'
}
