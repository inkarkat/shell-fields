#!/usr/bin/env bats

load fixture

@test "invalid date in first field gets replaced with --date-error-value" {
    LC_ALL=C run -0 --separate-stderr fieldNormalizeDate -F $'\t' --date-error-value 'too bad' 1 -- "${BATS_TEST_DIRNAME}/bad.txt"
assert_output - <<'EOF'
too bad	foo	@1649663333
Mon Apr 11 09:49:24 CEST 2022	now	""
too bad	new year	neither this
Fri Apr  1 00:00:00 CEST 2022	joke	@1649666666
EOF
}

@test "invalid date in first field gets replaced and prints date error messages" {
    LC_ALL=C run -0 --separate-stderr fieldNormalizeDate -F $'\t' --date-error-value 'too bad' 1 -- "${BATS_TEST_DIRNAME}/bad.txt"
    output="$stderr" assert_output - <<'EOF'
date: invalid date '01-01-1000'
date: invalid date 'not a date'
EOF
}

@test "replacing invalid date with --date-error-value also applies to following field" {
    LC_ALL=C run -0 --separate-stderr fieldNormalizeDate -F $'\t' --date-error-value '***' 1 -1 -- "${BATS_TEST_DIRNAME}/bad.txt"
assert_output - <<'EOF'
***	foo	Mon Apr 11 09:48:53 CEST 2022
Mon Apr 11 09:49:24 CEST 2022	now	***
***	new year	***
Fri Apr  1 00:00:00 CEST 2022	joke	Mon Apr 11 10:44:26 CEST 2022
EOF
}

@test "replacing invalid date with --date-error-value ignore can be reverted to abort for following field" {
    LC_ALL=C run -1 --separate-stderr fieldNormalizeDate -F $'\t' --date-error-value '***' 1 --date-error abort -1 -- "${BATS_TEST_DIRNAME}/bad.txt"
assert_output '***	foo	Mon Apr 11 09:48:53 CEST 2022'
}

@test "replacing invalid date with --date-error-value can be changed to ignore for following field" {
    LC_ALL=C run -0 --separate-stderr fieldNormalizeDate -F $'\t' --date-error-value '***' 1 --date-error ignore -1 -- "${BATS_TEST_DIRNAME}/bad.txt"
assert_output - <<'EOF'
***	foo	Mon Apr 11 09:48:53 CEST 2022
Mon Apr 11 09:49:24 CEST 2022	now	""
***	new year	neither this
Fri Apr  1 00:00:00 CEST 2022	joke	Mon Apr 11 10:44:26 CEST 2022
EOF
}
