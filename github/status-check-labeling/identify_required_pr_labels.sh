# I'm expecting some greps to fail, so we want to continue running whenever we encounter errors.
set +e

# We're starting with a pull request.
PR_NUMBER=${GITHUB_EVENT_NUMBER}
# Get the most recent commit on this pull request.
COMMIT_LOG_INFO=$(curl \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/${PR_NUMBER}/commits)
echo "commit_log_info: $COMMIT_LOG_INFO"
MOST_RECENT_SHA=$(echo $COMMIT_LOG_INFO | jq .[-1].sha)
MOST_RECENT_SHA_DIGEST=$(echo $MOST_RECENT_SHA | cut -c -7) 

# start out assuming the label is not needed, since we don't yet know whether the checks of interest are even present
LABEL_NEEDED=0
# get a list of all the check suites associated with this commit
CHECK_SUITES_INFO=$(curl \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    https://api.github.com/repos/${GITHUB_REPOSITORY}/commits/${MOST_RECENT_SHA_DIGEST}/check-suites)
CHECK_SUITES_NAMES=$(echo $CHECK_SUITES_INFO | jq .check_suites[].id)
CHECK_SUITES_ARRAY=( $CHECK_SUITES_NAMES )
# For each check suite, get the number of runs in that check suite
for check_suite in "${CHECK_SUITES_ARRAY[@]}"; do
  echo "check_suite: $check_suite"
  CHECK_SUITE_INFO=$(curl \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    https://api.github.com/repos/${GITHUB_REPOSITORY}/check-suites/${check_suite}/check-runs)
  echo "CHECK_SUITE_INFO:"
  cat ${CHECK_SUITE_INFO} | jq .
  NUMBER_OF_RUNS=$( echo $CHECK_SUITE_INFO | jq '.check_runs | length')
  # Check each run in the check suite for ${{ inputs.check-name }}ivity
  if [ "$NUMBER_OF_RUNS" -gt "0" ]; then
    # grep for ${{ inputs.check-name }} in the run names
    LAST_RUN_INDEX=$(($NUMBER_OF_RUNS-1))
    for run_index in $(seq 0 $LAST_RUN_INDEX); do
      echo $CHECK_SUITE_INFO | jq .check_runs[${run_index}].name
      echo $CHECK_SUITE_INFO | jq .check_runs[${run_index}].name | grep -q "${INPUTS_CHECK_NAME}"
      # if "${{ inputs.check-name }}" is found in the run name,
      # first set LABEL_NEEDED=1 (since we only potentially need a label when the relevant checks actuall took place),
      # and then check this run's title for "${{ inputs.check-description }}" (when we might set LABEL_NEEDED back to 0)
      if [[ "$?" -eq "0" ]]; then
        LABEL_NEEDED=1
        echo "  Description check"
        echo $CHECK_SUITE_INFO | jq .check_runs[${run_index}].output.title | grep -q "${INPUTS_CHECK_DESCRIPTION}"
        # if the desired phrase isn't found, set LABEL_NEEDED=0 again and exit all the nested loops
        phrase_found_yn=$?
        if [[ "$phrase_found_yn" -ne "0" ]]; then
          echo "    check found without appropriate description - exiting!"
          LABEL_NEEDED=0
          break 2
        else
          echo "    description found"
        fi
      else
        echo "  not a ${INPUTS_CHECK_NAME} check, moving on"
      fi
    done
  fi
done

# Now that we've determined the desired value of LABEL_NEEDED, let's export it for use in labeling the pull request.
echo "Label needed: $LABEL_NEEDED"
echo "::set-output name=label_needed::${LABEL_NEEDED}"
