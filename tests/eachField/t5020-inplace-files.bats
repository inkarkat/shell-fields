#!/usr/bin/env bats

load fixture

setup()
{
    export FILE1="${BATS_TMPDIR}/input1.txt"
    export FILE2="${BATS_TMPDIR}/input2.txt"
    cp -f "${BATS_TEST_DIRNAME}/jagged-tabbed.txt" "$FILE1"
    cp -f "${BATS_TEST_DIRNAME}/gapped-tabbed.txt" "$FILE2"
}

@test "file marker command is applied to all files in-place" {
    type -t eachFile >/dev/null || skip 'eachFile is not available'

    run -0 eachField --in-place --exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ {} \; "$FILE1" "$FILE2"
    assert_output ''
    diff -y - --label expected "$FILE1" <<'EOF'
FOO	ONE			
BAR	TWO	MORE		
BAZ	THREE			
QUUX	FOUR	EVEN	MORE	FIELDS
LULLI	FIVE	NO	GAP	
END	SIX			
EOF
    diff -y - --label expected "$FILE2" <<'EOF'
FOO	ONE			
BAR	TWO	MORE		
BAZ	THREE			
QUUX	FOUR	EVEN	MORE	FIELDS
LULLI	FIVE	GAP		
END	SIX	FINAL		
EOF
}
