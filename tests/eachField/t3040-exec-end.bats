#!/usr/bin/env bats

@test "pick second field and uppercase it" {
    EACHFIELD_EXEC_END=END run eachField --exec sed -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ END 2 "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "ONE
TWO
THREE
FOUR" ]
}
