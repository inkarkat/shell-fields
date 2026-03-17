#!/usr/bin/env bats

load fixture

@test "rotate whitespaced rectangular clockwise" {
    run -0 fieldrot90 "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output - <<'EOF'
end	baz	bar	foo
four	three	two	one
hoho	hihi	hehe	haha
EOF
}

@test "rotate whitespaced jagged clockwise" {
    run -0 fieldrot90 "${BATS_TEST_DIRNAME}/jagged-tabbed.txt"
    assert_output - <<'EOF'
end	lulli	quux	baz	bar	foo
six	five	four	three	two	one
	no	even	more
	gap	more
	fields
EOF
}

@test "rotate whitespaced gapped clockwise" {
    run -0 fieldrot90 "${BATS_TEST_DIRNAME}/gapped-tabbed.txt"
    assert_output - <<'EOF'
end	lulli	quux	baz	bar	foo
six	five	four	three	two	one
final	gap	even	more
	more
	fields
EOF
}

@test "rotate whitespaced double clockwise" {
    run -0 fieldrot90 "${BATS_TEST_DIRNAME}/double-tabbed.txt"
    assert_output - <<'EOF'
end	five	quux	three	bar	one
	even	two
	four	more
	more
	fields
EOF
}
