#!/usr/bin/env bats

load fixture

@test "adding 0 after first field" {
    run -0 addField -F $'\t' 1 0 "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	0	first	100	A Here
bar	0	no4	201
	0			
bzz	0			last
	0
eof	0
EOF
}

@test "adding fox after second field" {
    run -0 addField -F $'\t' 2 '"fox"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	fox	100	A Here
bar	no4	fox	201
		fox		
bzz		fox		last
		fox
eof		fox
EOF
}

@test "adding empty field after second field" {
    run -0 addField -F $'\t' 2 '""' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first		100	A Here
bar	no4		201
				
bzz				last
		
eof		
EOF
}

@test "adding fox before first field" {
    run -0 addField -F $'\t' 0 '"fox"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
fox	foo	first	100	A Here
fox	bar	no4	201
fox				
fox	bzz			last
fox
fox	eof
EOF
}

@test "adding concatenation of first two fields after third field" {
    run -0 addField -F $'\t' 3 '$1 $2' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	foofirst	A Here
bar	no4	201	barno4
				
bzz			bzz	last
			
eof			eof
EOF
}

@test "adding line length after non-existing fifth field" {
    run -0 addField -F $'\t' 5 'length($0)' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	A Here		20
bar	no4	201			11
					3
bzz			last		10
					0
eof					3
EOF
}
