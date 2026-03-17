#!/usr/bin/env bats

load fixture

@test "concatenating fox to second and number of fields to last field with dash separators converted to double colon separators" {
    run -0 fieldMap --field-separator - --output-separator :: 2 '$fieldNr "fox"' 4 '$fieldNr NF' <<'EOF'
the-fox-jumps-over-the-lazy-dog
my--is-over-the--sea
our-hound-can-jump-the-many-hoops
EOF

    assert_output - <<'EOF'
the::foxfox::jumps::over7::the::lazy::dog
my::fox::is::over7::the::::sea
our::houndfox::can::jump7::the::many::hoops
EOF
}
