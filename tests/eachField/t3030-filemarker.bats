#!/usr/bin/env bats

load fixture

@test "file marker command is applied to all fields to uppercase all fields" {
    run -0 eachField --exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ {} {} \; "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output - <<'EOF'
FOO	ONE	HAHA
BAR	TWO	HEHE
BAZ	THREE	HIHI
END	FOUR	HOHO
FOO	ONE	HAHA
BAR	TWO	HEHE
BAZ	THREE	HIHI
END	FOUR	HOHO
EOF
}

@test "file marker commandline is applied to all fields to uppercase all fields" {
    run -0 eachField --command 'cat {} {} | sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output - <<'EOF'
FOO	ONE	HAHA
BAR	TWO	HEHE
BAZ	THREE	HIHI
END	FOUR	HOHO
FOO	ONE	HAHA
BAR	TWO	HEHE
BAZ	THREE	HIHI
END	FOUR	HOHO
EOF
}

@test "apply mixed file marker command and commandlines" {
    run -0 eachField \
	--command 'sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ {}' \
	--exec sed -e 's/.*/[&]/' - {} \; \
	--command "sed -e 's/\$/!/'" \
	1 \
	"${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"

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
