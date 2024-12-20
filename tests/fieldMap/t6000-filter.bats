#!/usr/bin/env bats

load fixture

@test "turning first field to 0 and filtering empty lines" {
    run -0 fieldMap -F $'\t' --filter '$0 ~ /\S/' 1 0 "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
0	first	100	A Here
0	no4	201
0			last
0
EOF
}

@test "only filtering empty lines" {
    run -0 fieldMap -F $'\t' --filter '$0 ~ /\S/' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	A Here
bar	no4	201
bzz			last
eof
EOF
}

@test "either of two filters applies" {
    run -0 fieldMap -F $'\t' --filter '$0 ~ /\S/' --filter '$NF != "last"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	A Here
bar	no4	201
eof
EOF
}

@test "mixing mapping and filtering" {
    run -0 fieldMap -F $'\t' --filter '$0 ~ /\S/' 1 0 --filter '$NF != "last"' 2 '"xxx"' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
0	xxx	100	A Here
0	xxx	201
0	xxx
EOF
}
