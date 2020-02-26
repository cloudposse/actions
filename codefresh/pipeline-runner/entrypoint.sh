#!/bin/bash

set -x

codefresh auth create-context context --api-key "$CF_API_KEY"
codefresh auth use-contex context

if [ -n "$TRIGGER_NAME" ]; then
  codefresh run "$PIPELINE_NAME" --trigger="$TRIGGER_NAME" --branch="$BRANCH"
else
  codefresh run "$PIPELINE_NAME" --branch="$BRANCH"
fi
