#!/usr/bin/env bats

load fixture

@test "apply different commands to individual fields" {
    run -0 eachField \
	--exec sed -e 's/.*/[&]/' \; 1 3 \
	--exec sed -e 's/.*/<&>/' \; 3 2 \
	"${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"

    assert_output - <<'EOF'
[foo]	[haha]	<haha>	<one>
[bar]	[hehe]	<hehe>	<two>
[baz]	[hihi]	<hihi>	<three>
[end]	[hoho]	<hoho>	<four>
EOF
}

@test "apply different commands to sets of fields" {
    run -0 eachField \
	--exec sed -e 's/.*/[&]/' \; 1,3 \
	--exec sed -e 's/.*/<&>/' \; 3,2 \
	"${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"

    assert_output - <<'EOF'
[foo	haha]	<haha	one>
[bar	hehe]	<hehe	two>
[baz	hihi]	<hihi	three>
[end	hoho]	<hoho	four>
EOF
}

@test "sets of fields from behind " {
    run -0 eachField \
	--exec sed -e 's/.*/[&]/' \; 1,-1 \
	--exec sed -e 's/.*/<&>/' \; -1,2 \
	"${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"

    assert_output - <<'EOF'
[foo	haha]	<haha	one>
[bar	hehe]	<hehe	two>
[baz	hihi]	<hihi	three>
[end	hoho]	<hoho	four>
EOF
}

@test "set of duplicate fields" {
    run -0 eachField \
	--exec sed -e 's/.*/[&]/' \; -1,2,3,2 \
	"${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"

    assert_output - <<'EOF'
[haha	one	haha	one]
[hehe	two	hehe	two]
[hihi	three	hihi	three]
[hoho	four	hoho	four]
EOF
}
