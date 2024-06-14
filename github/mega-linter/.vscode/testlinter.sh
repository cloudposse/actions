#!/usr/bin/env bash

# At this point you can use the debug console to add export GITHUB_WORKSPACE=/path to test only a specific folder
# You can also use ln -s /path /tmp/lint as an alternative
# If you do neither, this will default to running against the test automation files

###########
# GLOBALS #
###########
CODE_PATH='/tmp/lint' # Path to code base

##################
# Check the path #
##################
if [ ! -L ${CODE_PATH} ]; then
  # Create symbolic link
  ln -s "${PWD}"/.automation/test ${CODE_PATH}
fi

#########################
# Export to run locally #
#########################
export TEST_CASE_RUN=true

# shellcheck source=/dev/null
source "${PWD}"/entrypoint.sh
