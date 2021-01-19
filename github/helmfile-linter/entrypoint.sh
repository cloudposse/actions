#!/bin/bash

set -x

# download helmfile
curl https://github.com/roboll/helmfile/releases/download/v0.137.0/helmfile_linux_amd64
chmod 764 helmfile_linux_amd64

# Gather list of helmfiles in current project according to the error text of `helmfile lint`:
# "It must be named helmfile.d/*.{yaml,yml}, helmfile.yaml, or charts.yaml, or otherwise
# specified with the --file flag"
# However, we won't find helmfiles with custom names (specified using the --file flag in the
# helmfile command).
helmfiles=( $(find . -type f -name "helmfile.yaml") )
for new_helmfile in $(find . -type f -name "charts.yaml"); do
    helmfiles+=("$new_helmfile")
done
for new_helmfile in $(find . -type f -path '*helmfile.d/*' -name '*.yaml' -o -name '*.yml'); do
    helmfiles+=("$new_helmfile")
done

# lint each helmfile
echo "Linting helmfiles."
for unlinted_helmfile in helmfiles; do
    echo "$unlinted_helmfile"
    ./helmfile_linux_amd64 $unlinted_helmfile
    echo "\n"
done
echo "\n"
