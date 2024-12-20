#!/usr/bin/env bats

@test "default the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a single space" {
    run fieldDefault --value X 2 -2 <<'EOF'
the fox	jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF

    [ $status -eq 0 ]
    [ "$output" = "the fox jumps over the lazy dog
my X    X
our hound can jump the many hoops" ]
}

@test "default the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run fieldDefault --value X 2 -2 <<'EOF'
the	fox jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF

    [ $status -eq 0 ]
    [ "$output" = "the	fox	jumps	over	the	lazy	dog
my	X				X
our	hound	can	jump	the	many	hoops" ]
}
