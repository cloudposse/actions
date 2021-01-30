#!/bin/bash

set -e -o pipefail

export PROJECT="${INPUT_CF_PROJECT}"
export REPO="${INPUT_REPO}"

NETRC="$HOME/.netrc"
printf "machine github.com\n" > "$NETRC"
printf "login %s\n" "$GITHUB_USER" >> "$NETRC"
printf "password %s\n" "$GITHUB_TOKEN" >> "$NETRC"

echo "Cloning repo ${INPUT_CF_REPO_URL} version ${INPUT_CF_REPO_VERSION}"
git clone -c advice.detachedHead=false --depth=1 -b "${INPUT_CF_REPO_VERSION}" "${INPUT_CF_REPO_URL}" codefresh
cd ./codefresh

for spec in $(tr , ' ' <<<"${INPUT_CF_SPECS}"); do
  echo "Updating '${spec}' pipeline..."
  input_pipeline_file=./pipelines/"${INPUT_CF_SPEC_TYPE}"/"${spec}".yaml
  input_spec_file=./specs/"${INPUT_CF_SPEC_TYPE}"/"${spec}".yaml
  output_file=./specs/"${INPUT_CF_SPEC_TYPE}"/"${spec}"-rendered.yaml
  gomplate -d pipeline="$input_pipeline_file" -f "$input_spec_file" -o "$output_file"
  codefresh get project "${INPUT_CF_PROJECT}" || codefresh create project "${INPUT_CF_PROJECT}"
  codefresh replace pipeline -f "$output_file" || codefresh create pipeline -f "$output_file"
done
