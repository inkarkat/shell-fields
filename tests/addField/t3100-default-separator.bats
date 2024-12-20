#!/usr/bin/env bats

load fixture

@test "adding fox after second and number of fields after last field takes runs of spaces and tabs and outputs with a single space" {
    run -0 addField 2 '"fox"' 4 'NF' <<'EOF'
the fox	jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF
    assert_output - <<'EOF'
the fox fox jumps over 7 the lazy dog
my  fox   1
our hound fox can jump 7 the many hoops
EOF
}

@test "adding fox after second and number of fields after last field takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run -0 addField 2 '"fox"' 4 'NF' <<'EOF'
the	fox jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF
    assert_output - <<'EOF'
the	fox	fox	jumps	over	7	the	lazy	dog
my		fox			1
our	hound	fox	can	jump	7	the	many	hoops
EOF
}
