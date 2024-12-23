#!/usr/bin/env bats

load fixture

@test "grep the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a single space" {
    run -0 fieldGrep --regexp n 2 -2 <<'EOF'
the fox	jumps over			the lazy dog
my bonnie    is over    the endless    sea
our	hound	can	jump	the	many	hoops
EOF

    assert_output - <<'EOF'
my bonnie is over the endless sea
our hound can jump the many hoops
EOF
}

@test "grep the second and second-to-last fields with default whitespace separators takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run -0 fieldGrep --regexp n 2 -2 <<'EOF'
the	fox jumps over			the lazy dog
my bonnie    is over    the endless    sea
our	hound	can	jump	the	many	hoops
EOF

    assert_output - <<'EOF'
my	bonnie	is	over	the	endless	sea
our	hound	can	jump	the	many	hoops
EOF
}
