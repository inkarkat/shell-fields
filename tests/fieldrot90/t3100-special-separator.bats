#!/usr/bin/env bats

load fixture

@test "rotate dashed rectangular clockwise" {
    run -0 fieldrot90 --field-separator '-' <<'EOF'
foo-one-haha
bar-two-hehe
baz-three-hihi
end-four-hoho
EOF
    assert_output - <<'EOF'
end-baz-bar-foo
four-three-two-one
hoho-hihi-hehe-haha
EOF
}
