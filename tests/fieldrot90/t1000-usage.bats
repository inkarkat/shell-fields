#!/usr/bin/env bats

load fixture

@test "--man prints long usage help" {
    run -0 fieldrot90 --man
    refute_line -n 0 -e '^Usage:'
}
