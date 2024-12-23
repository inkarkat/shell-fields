#!/usr/bin/env bats

load fixture

@test "last field will refer to the passed max field number" {
    run -0 fieldDefault -F $'\t' --field-num 3 --value DEFAULT -1 <<'EOF'
one	two
fill
one	two	three
fill
one	two	three	four	five
fill
one				five
fewer	here
fill
EOF

    assert_output - <<'EOF'
one	two	DEFAULT
fill		DEFAULT
one	two	three
fill		DEFAULT
one	two	three	four	five
fill		DEFAULT
one				five
fewer	here	DEFAULT
fill		DEFAULT
EOF
}

@test "second-to-last field will refer to the passed max field number unless there are more fields in a line" {
    run -0 fieldDefault -F $'\t' --field-num 3 --value DEFAULT -2 <<'EOF'
one	two
fill
one	two	three
fill
one	two	three	four	five
fill
one				five
fewer	here
fill
EOF

    assert_output - <<'EOF'
one	two
fill	DEFAULT
one	two	three
fill	DEFAULT
one	two	three	four	five
fill	DEFAULT
one			DEFAULT	five
fewer	here
fill	DEFAULT
EOF
}
