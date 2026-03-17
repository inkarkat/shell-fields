#!/usr/bin/env bats

load fixture

@test "rotate tabbed rectangular clockwise" {
    run -0 fieldrot90 --field-separator '\t' "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output - <<'EOF'
end	baz	bar	foo
four	three	two	one
hoho	hihi	hehe	haha
EOF
}

@test "rotate tabbed jagged clockwise" {
    run -0 fieldrot90 --field-separator '\t' "${BATS_TEST_DIRNAME}/jagged-tabbed.txt"
    assert_output - <<'EOF'
end	lulli	quux	baz	bar	foo
six	five	four	three	two	one
	no	even		more
	gap	more
		fields
EOF
}

@test "rotate tabbed gapped clockwise" {
    run -0 fieldrot90 --field-separator '\t' "${BATS_TEST_DIRNAME}/gapped-tabbed.txt"
    assert_output - <<'EOF'
end	lulli	quux	baz	bar	foo
six	five	four	three	two	one
		even
	gap	more		more
		fields
final
EOF
}

@test "rotate tabbed double clockwise" {
    run -0 fieldrot90 --field-separator '\t' "${BATS_TEST_DIRNAME}/double-tabbed.txt"
    assert_output - <<'EOF'

		quux
		even		bar
	five	four	three	two	one
		more		more
		fields

end
EOF
}


@test "rotate tabbed rectangular anticlockwise" {
    run -0 fieldrot90 --field-separator '\t' --reverse "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output - <<'EOF'
haha	hehe	hihi	hoho
one	two	three	four
foo	bar	baz	end
EOF
}

@test "rotate tabbed jagged anticlockwise" {
    run -0 fieldrot90 --field-separator '\t' --reverse "${BATS_TEST_DIRNAME}/jagged-tabbed.txt"
    assert_output - <<'EOF'
			fields
			more	gap
	more		even	no
one	two	three	four	five	six
foo	bar	baz	quux	lulli	end
EOF
}

@test "rotate tabbed gapped anticlockwise" {
    run -0 fieldrot90 --field-separator '\t' --reverse "${BATS_TEST_DIRNAME}/gapped-tabbed.txt"
    assert_output - <<'EOF'
					final
			fields
	more		more	gap
			even
one	two	three	four	five	six
foo	bar	baz	quux	lulli	end
EOF
}

@test "rotate tabbed double anticlockwise" {
    run -0 fieldrot90 --field-separator '\t' --reverse "${BATS_TEST_DIRNAME}/double-tabbed.txt"
    assert_output - <<'EOF'
					end

			fields
	more		more
one	two	three	four	five
	bar		even
			quux
EOF
}
