#!/usr/bin/env bats

load fixture

@test "last field will refer to the highest field number already seen" {
    run -0 fieldDefault -F $'\t' --value DEFAULT -1 <<'EOF'
one	two
fill
one	two	three
fill
one	two	three	four	five
fill
fewer	here
fill
EOF

    assert_output - <<'EOF'
one	two
fill	DEFAULT
one	two	three
fill		DEFAULT
one	two	three	four	five
fill				DEFAULT
fewer	here			DEFAULT
fill				DEFAULT
EOF
}

@test "default first of last three fields" {
    run -0 fieldDefault -F $'\t' --value DEFAULT -3--1 <<'EOF'
one	two
fill
one	two	three
fill
one	two	three	four	five
fill
one	two	three	four	five	six	seven
fill
EOF

    assert_output - <<'EOF'
one	two
fill	DEFAULT
one	two	three
fill	DEFAULT
one	two	three	four	five
fill		DEFAULT
one	two	three	four	five	six	seven
fill				DEFAULT
EOF
}

@test "default all last three fields" {
    run -0 fieldDefault -F $'\t' --value DEFAULT -3 -2 -1 <<'EOF'
one	two
fill
one	two	three
fill
one	two	three	four	five
fill
one	two	three	four	five	six	seven
fill
EOF

    assert_output - <<'EOF'
one	two
fill	DEFAULT
one	two	three
fill	DEFAULT	DEFAULT
one	two	three	four	five
fill		DEFAULT	DEFAULT	DEFAULT
one	two	three	four	five	six	seven
fill				DEFAULT	DEFAULT	DEFAULT
EOF
}

@test "default third and second-to-last field" {
    run -0 fieldDefault -F $'\t' --value FIX 3 --value LAST -2 <<'EOF'
one	two
fill
one	two	three
fill
one	two	three	four	five
fill
one	two	three	four	five	six	seven
fill
EOF

    assert_output - <<'EOF'
one	two
fill
one	two	three
fill	LAST	FIX
one	two	three	four	five
fill		FIX	LAST
one	two	three	four	five	six	seven
fill		FIX			LAST
EOF
}
