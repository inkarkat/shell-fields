#!/usr/bin/env bats

load coproc

@test "coproc that splits fields yields all three split fields" {
    run -0 fieldMap -F $'\t' 1 "|$sedCommand -e 's/.*/[&]\t&&\t(&)/'" +1 '$1' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
[foo]	foofoo	(foo)	first	100	A Here	[foo]	foofoo	(foo)
[bar]	barbar	(bar)	no4	201	[bar]	barbar	(bar)
[]		()				[]		()
[bzz]	bzzbzz	(bzz)			last	[bzz]	bzzbzz	(bzz)
[]		()
[eof]	eofeof	(eof)	[eof]	eofeof	(eof)
EOF
}

@test "coproc that splits fields yields split fields separately after reparsing" {
    run -0 fieldMap -F $'\t' 1 "|$sedCommand -e 's/.*/[&]\t&&\t(&)/'" --reparse +1 '$3 "-" $1' "${BATS_TEST_DIRNAME}/tabbed.txt"
    assert_output - <<'EOF'
[foo]	foofoo	(foo)	first	100	A Here	(foo)-[foo]
[bar]	barbar	(bar)	no4	201	(bar)-[bar]
[]		()				()-[]
[bzz]	bzzbzz	(bzz)			last	(bzz)-[bzz]
[]		()	()-[]
[eof]	eofeof	(eof)	(eof)-[eof]
EOF
}
