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
