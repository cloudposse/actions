#!/bin/bash

set -e -o pipefail

export PROJECT="${INPUT_PROJECT}"
export GITHUB_TOKEN="${INPUT_GITHUB_TOKEN}"

git clone "${INPUT_REPO_URL}"
cd "${INPUT_REPO_NAME}" || exit 1
git checkout "${INPUT_VERSION}"

codefresh auth create-context context --api-key "$INPUT_CF_API_KEY"
codefresh auth use-contex context

for spec in $(tr , ' ' <<<"${INPUT_SPECS}"); do
  gomplate -d pipeline=./"${INPUT_PIPELINE_CATALOG}"/"${spec}".yaml -f ./"${INPUT_SPEC_CATALOG}"/"${spec}".yaml -o ./"${INPUT_SPEC_CATALOG}"/"${spec}"-rendered.yaml
  codefresh get project "${INPUT_PROJECT}" || codefresh create project "${INPUT_PROJECT}"
  codefresh replace pipeline -f ./"${INPUT_SPEC_CATALOG}"/"${spec}"-rendered.yaml || codefresh create pipeline -f ./"${INPUT_SPEC_CATALOG}"/"${spec}"-rendered.yaml
done
