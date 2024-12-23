#!/usr/bin/env bats

load fixture

@test "apply mixed file marker command and commandlines" {
    run -0 eachField \
	--command 'sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ {}' \
	--exec sed -e 's/.*/[&]/' - {} \; \
	--command "sed -e 's/\$/!/'" \
	1 < "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"

    assert_output - <<'EOF'
[FOO]!
[BAR]!
[BAZ]!
[END]!
[foo]!
[bar]!
[baz]!
[end]!
EOF
}
