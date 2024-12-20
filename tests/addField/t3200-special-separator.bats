#!/usr/bin/env bats

@test "adding fox after second and number of fields after last field with dash separators" {
    run addField -F - 2 '"fox"' 4 'NF' <<'EOF'
the-fox-jumps-over-the-lazy-dog
my--is-over-the--sea
our-hound-can-jump-the-many-hoops
EOF

    [ $status -eq 0 ]
    [ "$output" = "the-fox-fox-jumps-over-7-the-lazy-dog
my--fox-is-over-7-the--sea
our-hound-fox-can-jump-7-the-many-hoops" ]
}

@test "adding fox after second and number of fields after last field with double space separators" {
    run addField -F '  ' 2 '"fox"' 4 'NF' <<'EOF'
the fox  jumps over  the lazy dog
  is over  
our hound  can jump  the many hoops
EOF

    [ $status -eq 0 ]
    [ "$output" = "the fox  jumps over  fox  the lazy dog    3
  is over  fox      3
our hound  can jump  fox  the many hoops    3" ]
}
