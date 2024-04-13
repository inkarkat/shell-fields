#!/usr/bin/env bats

load markers

@test "execute command-line on field change" {
    run onFieldChange -F $'\t' --command "touch ${MARKER_ONE@Q}" 3 "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ -e "$MARKER_ONE" ]
}

@test "execute command on field change" {
    run onFieldChange -F $'\t' --exec touch "$MARKER_TWO" \; 3 "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ -e "$MARKER_TWO" ]
}

@test "execute multiple commands on field change" {
    run onFieldChange -F $'\t' --command "touch ${MARKER_ONE@Q}" --exec touch "$MARKER_TWO" \; 3 "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ -e "$MARKER_ONE" ]
    [ -e "$MARKER_TWO" ]
}
