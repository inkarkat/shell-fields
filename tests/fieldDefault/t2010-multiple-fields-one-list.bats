#!/usr/bin/env bats

load fixture

@test "defaulting a LIST of first, second fields" {
    run -0 fieldDefault --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 1,2
    assert_output - <<'EOF'
foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34
buu	empty3		and more
DEFAULT	empty1	606	here
DEFAULT	empty13		also
DEFAULT			
bzz	DEFAULT		last
DEFAULT
eof	DEFAULT
EOF
}

@test "defaulting a LIST of first - second fields" {
    run -0 fieldDefault --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 1-2
    assert_output - <<'EOF'
foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34
buu	empty3		and more
DEFAULT	empty1	606	here
DEFAULT	empty13		also
DEFAULT			
bzz	DEFAULT		last
DEFAULT
eof	DEFAULT
EOF
}

@test "defaulting a LIST of second, fourth field" {
    run -0 fieldDefault --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 2,4
    assert_output - <<'EOF'
foo	first	100	A Here
bar	no4	201	DEFAULT
baz	empty4	301	DEFAULT
boo	no34		DEFAULT
buu	empty3		and more
	empty1	606	here
	empty13		also
	DEFAULT		
bzz	DEFAULT		last
	DEFAULT
eof	DEFAULT
EOF
}

@test "defaulting third, first field" {
    run -0 fieldDefault --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 3,1
    assert_output - <<'EOF'
foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34	DEFAULT
buu	empty3	DEFAULT	and more
DEFAULT	empty1	606	here
DEFAULT	empty13		also
DEFAULT			
bzz		DEFAULT	last
DEFAULT
eof		DEFAULT
EOF
}

@test "defaulting second - fourth field" {
    run -0 fieldDefault --file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --value DEFAULT 2-4
    assert_output - <<'EOF'
foo	first	100	A Here
bar	no4	201	DEFAULT
baz	empty4	301	DEFAULT
boo	no34	DEFAULT
buu	empty3	DEFAULT	and more
	empty1	606	here
	empty13	DEFAULT	also
	DEFAULT		
bzz	DEFAULT		last
	DEFAULT
eof	DEFAULT
EOF
}

@test "default first empty from third field on" {
    run -0 fieldDefault -F $'\t' --value DEFAULT 3- <<'EOF'
one	two	three	four	five	six	seven
one		three	four	five		seven
one	two	three	four			seven
one	two	three		five		seven
one				five	six	seven
one	two	three				seven
EOF

    assert_output - <<'EOF'
one	two	three	four	five	six	seven
one		three	four	five	DEFAULT	seven
one	two	three	four	DEFAULT		seven
one	two	three	DEFAULT	five		seven
one		DEFAULT		five	six	seven
one	two	three	DEFAULT			seven
EOF
}

@test "default first empty from fifth field from behind on" {
    run -0 fieldDefault -F $'\t' --value DEFAULT -5- <<'EOF'
one	two	three	four	five	six	seven
one		three	four	five		seven
one	two	three	four			seven
one	two	three		five		seven
one				five	six	seven
one	two	three				seven
EOF

    assert_output - <<'EOF'
one	two	three	four	five	six	seven
one		three	four	five	DEFAULT	seven
one	two	three	four	DEFAULT		seven
one	two	three	DEFAULT	five		seven
one		DEFAULT		five	six	seven
one	two	three	DEFAULT			seven
EOF
}
