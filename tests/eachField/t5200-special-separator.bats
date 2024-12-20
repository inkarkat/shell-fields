#!/usr/bin/env bats

@test "parenthesizing with dash separators" {
    run eachField --field-separator - --exec sed -e 's/.*/(&)/' \; <<'EOF'
the-fox-jumps-over-the-lazy-dog
my--is-over-the--sea
our-hound-can-jump-the-many-hoops
EOF

    [ $status -eq 0 ]
    [ "$output" = "(the)-(fox)-(jumps)-(over)-(the)-(lazy)-(dog)
(my)-()-(is)-(over)-(the)-()-(sea)
(our)-(hound)-(can)-(jump)-(the)-(many)-(hoops)" ]
}

@test "parenthesizing with double space separators" {
    run eachField --field-separator '  ' --exec sed -e 's/.*/(&)/' \; <<'EOF'
the fox  jumps over  the lazy dog
  is over  
our hound  can jump  the many hoops
EOF

    [ $status -eq 0 ]
    [ "$output" = "(the fox)  (jumps over)  (the lazy dog)
()  (is over)  ()
(our hound)  (can jump)  (the many hoops)" ]
}
