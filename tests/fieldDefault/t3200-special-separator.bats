#!/usr/bin/env bats

load fixture

@test "default the second and second-to-last fields with dash separators" {
    run -0 fieldDefault -F - --value X 2 -2 <<'EOF'
the-fox-jumps-over-the-lazy-dog
my--is-over-the--sea
our-hound-can-jump-the-many-hoops
EOF

    assert_output - <<'EOF'
the-fox-jumps-over-the-lazy-dog
my-X-is-over-the-X-sea
our-hound-can-jump-the-many-hoops
EOF
}

@test "default the first and last fields with double space separators" {
    run -0 fieldDefault -F '  ' --value X 1 -1 <<'EOF'
the fox  jumps over  the lazy dog
  is over  
our hound  can jump  the many hoops
EOF

    assert_output - <<'EOF'
the fox  jumps over  the lazy dog
X  is over  X
our hound  can jump  the many hoops
EOF
}
