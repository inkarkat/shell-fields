#!/usr/bin/env bats

load fixture

DASHED_INPUT="$(cat <<'EOF'
the-fox-jumps-over-the-lazy-dog
my-bonnie-is-over-the-endless-sea
our-hound-can-jump-the-many-hoops
EOF
)"

@test "print the second and second-to-last fields with dash separators" {
    run -0 field -F - 2 -2 <<<"$DASHED_INPUT"
    assert_output - <<'EOF'
fox-lazy
bonnie-endless
hound-many
EOF
}
@test "print everything but the second and second-to-last fields with dash separators" {
    run -0 field -F - --remove 2 -2 <<<"$DASHED_INPUT"
    assert_output - <<'EOF'
the-jumps-over-the-dog
my-is-over-the-sea
our-can-jump-the-hoops
EOF
}

DOUBLE_SPACED_INPUT="$(cat <<'EOF'
the fox  jumps over  the lazy dog
my bonnie  is over  the endless sea
our hound  can jump  the many hoops
EOF
)"

@test "print the first and last fields with double space separators" {
    run -0 field -F '  ' 1 -1 <<<"$DOUBLE_SPACED_INPUT"
    assert_output - <<'EOF'
the fox  the lazy dog
my bonnie  the endless sea
our hound  the many hoops
EOF
}
@test "print everything but the first and last fields with double space separators" {
    run -0 field -F '  ' --remove 1 -1 <<<"$DOUBLE_SPACED_INPUT"
    assert_output - <<'EOF'
jumps over
is over
can jump
EOF
}
