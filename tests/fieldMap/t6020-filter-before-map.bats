#!/usr/bin/env bats

load fixture

@test "filtering happens before mapping" {
    run -0 fieldMap -F $'\t' 1 '++counter' --filter '$0 ~ /\S/' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
1	first	100	A Here
2	no4	201
3			last
4
EOF
}
