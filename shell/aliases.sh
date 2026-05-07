#!/bin/sh source-this-script

eval "$(runWithPrompt --addAliasSupport fieldsToArgs \
    'r' \
    'run-if-empty|separate-errors' \
    'F' \
    'field-separator|header-field|extract-header-field|separate-errors|between-command'
)"
