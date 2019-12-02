#!/bin/bash

set -x

export GO111MODULE="${GO111MODULE:-on}"
export CGO_ENABLED=0
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export GOX_OSARCH="${GOX_OSARCH:-linux/386 linux/amd64}"

if [[ -z "$OUTPUT_PATH" ]]; then
  echo "Missing OUTPUT_PATH env variable"
  exit 1
fi

pwd
ls

if [[ ! -z "$WORKING_DIR" ]]; then
  mkdir -p "${WORKING_DIR}" || exit 1
  cp -r . "${WORKING_DIR}" || exit 1
  cd "${WORKING_DIR}" || exit 1
  pwd
  ls
fi

go get -u github.com/mitchellh/gox

if [[ "$GO111MODULE" != "on" ]]; then
  go get -u github.com/golang/dep/cmd/dep
  dep ensure
fi

gox -osarch="${GOX_OSARCH}" -output "${OUTPUT_PATH}{{.OS}}_{{.Arch}}"
