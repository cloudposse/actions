#!/bin/bash

set -x

# Gather list of helmfiles in current project according to the error text of `helmfile lint`:
#   "It must be named helmfile.d/*.{yaml,yml}, helmfile.yaml, or charts.yaml, or otherwise
#   specified with the --file flag"
# However, we won't find the helmfiles with custom names (specified using the --file flag in the
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
for unlinted_helmfile in "${helmfiles[@]}"; do
    # Split up helmfile path in order to move to the containing directory
    helmfile_dir=`dirname "$unlinted_helmfile"`

    # save current directory
    original_dir=$(pwd)

    # move to new directory
    cd $helmfile_dir
    echo "$unlinted_helmfile"
    /helmfile_linux_amd64 lint
    echo "\n"

    # move back to original directory
    cd $original_dir
done
echo "Done linting helmfiles."
echo "\n"
