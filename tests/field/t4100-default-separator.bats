#!/usr/bin/env bats

load fixture

SPACE_FIRST_INPUT="$(cat <<'EOF'
the fox	jumps over			the lazy dog
my bonnie    is over    the endless    sea
our	hound	can	jump	the	many	hoops
EOF
)"

@test "print the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a single space" {
    run -0 field 2 -2 <<<"$SPACE_FIRST_INPUT"
    assert_output - <<'EOF'
fox lazy
bonnie endless
hound many
EOF
}
@test "print everything but the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a single space" {
    run -0 field --remove 2 -2 <<<"$SPACE_FIRST_INPUT"
    assert_output - <<'EOF'
the jumps over the dog
my is over the sea
our can jump the hoops
EOF
}

TAB_FIRST_INPUT="$(cat <<'EOF'
the	fox jumps over			the lazy dog
my bonnie    is over    the endless    sea
our	hound	can	jump	the	many	hoops
EOF
)"

@test "print the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run -0 field 2 -2 <<<"$TAB_FIRST_INPUT"
    assert_output - <<'EOF'
fox	lazy
bonnie	endless
hound	many
EOF
}
@test "print everything but the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run -0 field --remove 2 -2 <<<"$TAB_FIRST_INPUT"
    assert_output - <<'EOF'
the	jumps	over	the	dog
my	is	over	the	sea
our	can	jump	the	hoops
EOF
}
