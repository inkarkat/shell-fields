#!/usr/bin/env bats

load fixture

@test "adding fox after second field or empty value when first field starts with b" {
    run -0 addField -F $'\t' 2 'substr($1, 1, 1) == "b" ? "fox" : ""' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first		100	A Here
bar	no4	fox	201
				
bzz		fox		last
		
eof		
EOF
}

@test "adding fox after second field only when first field starts with b via empty string sentinel" {
    run -0 addField -F $'\t' --skip-value '' 2 'substr($1, 1, 1) == "b" ? "fox" : ""' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	A Here
bar	no4	fox	201
			
bzz		fox		last

eof
EOF
}
@test "adding fox after second field only when first field starts with b via different sentinel" {
    run -0 addField -F $'\t' --skip-value 'NO' 2 'substr($1, 1, 1) == "b" ? "fox" : "NO"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	A Here
bar	no4	fox	201
			
bzz		fox		last

eof
EOF
}
@test "duplicate first field unless it is bar" {
    run -0 addField -F $'\t' --skip-value 'bar' 1 '$1' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	foo	first	100	A Here
bar	no4	201
				
bzz	bzz			last
	
eof	eof
EOF
}

@test "duplicate field 1-3 when it consists of 3 characters" {
    run -0 addField -F $'\t' --skip-value '' \
    1 'length($1) == 3 ? $1 : ""' \
    2 'length($2) == 3 ? $2 : ""' \
    3 'length($3) == 3 ? $3 : ""' \
    "${BATS_TEST_DIRNAME}/tabbed.txt"

    assert_output - <<'EOF'
foo	foo	first	100	100	A Here
bar	bar	no4	no4	201	201
			
bzz	bzz			last

eof	eof
EOF
}
