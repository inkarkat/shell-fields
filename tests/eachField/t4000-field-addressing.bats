#!/usr/bin/env bats

load fixture

@test "drop middle field" {
    run -0 eachField 1 3 "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output - <<'EOF'
foo	haha
bar	hehe
baz	hihi
end	hoho
EOF
}

@test "reorder fields" {
    run -0 eachField 3 1 2 "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output - <<'EOF'
haha	foo	one
hehe	bar	two
hihi	baz	three
hoho	end	four
EOF
}

@test "address fields from behind" {
    run -0 eachField -1 -2 "${BATS_TEST_DIRNAME}/jagged-tabbed.txt"
    assert_output - <<'EOF'
one	foo
more	two
three	baz
fields	more
gap	no
six	end
EOF
}

@test "address non-existing fields from behind" {
    run -0 eachField -111 -1 -10 -2 -33 "${BATS_TEST_DIRNAME}/jagged-tabbed.txt"
    assert_output - <<'EOF'
one	foo
more	two
three	baz
fields	more
gap	no
six	end
EOF
}
