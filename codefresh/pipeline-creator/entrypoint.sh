#!/bin/bash

set -e -o pipefail

export PROJECT="${INPUT_CF_PROJECT}"
export REPO="${INPUT_REPO}"

NETRC="$HOME/.netrc"

printf "machine github.com\n" > "$NETRC"
printf "login %s\n" "$GITHUB_USER" >> "$NETRC"
printf "password %s\n" "$GITHUB_TOKEN" >> "$NETRC"

echo "Cloning repo from ${INPUT_CF_REPO_URL}"
git clone "${INPUT_CF_REPO_URL}" codefresh
cd ./codefresh

echo "Checking out ${INPUT_CF_REPO_VERSION}"
git checkout "${INPUT_CF_REPO_VERSION}"

codefresh auth create-context

for spec in $(tr , ' ' <<<"${INPUT_CF_SPECS}"); do
  echo "Updating ${spec} spec"
  input_pipeline_file=./"${INPUT_CF_PIPELINE_CATALOG}"/"${spec}".yaml
  input_spec_file=./"${INPUT_CF_SPEC_CATALOG}"/"${spec}".yaml
  output_file=./"${INPUT_CF_SPEC_CATALOG}"/"${spec}"-rendered.yaml
  gomplate -d pipeline="$input_pipeline_file" -f "$input_spec_file" -o "$output_file"
  codefresh get project "${INPUT_CF_PROJECT}" || codefresh create project "${INPUT_CF_PROJECT}"
  codefresh replace pipeline -f "$output_file" || codefresh create pipeline -f "$output_file"
done
