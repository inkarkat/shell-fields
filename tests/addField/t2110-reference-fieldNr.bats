#!/usr/bin/env bats

load fixture

@test "duplicating the second field by referencing fieldNr" {
    run -0 addField -F $'\t' 2 '$fieldNr' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	first	100	A Here
bar	no4	no4	201
				
bzz				last
		
eof		
EOF
}

@test "duplicating the last field by referencing fieldNr" {
    run -0 addField -F $'\t' -1 '$fieldNr' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	A Here	A Here
bar	no4	201	201
				
bzz			last	last

eof	eof
EOF
}
