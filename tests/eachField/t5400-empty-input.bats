#!/usr/bin/env bats

emptyStdinEachField()
{
    printf ''| eachField "$@"
}

@test "empty input stays empty" {
    run emptyStdinEachField \
	--exec sed -e 's/.*/[&]/' - {} \; \
	1
    [ $status -eq 0 ]
    [ "$output" = '' ]
}

@test "empty input file stays empty" {
    run eachField \
	--exec sed -e 's/.*/[&]/' \; \
	1 -- /dev/null
    [ $status -eq 0 ]
    [ "$output" = '' ]
}

@test "empty input does not contain any contents" {
    run eachField \
	--exec wc -c \; \
	1 -- /dev/null
    [ $status -eq 0 ]
    [ "$output" = '0' ]
}

@test "empty input still invokes command for each selected field" {
    # -N selections from behind are ignored as there are 0 actual fields.
    export MARKER="${BATS_TMPDIR}/marker"
    rm -f -- "$MARKER"

    run eachField \
	--command "printf x >> ${MARKER@Q}" \
	1 3 -9 4 -6 -- /dev/null
    [ $status -eq 0 ]
    [ "$output" = '' ]
    local markerContents="$(< "$MARKER")"
    [ "$markerContents" = "xxxx" ]
}
