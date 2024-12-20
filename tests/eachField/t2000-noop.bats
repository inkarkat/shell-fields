#!/usr/bin/env bats

load fixture

@test "noop processing of -- separated rectangular tabbed file" {
    run -0 eachField -- "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
    assert_output < "${BATS_TEST_DIRNAME}/rectangular-tabbed.txt"
}

@test "noop processing of jagged tabbed file" {
    run -0 eachField "${BATS_TEST_DIRNAME}/jagged-tabbed.txt"
    assert_output - <<'EOF'
foo	one			
bar	two	more		
baz	three			
quux	four	even	more	fields
lulli	five	no	gap	
end	six			
EOF
}

@test "noop processing of tabbed file with gaps" {
    run -0 eachField --field-separator $'\t' "${BATS_TEST_DIRNAME}/gapped-tabbed.txt"
    assert_output - <<'EOF'
foo	one				
bar	two		more		
baz	three				
quux	four	even	more	fields	
lulli	five		gap		
end	six				final
EOF
}
