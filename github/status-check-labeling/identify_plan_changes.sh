# I'm expecting some greps to fail, so we want to continue running whenever we encounter errors.
set +e

# We're starting with a pull request.
PR_NUMBER=${{ github.event.number }}
# Get the most recent commit on this pull request.
MOST_RECENT_SHA=$(curl -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/${PR_NUMBER}/commits | jq .[-1].sha)
MOST_RECENT_SHA_DIGEST=$(echo $MOST_RECENT_SHA | cut -c -7) 

# start out assuming no plan changes are present
PLAN_CHANGES=0
# get a list of all the check suites associated with this commit
CHECK_SUITES=$(curl -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com/repos/${GITHUB_REPOSITORY}/commits/${MOST_RECENT_SHA_DIGEST}/check-suites | jq .check_suites[].id)
CHECK_SUITES_ARRAY=( $CHECK_SUITES )
# For each check suite, get the number of runs in that check suite
for check_suite in "${CHECK_SUITES_ARRAY[@]}"; do
  echo "check_suite: $check_suite"
  CHECK_SUITE_INFO=$(curl -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com/repos/${GITHUB_REPOSITORY}/check-suites/${check_suite}/check-runs)
  NUMBER_OF_RUNS=$( echo $CHECK_SUITE_INFO | jq '.check_runs | length')
  # Check each run in the check suite for ${{ inputs.check-name }}ivity
  if [ "$NUMBER_OF_RUNS" -gt "0" ]; then
    # grep for ${{ inputs.check-name }} in the run names
    LAST_RUN_INDEX=$(($NUMBER_OF_RUNS-1))
    for run_index in $(seq 0 $LAST_RUN_INDEX); do
      echo $CHECK_SUITE_INFO | jq .check_runs[${run_index}].name
      echo $CHECK_SUITE_INFO | jq .check_runs[${run_index}].name | grep -q "${{ inputs.check-name }}"
      # if "${{ inputs.check-name }}" is found in the run name, check this run's title for "${{ inputs.check-description }}"
      if [[ "$?" -eq "0" ]]; then
        echo "  Spacelift check"
        echo $CHECK_SUITE_INFO | jq .check_runs[${run_index}].output.title | grep -q "${{ inputs.check-description }}"
        # if the desired phrase isn't found, set PLAN_CHANGES=1 and exit all the nested loops
        no_changes_yn=$?
        if [[ "$no_changes_yn" -ne "0" ]]; then
          echo "    changes found - exiting!"
          PLAN_CHANGES=1
          break 2
        else
          echo "    no changes"
        fi
      else
        echo "  not a ${{ inputs.check-name }} check, moving on"
      fi
    done
  fi
done

# Now that we've determined the desired value of PLAN_CHANGES, let's export it for use in labeling the pull request.
echo "Plan changes: $PLAN_CHANGES"
echo "::set-output name=changes::${PLAN_CHANGES}"
