#!/usr/bin/env bats

load fixture

@test "non-numeric field values are treated as zero by default" {
    for fieldNr in 2 3 4
    do
	run -0 fieldFilterNumber -F $'\t' $fieldNr -eq 0 "${BATS_TEST_DIRNAME}/tabbed.txt" \
	    && { assert_output - <<'EOF'
xxx	42x	-	splunge	catch-22
eof		0		-7.777
EOF
	    } || fail "$fieldNr"
    done
}

@test "non-numeric field values are treated as zero via parameter" {
    for fieldNr in 2 3 4
    do
	run -0 fieldFilterNumber -F $'\t' --non-numeric zero $fieldNr -eq 0 "${BATS_TEST_DIRNAME}/tabbed.txt" \
	    && { assert_output - <<'EOF'
xxx	42x	-	splunge	catch-22
eof		0		-7.777
EOF
	    } || fail "$fieldNr"
    done
}

@test "non-numeric field values are kept" {
    for fieldNr in 2 4
    do
	run -0 fieldFilterNumber -F $'\t' --non-numeric keep $fieldNr -eq 1337 $fieldNr -eq 3 $fieldNr -eq -4321 "${BATS_TEST_DIRNAME}/tabbed.txt" \
	    && { assert_output - <<'EOF'
foo	1337	3	-4321	1.11
xxx	42x	-	splunge	catch-22
eof		0		-7.777
EOF
	    } || fail "$fieldNr"
    done

	run -0 fieldFilterNumber -F $'\t' --non-numeric keep 3 -eq 1337 3 -eq 3 3 -eq -4321 "${BATS_TEST_DIRNAME}/tabbed.txt" \
	    && { assert_output - <<'EOF'
foo	1337	3	-4321	1.11
xxx	42x	-	splunge	catch-22
EOF
	    } || fail 3
}

@test "non-numeric field values are dropped" {
    for fieldNr in 2 4
    do
	run -0 fieldFilterNumber -F $'\t' --non-numeric drop $fieldNr -eq 0 $fieldNr -eq 1337 $fieldNr -eq 3 $fieldNr -eq -4321 "${BATS_TEST_DIRNAME}/tabbed.txt" \
	    && { assert_output - <<'EOF'
foo	1337	3	-4321	1.11
EOF
	    } || fail "$fieldNr"
    done

	run -0 fieldFilterNumber -F $'\t' --non-numeric drop 3 -eq 0 3 -eq 1337 3 -eq 3 3 -eq -4321 "${BATS_TEST_DIRNAME}/tabbed.txt" \
	    && { assert_output - <<'EOF'
foo	1337	3	-4321	1.11
eof		0		-7.777
EOF
	    } || fail 3
}
