#!/usr/bin/env bats

load fixture

@test "concatenating external var1 to second and var2 to fourth field" {
    run -0 fieldMap -v var1=fox -v var2=fun -F $'\t' 2 '$fieldNr var1' 4 '$fieldNr var2' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	firstfox	100	A Herefun
bar	no4fox	201	fun
	fox		fun
bzz	fox		lastfun
	fox		fun
eof	fox		fun
EOF
}
