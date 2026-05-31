#!/usr/bin/env bats

load fixture

@test "grep everything but the second field yields the matching fields" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-fields --regexp '[eo]' 2
    assert_output - <<'EOF'
foo	first	A Here
	second	B There
EOF
}

@test "grep everything but the second and third fields with fixed text yields the matching fields" {
    run -0 fieldGrep --input-file "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-fields --fixed-strings --regexp r 2 3
    assert_output - <<'EOF'
	first	100	A Here
bar	second	201	B There
EOF
}
