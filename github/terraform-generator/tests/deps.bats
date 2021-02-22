#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

@test "variant exists" {
	run variant
	assert_success
}

@test "git exists" {
	run git --version
	assert_success
}

@test "jsonnet exists" {
	run jsonnet --version
	assert_success
}
