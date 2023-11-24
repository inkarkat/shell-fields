#!/usr/bin/env bats

@test "parenthesizing with dash separators" {
    run dashEachField --exec sed -e 's/.*/(&)/' \;

    [ $status -eq 0 ]
    [ "$output" = "(the)-(fox)-(jumps)-(over)-(the)-(lazy)-(dog)
(my)-()-(is)-(over)-(the)-()-(sea)
(our)-(hound)-(can)-(jump)-(the)-(many)-(hoops)" ]
}
dashEachField()
{
    (cat <<'EOF'
the-fox-jumps-over-the-lazy-dog
my--is-over-the--sea
our-hound-can-jump-the-many-hoops
EOF
    ) | eachField --field-separator - "$@"
}

@test "parenthesizing with double space separators" {
    run doubleSpaceEachField --exec sed -e 's/.*/(&)/' \;

    [ $status -eq 0 ]
    [ "$output" = "(the fox)  (jumps over)  (the lazy dog)
()  (is over)  ()
(our hound)  (can jump)  (the many hoops)" ]
}
doubleSpaceEachField()
{
    (cat <<'EOF'
the fox  jumps over  the lazy dog
  is over  
our hound  can jump  the many hoops
EOF
    ) | eachField --field-separator '  ' "$@"
}
