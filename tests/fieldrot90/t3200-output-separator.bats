#!/usr/bin/env bats

load fixture

@test "rotate tabbed rectangular clockwise with dash-separation" {
    run -0 fieldrot90 --field-separator '\t' --output-separator - "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output - <<'EOF'
end-baz-bar-foo
four-three-two-one
hoho-hihi-hehe-haha
EOF
}

@test "rotate tabbed jagged clockwise with dash-separation" {
    run -0 fieldrot90 --field-separator '\t' --output-separator - "${BATS_TEST_DIRNAME}/jagged-tabbed.txt"
    assert_output - <<'EOF'
end-lulli-quux-baz-bar-foo
six-five-four-three-two-one
-no-even--more
-gap-more
--fields
EOF
}

@test "rotate tabbed gapped clockwise with dash-separation" {
    run -0 fieldrot90 --field-separator '\t' --output-separator - "${BATS_TEST_DIRNAME}/gapped-tabbed.txt"
    assert_output - <<'EOF'
end-lulli-quux-baz-bar-foo
six-five-four-three-two-one
--even
-gap-more--more
--fields
final
EOF
}

@test "rotate tabbed double clockwise with dash-separation" {
    run -0 fieldrot90 --field-separator '\t' --output-separator - "${BATS_TEST_DIRNAME}/double-tabbed.txt"
    assert_output - <<'EOF'

--quux
--even--bar
-five-four-three-two-one
--more--more
--fields

end
EOF
}
