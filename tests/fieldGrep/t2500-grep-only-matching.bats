#!/usr/bin/env bats

load fixture

@test "grep the last field matching only a word" {
    run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --only-matching --regexp '[Hh]ere' -1
    assert_output - <<'EOF'
foo	first	100	Here
bar	second	201	here
EOF
}

@test "grep the second field matching only vowels; multiple matches in a field will be joined via space" {
    run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --only-matching --regexp '[aeiou]' 2
    assert_output - <<'EOF'
foo	i	100	A Here
bar	e o	201	B There
baz	i	333	C U
EOF
}

@test "grep the first and second fields matching only vowels; multiple matches in a field will be joined via space" {
    run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --only-matching --regexp '[aeiou]\+' 1 2
    assert_output - <<'EOF'
oo	i	100	A Here
a	e o	201	B There
a	i	333	C U
EOF
}

@test "grep the first and second fields Perl-matching only vowels; multiple matches in a field will be joined via space" {
    run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --only-matching --perl-regexp --regexp '[aeiou]+' 1 2
    assert_output - <<'EOF'
oo	i	100	A Here
a	e o	201	B There
a	i	333	C U
EOF
}

@test "grep the first and second fields matching only consonants; multiple matches in a field will be joined via space and attributed to the last filtered field" {
    run -0 fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --only-matching --regexp '[^aeiou]\+' 1 2
    assert_output - <<'EOF'
f	f rst	100	A Here
b	r s c nd	201	B There
b	z th rd	333	C U
EOF
}
