#!/usr/bin/env bats

@test "triggers on multiple fields are executed in order of arguments" {
    run onFieldChange -F $'\t' \
	    --exec echo 'Level change in {} to {+}' \; 3 \
	    --exec echo 'Marker change in {} to {+}' \; 4 \
	    --exec echo 'Number change in {} to {+}' \; 2\
	    --exec echo 'Sigil change in {} to {+}' \; 5 \
	    --exec echo 'Value change in {} to {+}' \; 1 \
	    "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 0 ]
    [ "$output" = "foo	1	low	X
Number change in 2 to 0
foo	0	low	X
Sigil change in 3 to #
Value change in 3 to bar
bar	0	low	X	#
Sigil change in 4 to 
bar	0	low	X
Number change in 5 to 1
Sigil change in 5 to #
Value change in 5 to 
	1	low	X	#
Sigil change in 6 to 
Value change in 6 to bar
bar	1	low	X
Level change in 7 to high
Number change in 7 to 0
Sigil change in 7 to @
bar	0	high	X	@
Value change in 8 to 
	0	high	X	@
Number change in 9 to 1
Sigil change in 9 to 
	1	high	X" ]
}
