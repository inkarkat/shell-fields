#!/usr/bin/env bats

load fixture

@test "invalid date in first field is ignored with --date-error ignore" {
    LC_ALL=C run -0 --separate-stderr fieldNormalizeDate -F $'\t' --date-error ignore 1 -- "${BATS_TEST_DIRNAME}/bad.txt"
    assert_output - <<'EOF'
01-01-1000	foo	@1649663333
Mon Apr 11 09:49:24 CEST 2022	now	""
not a date	new year	neither this
Fri Apr  1 00:00:00 CEST 2022	joke	@1649666666
EOF
}

@test "invalid date in first field is ignored and prints date error messages" {
    LC_ALL=C run -0 --separate-stderr fieldNormalizeDate -F $'\t' --date-error ignore 1 -- "${BATS_TEST_DIRNAME}/bad.txt"
    output="$stderr" assert_output - <<'EOF'
date: invalid date '01-01-1000'
date: invalid date 'not a date'
EOF
}

@test "ignoring invalid date with --date-error ignore also applies to following field" {
    LC_ALL=C run -0 --separate-stderr fieldNormalizeDate -F $'\t' --date-error ignore 1 -1 -- "${BATS_TEST_DIRNAME}/bad.txt"
assert_output - <<'EOF'
01-01-1000	foo	Mon Apr 11 09:48:53 CEST 2022
Mon Apr 11 09:49:24 CEST 2022	now	""
not a date	new year	neither this
Fri Apr  1 00:00:00 CEST 2022	joke	Mon Apr 11 10:44:26 CEST 2022
EOF
}

@test "ignoring invalid date with --date-error ignore can be reverted to abort for following field" {
    LC_ALL=C run -1 --separate-stderr fieldNormalizeDate -F $'\t' --date-error ignore 1 --date-error abort -1 -- "${BATS_TEST_DIRNAME}/bad.txt"
assert_output '01-01-1000	foo	Mon Apr 11 09:48:53 CEST 2022'
}
