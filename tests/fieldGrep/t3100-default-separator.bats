#!/usr/bin/env bats

@test "grep the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a single space" {
    run fieldGrep --regexp n 2 -2 <<'EOF'
the fox	jumps over			the lazy dog
my bonnie    is over    the endless    sea
our	hound	can	jump	the	many	hoops
EOF
    [ $status -eq 0 ]
    [ "$output" = "my bonnie is over the endless sea
our hound can jump the many hoops" ]
}

@test "grep the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run fieldGrep --regexp n 2 -2 <<'EOF'
the	fox jumps over			the lazy dog
my bonnie    is over    the endless    sea
our	hound	can	jump	the	many	hoops
EOF
    [ $status -eq 0 ]
    [ "$output" = "my	bonnie	is	over	the	endless	sea
our	hound	can	jump	the	many	hoops" ]
}
