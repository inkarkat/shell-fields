#!/usr/bin/env bats

load fixture

setup()
{
    export FILE="${BATS_TMPDIR}/input.txt"
    cp -f "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt" "$FILE"
}

@test "file marker command is applied to all fields to uppercase all fields in-place" {
    run -0 eachField --in-place --exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ {} \; "$FILE"
    assert_output ''
    diff -y - --label expected "$FILE" <<'EOF'
FOO	ONE	HAHA
BAR	TWO	HEHE
BAZ	THREE	HIHI
END	FOUR	HOHO
EOF
}

@test "file marker command is applied to all fields to uppercase all fields in-place and writes a backup" {
    run -0 eachField --in-place=.bak --exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ {} \; "$FILE"
    assert_output ''
    diff -y - --label expected "$FILE" <<'EOF'
FOO	ONE	HAHA
BAR	TWO	HEHE
BAZ	THREE	HIHI
END	FOUR	HOHO
EOF
    assert_exists "${FILE}.bak"
    diff -y "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt" "${FILE}.bak"
}
