#!/usr/bin/env bats

load fixture

@test "normalizing first field from stdin to epoch" {
    LC_ALL=C run -0 fieldNormalizeDate -F $'\t' 1 %s < "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
1650405600	foo	@1649663333
1649663364	now	@1111111111
1640991600	new year	@1111111111
1648764000	joke	@1649666666
EOF
}
