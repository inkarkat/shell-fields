#!/usr/bin/env bats

load fixture

@test "grep the second and second-to-last fields with dash separators" {
    run -0 fieldGrep -F - --regexp n 2 -2 <<'EOF'
the-fox-jumps-over-the-lazy-dog
my-bonnie-is-over-the-endless-sea
our-hound-can-jump-the-many-hoops
EOF

    assert_output - <<'EOF'
my-bonnie-is-over-the-endless-sea
our-hound-can-jump-the-many-hoops
EOF
}

@test "grep the first and last fields with double space separators" {
    run -0 fieldGrep -F '  ' --regexp n 1 -1 <<'EOF'
the fox  jumps over  the lazy dog
my bonnie  is over  the endless sea
our hound  can jump  the many hoops
EOF

    assert_output - <<'EOF'
my bonnie  is over  the endless sea
our hound  can jump  the many hoops
EOF
}
