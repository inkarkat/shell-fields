#!/usr/bin/env bats

load fixture

@test "adding external var1 after second and var2 after fourth field" {
    run -0 addField -v var1=fox -v var2=fun -F $'\t' 2 'var1' 4 'var2' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	fox	100	A Here	fun
bar	no4	fox	201		fun
		fox			fun
bzz		fox		last	fun
		fox			fun
eof		fox			fun
EOF
}
