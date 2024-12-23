#!/usr/bin/env bats

load fixture

@test "empty input stays empty" {
    run -0 eachField \
	--exec sed -e 's/.*/[&]/' - {} \; \
	1 < /dev/null
    assert_output ''
}

@test "empty input file stays empty" {
    run -0 eachField \
	--exec sed -e 's/.*/[&]/' \; \
	1 -- /dev/null
    assert_output ''
}

@test "empty input does not contain any contents" {
    run -0 eachField \
	--exec wc -c \; \
	1 -- /dev/null
    assert_output '0'
}

@test "empty input still invokes command for each selected field" {
    # -N selections from behind are ignored as there are 0 actual fields.
    export MARKER="${BATS_TMPDIR}/marker"
    rm -f -- "$MARKER"

    run -0 eachField \
	--command "printf x >> ${MARKER@Q}" \
	1 3 -9 4 -6 -- /dev/null
    assert_output ''
    local markerContents="$(< "$MARKER")"
    [ "$markerContents" = "xxxx" ]
}
