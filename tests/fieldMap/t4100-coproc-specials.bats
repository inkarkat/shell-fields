#!/usr/bin/env bats

load coproc

@test "coproc that duplicates lines" {
    run -0 fieldMap -F $'\t' 1 "|$sedCommand -e 's/^\$/(empty)/' -e p" "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
foo	first	100	A Here
foo	no4	201
bar			
bar			last
(empty)
(empty)
EOF
}

@test "coproc pipeline" {
    run -0 fieldMap -F $'\t' 1 "|$uppercaseCommand | $sedCommand 's/.*/[&]/'" "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
[FOO]	first	100	A Here
[BAR]	no4	201
[]			
[BZZ]			last
[]
[EOF]
EOF
}
