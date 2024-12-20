#!/usr/bin/env bats

SPACE_FIRST_INPUT="$(cat <<'EOF'
the fox	jumps over			the lazy dog
my bonnie    is over    the endless    sea
our	hound	can	jump	the	many	hoops
EOF
)"

@test "print the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a single space" {
    run field 2 -2 <<<"$SPACE_FIRST_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "fox lazy
bonnie endless
hound many" ]
}
@test "print everything but the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a single space" {
    run field --remove 2 -2 <<<"$SPACE_FIRST_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "the jumps over the dog
my is over the sea
our can jump the hoops" ]
}

TAB_FIRST_INPUT="$(cat <<'EOF'
the	fox jumps over			the lazy dog
my bonnie    is over    the endless    sea
our	hound	can	jump	the	many	hoops
EOF
)"

@test "print the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run field 2 -2 <<<"$TAB_FIRST_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "fox	lazy
bonnie	endless
hound	many" ]
}
@test "print everything but the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run field --remove 2 -2 <<<"$TAB_FIRST_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "the	jumps	over	the	dog
my	is	over	the	sea
our	can	jump	the	hoops" ]
}
