#!/bin/bash

set -x

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "Missing GITHUB_TOKEN env variable"
  exit 1
fi

if [[ -z "${INPUT_PATH}" ]]; then
  echo "Missing INPUT_PATH env variable"
  exit 1
fi

RELEASE_ID=$(jq --raw-output '.release.id' "$GITHUB_EVENT_PATH")
if [ -z "$RELEASE_ID" ]; then
  echo "Release ID is not set, will not upload binaries"
  exit 0
fi

IS_DRAFT=$(jq --raw-output '.release.draft' "$GITHUB_EVENT_PATH")
if [ "$IS_DRAFT" = true ]; then
  echo "This is a draft release, will not upload binaries"
  exit 0
fi

AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

for file in ${INPUT_PATH}; do
  echo "Uploading file ${file}"

  if [[ ! -f "$file" || ! -s "$file" ]]; then
    echo "WARNING: File ${file} does not exist or is empty"
    continue
  fi

  FILENAME=$(basename "${file}")
  UPLOAD_URL="https://uploads.github.com/repos/${GITHUB_REPOSITORY}/releases/${RELEASE_ID}/assets?name=${FILENAME}"
  tmp=$(mktemp)

  response=$(curl \
    -sSL \
    -XPOST \
    -H "${AUTH_HEADER}" \
    --upload-file "${file}" \
    --header "Content-Type:application/octet-stream" \
    --write-out "%{http_code}" \
    --output $tmp \
    "${UPLOAD_URL}")

  if [ "$?" -ne 0 ]; then
    echo "ERROR: 'curl' returned error"
    cat $tmp
    rm $tmp
    exit 1
  fi

  if [ "$response" -ge 400 ]; then
    echo "ERROR: Upload was not successful. HTTP status: $response"
    cat $tmp
    rm $tmp
    exit 1
  fi

  rm $tmp

done
