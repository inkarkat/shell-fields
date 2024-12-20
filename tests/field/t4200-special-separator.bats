#!/usr/bin/env bats

DASHED_INPUT="$(cat <<'EOF'
the-fox-jumps-over-the-lazy-dog
my-bonnie-is-over-the-endless-sea
our-hound-can-jump-the-many-hoops
EOF
)"

@test "print the second and second-to-last fields with dash separators" {
    run field -F - 2 -2 <<<"$DASHED_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "fox-lazy
bonnie-endless
hound-many" ]
}
@test "print everything but the second and second-to-last fields with dash separators" {
    run field -F - --remove 2 -2 <<<"$DASHED_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "the-jumps-over-the-dog
my-is-over-the-sea
our-can-jump-the-hoops" ]
}

DOUBLE_SPACED_INPUT="$(cat <<'EOF'
the fox  jumps over  the lazy dog
my bonnie  is over  the endless sea
our hound  can jump  the many hoops
EOF
)"

@test "print the first and last fields with double space separators" {
    run field -F '  ' 1 -1 <<<"$DOUBLE_SPACED_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "the fox  the lazy dog
my bonnie  the endless sea
our hound  the many hoops" ]
}
@test "print everything but the first and last fields with double space separators" {
    run field -F '  ' --remove 1 -1 <<<"$DOUBLE_SPACED_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "jumps over
is over
can jump" ]
}
