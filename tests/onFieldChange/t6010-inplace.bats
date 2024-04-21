#!/usr/bin/env bats

setup()
{
    export FILE="${BATS_TMPDIR}/input.txt"
    cp -f "${BATS_TEST_DIRNAME}/pasta.txt" "$FILE"
}

@test "trigger is applied in-place" {
    run onFieldChange --in-place -F $'\t' --command 'echo >&2 Change in {}' 1 "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "Change in 4
Change in 5" ]
    cmp -- "${BATS_TEST_DIRNAME}/pasta.txt" "$FILE"
}

@test "trigger is applied in-place and writes a backup" {
    run onFieldChange --in-place=.bak -F $'\t' --command 'echo >&2 Change in {}' 1 "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "Change in 4
Change in 5" ]
    cmp -- "${BATS_TEST_DIRNAME}/pasta.txt" "$FILE"
    [ -e "${FILE}.bak" ]
    cmp -- "${BATS_TEST_DIRNAME}/pasta.txt" "${FILE}.bak"
}

@test "second field is removed in-place and writes a backup" {
    run onFieldChange --in-place=.bak -F $'\t' --remove-fields --command 'echo >&2 Change in {}' 2 "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "Change in 2
Change in 3
Change in 6" ]
    [ "$(cat "$FILE")" = "ramen
ramen
ramen
penne
ravioli
ravioli" ]
    [ -e "${FILE}.bak" ]
    cmp -- "${BATS_TEST_DIRNAME}/pasta.txt" "${FILE}.bak"
}
