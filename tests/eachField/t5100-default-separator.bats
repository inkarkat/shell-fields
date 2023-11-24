#!/usr/bin/env bats

@test "parenthesizing takes runs of spaces and tabs and outputs with a single space" {
    run defaultEachField --exec sed -e 's/.*/(&)/' \;

    [ $status -eq 0 ]
    [ "$output" = "(the) (fox) (jumps) (over) (the) (lazy) (dog)
(my) () () () () () ()
(our) (hound) (can) (jump) (the) (many) (hoops)" ]
}
defaultEachField()
{
    (cat <<'EOF'
the fox	jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF
    ) | eachField "$@"
}

@test "parenthesizing takes runs of spaces and tabs and outputs with a tab if that is the very first separator" {
    run firstTabEachField --exec sed -e 's/.*/(&)/' \;

    [ $status -eq 0 ]
    [ "$output" = "(the)	(fox)	(jumps)	(over)	(the)	(lazy)	(dog)
(my)	()	()	()	()	()	()
(our)	(hound)	(can)	(jump)	(the)	(many)	(hoops)" ]
}
firstTabEachField()
{
    (cat <<'EOF'
the	fox jumps over			the lazy dog
my
our	hound	can	jump	the	many	hoops
EOF
    ) | eachField "$@"
}
