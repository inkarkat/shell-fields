#!/bin/bash

markersSetup()
{
    export MARKER_ONE="${BATS_TMPDIR}/marker-one"
    export MARKER_TWO="${BATS_TMPDIR}/marker-two"
    rm --force -- "$MARKER_ONE" "$MARKER_TWO"
}
setup()
{
    markersSetup
}
