#!/usr/bin/env bats

@test "parenthesizing takes runs of spaces and tabs and outputs with a single space" {
    run eachField --exec sed -e 's/.*/(&)/' \; <<'EOF'
the fox	jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF

    [ $status -eq 0 ]
    [ "$output" = "(the) (fox) (jumps) (over) (the) (lazy) (dog)
(my) () () () () () ()
(our) (hound) (can) (jump) (the) (many) (hoops)" ]
}

@test "parenthesizing takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run eachField --exec sed -e 's/.*/(&)/' \; <<'EOF'
the	fox jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF

    [ $status -eq 0 ]
    [ "$output" = "(the)	(fox)	(jumps)	(over)	(the)	(lazy)	(dog)
(my)	()	()	()	()	()	()
(our)	(hound)	(can)	(jump)	(the)	(many)	(hoops)" ]
}
