#!/usr/bin/env bats

load fixture

@test "rotate whitespaced rectangular clockwise" {
    run -0 fieldrot90 --reverse "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output - <<'EOF'
haha	hehe	hihi	hoho
one	two	three	four
foo	bar	baz	end
EOF
}

@test "rotate whitespaced jagged clockwise" {
    run -0 fieldrot90 --reverse "${BATS_TEST_DIRNAME}/jagged-tabbed.txt"
    assert_output - <<'EOF'
			fields
			more	gap
	more		even	no
one	two	three	four	five	six
foo	bar	baz	quux	lulli	end
EOF
}

@test "rotate whitespaced gapped clockwise" {
    run -0 fieldrot90 --reverse "${BATS_TEST_DIRNAME}/gapped-tabbed.txt"
    assert_output - <<'EOF'
			fields
			more
	more		even	gap	final
one	two	three	four	five	six
foo	bar	baz	quux	lulli	end
EOF
}

@test "rotate whitespaced double clockwise" {
    run -0 fieldrot90 --reverse "${BATS_TEST_DIRNAME}/double-tabbed.txt"
    assert_output - <<'EOF'
			fields
			more
	more		four
	two		even
one	bar	three	quux	five	end
EOF
}
