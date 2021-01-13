#!/bin/bash

set -x

git clone "${REPO_URL}"
cd "${REPO_NAME}" || exit 1
git checkout "${VERSION}"

codefresh auth create-context context --api-key "$CF_API_KEY"
codefresh auth use-contex context

for spec in $(tr , ' ' <<<"${SPECS}"); do
  gomplate -d pipeline=./"${PIPELINE_CATALOG}"/"${spec}".yaml -f ./"${SPEC_CATALOG}"/"${spec}".yaml -o ./"${SPEC_CATALOG}"/"${spec}"-rendered.yaml
  codefresh create pipeline -f ./"${SPEC_CATALOG}"/"${spec}"-rendered.yaml
done
