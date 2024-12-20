#!/usr/bin/env bats

@test "concatenating fox to second and number of fields to last field takes runs of spaces and tabs and outputs with a single space" {
    run fieldMap 2 '$fieldNr "fox"' 4 '$fieldNr NF' <<'EOF'
the fox	jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF

    [ $status -eq 0 ]
    [ "$output" = "the foxfox jumps over7 the lazy dog
my fox  2
our houndfox can jump7 the many hoops" ]
}

@test "concatenating fox to second and number of fields to last field takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run fieldMap 2 '$fieldNr "fox"' 4 '$fieldNr NF' <<'EOF'
the	fox jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF

    [ $status -eq 0 ]
    [ "$output" = "the	foxfox	jumps	over7	the	lazy	dog
my	fox		2
our	houndfox	can	jump7	the	many	hoops" ]
}
