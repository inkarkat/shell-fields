#!/usr/bin/env bats

load fixture

@test "duplicating the second field by referencing fieldNr" {
    run -0 fieldMap -F $'\t' 2 '$fieldNr $fieldNr' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	firstfirst	100	A Here
bar	no4no4	201
			
bzz			last
	
eof	
EOF
}

@test "duplicating the last field by referencing fieldNr" {
    run -0 fieldMap -F $'\t' -1 '$fieldNr $fieldNr' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	A HereA Here
bar	no4	201201
			
bzz			lastlast

eofeof
EOF
}
