#!/usr/bin/env bats

@test "noop processing of rectangular tabbed file" {
    run eachField "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    [ "$status" -eq 0 ]
    [ "$output" = "$(cat -- "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt")" ]
}

@test "noop processing of jagged tabbed file" {
    run eachField "${BATS_TEST_DIRNAME}/jagged-tabbed.txt"
    [ "$status" -eq 0 ]
    [ "$output" = "foo	one			
bar	two	more		
baz	three			
quux	four	even	more	fields
lulli	five	no	gap	
end	six			" ]
}

@test "noop processing of tabbed file with gaps" {
    run eachField --field-separator $'\t' "${BATS_TEST_DIRNAME}/gapped-tabbed.txt"
    [ "$status" -eq 0 ]
    [ "$output" = "foo	one				
bar	two		more		
baz	three				
quux	four	even	more	fields	
lulli	five		gap		
end	six				final" ]
}
