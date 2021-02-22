#!/usr/bin/env bats
load '/usr/local/lib/bats/load.bash'

setup() {
  TEST_TEMP_DIR="$(temp_make)"
}

@test "jsonnet" {
  cp ${BATS_TEST_DIRNAME}/fixtures/expected.all.module.tf.json ${TEST_TEMP_DIR}/expected.json

  jsonnet ./module.jsonnet \
    --ext-str source="git::https://github.com/cloudposse/terraform-null-label.git?ref=0.24.1" \
    --ext-str name="pr-1" \
    --ext-str attributes='{"enabled": "true", "name": "test", "namespace": "test-namespace", "stage": "test-stage"}' \
    --create-output-dirs \
    --output-file ${TEST_TEMP_DIR}/result.json

  run diff ${TEST_TEMP_DIR}/result.json ${TEST_TEMP_DIR}/expected.json
  assert_output ""
  assert_success
}

teardown() {
  temp_del "$TEST_TEMP_DIR"
}



