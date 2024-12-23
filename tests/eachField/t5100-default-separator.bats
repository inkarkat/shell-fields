#!/usr/bin/env bats

load fixture

@test "parenthesizing takes runs of spaces and tabs and outputs with a single space" {
    run -0 eachField --exec sed -e 's/.*/(&)/' \; <<'EOF'
the fox	jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF

    assert_output - <<'EOF'
(the) (fox) (jumps) (over) (the) (lazy) (dog)
(my) () () () () () ()
(our) (hound) (can) (jump) (the) (many) (hoops)
EOF
}

@test "parenthesizing takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run -0 eachField --exec sed -e 's/.*/(&)/' \; <<'EOF'
the	fox jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF

    assert_output - <<'EOF'
(the)	(fox)	(jumps)	(over)	(the)	(lazy)	(dog)
(my)	()	()	()	()	()	()
(our)	(hound)	(can)	(jump)	(the)	(many)	(hoops)
EOF
}
