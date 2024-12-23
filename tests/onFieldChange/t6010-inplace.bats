#!/usr/bin/env bats

load fixture

setup()
{
    export FILE="${BATS_TMPDIR}/input.txt"
    cp --force -- "${BATS_TEST_DIRNAME}/pasta.txt" "$FILE"
    rm --force -- "${FILE}.bak"
}

@test "trigger is applied in-place" {
    run -0 onFieldChange --in-place -F $'\t' --command 'echo >&2 Change in {}' 1 "$FILE"
    assert_output - <<'EOF'
Change in 4
Change in 5
EOF
    diff -y "${BATS_TEST_DIRNAME}/pasta.txt" "$FILE"
}

@test "trigger is applied in-place and does not write a backup because no --remove-fields" {
    run -0 onFieldChange --in-place=.bak -F $'\t' --command 'echo >&2 Change in {}' 1 "$FILE"
    assert_output - <<'EOF'
Change in 4
Change in 5
EOF
    diff -y "${BATS_TEST_DIRNAME}/pasta.txt" "$FILE"
    [ ! -e "${FILE}.bak" ]
}

@test "second field is removed in-place and writes a backup" {
    run -0 onFieldChange --in-place=.bak -F $'\t' --remove-fields --command 'echo >&2 Change in {}' 2 "$FILE"
    assert_output - <<'EOF'
Change in 2
Change in 3
Change in 6
EOF
    diff -y - --label expected "$FILE" <<'EOF'
ramen
ramen
ramen
penne
ravioli
ravioli
EOF
    assert_exists "${FILE}.bak"
    diff -y "${BATS_TEST_DIRNAME}/pasta.txt" "${FILE}.bak"
}
