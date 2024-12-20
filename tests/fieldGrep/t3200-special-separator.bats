#!/usr/bin/env bats

@test "grep the second and second-to-last fields with dash separators" {
    run fieldGrep -F - --regexp n 2 -2 <<'EOF'
the-fox-jumps-over-the-lazy-dog
my-bonnie-is-over-the-endless-sea
our-hound-can-jump-the-many-hoops
EOF
    [ $status -eq 0 ]
    [ "$output" = "my-bonnie-is-over-the-endless-sea
our-hound-can-jump-the-many-hoops" ]
}

@test "grep the first and last fields with double space separators" {
    run fieldGrep -F '  ' --regexp n 1 -1 <<'EOF'
the fox  jumps over  the lazy dog
my bonnie  is over  the endless sea
our hound  can jump  the many hoops
EOF
    [ $status -eq 0 ]
    [ "$output" = "my bonnie  is over  the endless sea
our hound  can jump  the many hoops" ]
}
