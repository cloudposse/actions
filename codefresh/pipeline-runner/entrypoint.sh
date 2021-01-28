#!/bin/bash

set -e -o pipefail

codefresh auth create-context context
codefresh auth use-contex context

if [ -n "$TRIGGER_NAME" ]; then
  codefresh run "$PIPELINE_NAME" --trigger="$TRIGGER_NAME" --branch="$BRANCH"
else
  codefresh run "$PIPELINE_NAME" --branch="$BRANCH"
fi
