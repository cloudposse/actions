#!/usr/bin/env bats
load '/usr/local/lib/bats/load.bash'

setup() {
  TEST_TEMP_DIR="$(temp_make)"
}

@test "generate - required variables only" {
  cp ${BATS_TEST_DIRNAME}/fixtures/expected.required.module.tf.json ${TEST_TEMP_DIR}/expected.json

  run ./main.variant generate \
    --component ${TEST_TEMP_DIR}/components/preview \
    --module_source git::https://github.com/cloudposse/terraform-null-label.git?ref=0.24.1 \
    --module_name pr-1
  assert_success

  assert_file_exist ${TEST_TEMP_DIR}/components/preview/pr-1.json
  run diff ${TEST_TEMP_DIR}/components/preview/pr-1.json ${TEST_TEMP_DIR}/expected.json
  assert_output ""
  assert_success
}

@test "generate - all variables" {
  cp ${BATS_TEST_DIRNAME}/fixtures/expected.all.module.tf.json ${TEST_TEMP_DIR}/expected.json

  run ./main.variant generate \
    --component ${TEST_TEMP_DIR}/components/preview \
    --module_source git::https://github.com/cloudposse/terraform-null-label.git?ref=0.24.1 \
    --module_name pr-1 \
    --module_attributes '{"enabled": "true", "name": "test", "namespace": "test-namespace", "stage": "test-stage"}'
  assert_success

  assert_file_exist ${TEST_TEMP_DIR}/components/preview/pr-1.json
  run diff ${TEST_TEMP_DIR}/components/preview/pr-1.json ${TEST_TEMP_DIR}/expected.json
  assert_output ""
  assert_success
}

@test "generate - non json module attribures" {
  run ./main.variant generate \
    --component ${TEST_TEMP_DIR}/components/preview \
    --module_source git::https://github.com/cloudposse/terraform-null-label.git?ref=0.24.1 \
    --module_name pr-1 \
    --module_attributes '{"enabled: }'
  assert_failure
  assert_output --partial "with opt.module_attributes as \"{\\\"enabled: }\""
}


teardown() {
  temp_del "$TEST_TEMP_DIR"
}
