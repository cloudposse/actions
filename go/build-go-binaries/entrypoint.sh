#!/bin/bash

set -x

export GO111MODULE=off
export CGO_ENABLED=0
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export GOX_OSARCH="${GOX_OSARCH:-windows/386 windows/amd64 freebsd/arm netbsd/386 netbsd/amd64 netbsd/arm linux/s390x linux/arm darwin/386 darwin/amd64 linux/386 linux/amd64 freebsd/amd64 freebsd/386 openbsd/386 openbsd/amd64}"

if [[ -z "$INPUT_PATH" ]]; then
  echo "Missing INPUT_PATH env variable"
  exit 1
fi

if [[ -z "$OUTPUT_PATH" ]]; then
  echo "Missing OUTPUT_PATH env variable"
  exit 1
fi

go get -u github.com/mitchellh/gox
go get -u github.com/golang/dep/cmd/dep
mkdir -p "${INPUT_PATH}" || exit 1
cp -r . "${INPUT_PATH}" || exit 1
cd "${INPUT_PATH}" || exit 1
dep ensure
gox -osarch="${GOX_OSARCH}" -output "${OUTPUT_PATH}{{.OS}}_{{.Arch}}"
