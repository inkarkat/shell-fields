#!/usr/bin/env bats

load fixture

setup()
{
    export FILE="${BATS_TMPDIR}/input.txt"
    cp -f "${BATS_TEST_DIRNAME}/tabbed.txt" "$FILE"
}

@test "grep the first field with fixed text in-place modifies the input file" {
    run -0 fieldDefault --input "$FILE" --in-place -F $'\t' --value DEFAULT 1
    assert_output ''
    diff -y - --label expected "$FILE" <<'EOF'
foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34
buu	empty3		and more
DEFAULT	empty1	606	here
DEFAULT	empty13		also
DEFAULT			
bzz			last
DEFAULT
eof
EOF
}

@test "grep the first field with fixed text in-place modifies the input file and writes a backup" {
    rm -f -- "${FILE}.bak"
    run -0 fieldDefault --input "$FILE" --in-place=.bak -F $'\t' --value DEFAULT 1
    assert_output ''
    diff -y - --label expected "$FILE" <<'EOF'
foo	first	100	A Here
bar	no4	201
baz	empty4	301	
boo	no34
buu	empty3		and more
DEFAULT	empty1	606	here
DEFAULT	empty13		also
DEFAULT			
bzz			last
DEFAULT
eof
EOF

    assert_exists "${FILE}.bak"
    diff -y "${BATS_TEST_DIRNAME}/tabbed.txt" "${FILE}.bak"
}
