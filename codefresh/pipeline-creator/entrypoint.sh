#!/bin/bash

set -e -o pipefail

export PROJECT="${INPUT_PROJECT}"

git clone "${INPUT_REPO_URL}"
cd "${INPUT_REPO_NAME}"
git checkout "${INPUT_VERSION}"

codefresh auth create-context context --api-key "$INPUT_CF_API_KEY"
codefresh auth use-contex context

for spec in $(tr , ' ' <<<"${INPUT_SPECS}"); do
  input_file=./"${INPUT_PIPELINE_CATALOG}"/"${spec}".yaml
  output_file=./"${INPUT_SPEC_CATALOG}"/"${spec}"-rendered.yaml
  gomplate -d pipeline=$input_file -f $input_file -o $output_file
  codefresh get project "${INPUT_PROJECT}" || codefresh create project "${INPUT_PROJECT}"
  codefresh replace pipeline -f $output_file || codefresh create pipeline -f $output_file
done
