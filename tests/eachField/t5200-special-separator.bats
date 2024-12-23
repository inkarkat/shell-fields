#!/usr/bin/env bats

load fixture

@test "parenthesizing with dash separators" {
    run -0 eachField --field-separator - --exec sed -e 's/.*/(&)/' \; <<'EOF'
the-fox-jumps-over-the-lazy-dog
my--is-over-the--sea
our-hound-can-jump-the-many-hoops
EOF

    assert_output - <<'EOF'
(the)-(fox)-(jumps)-(over)-(the)-(lazy)-(dog)
(my)-()-(is)-(over)-(the)-()-(sea)
(our)-(hound)-(can)-(jump)-(the)-(many)-(hoops)
EOF
}

@test "parenthesizing with double space separators" {
    run -0 eachField --field-separator '  ' --exec sed -e 's/.*/(&)/' \; <<'EOF'
the fox  jumps over  the lazy dog
  is over  
our hound  can jump  the many hoops
EOF

    assert_output - <<'EOF'
(the fox)  (jumps over)  (the lazy dog)
()  (is over)  ()
(our hound)  (can jump)  (the many hoops)
EOF
}
