#!/usr/bin/env bats

load fixture

@test "apply multiple commands to fields" {
    run -0 eachField \
	--exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ \; 1 \
	--exec sed -e 's/.*/[&]/' \; \
	--exec sed -e 's/$/!/' \; 3 \
	"${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"

    assert_output - <<'EOF'
FOO	[haha]!
BAR	[hehe]!
BAZ	[hihi]!
END	[hoho]!
EOF
}
