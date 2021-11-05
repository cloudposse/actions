# I'm expecting some greps to fail, so we want to continue running whenever we encounter errors.
set +e

# We're starting with a pull request and we want to determine whether it already has the label of interest.
PR_LABELED=0
PR_NUMBER=${GITHUB_EVENT_NUMBER}
# Get the number of labels.
PR_INFO=$(curl -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/${PR_NUMBER})
echo "pr_info: $PR_INFO"
NUMBER_OF_LABELS=$( $PR_INFO | jq '.labels | length' )
echo $NUMBER_OF_LABELS
# Check each label in the PR to see if it's the label of interest.
if [ "$NUMBER_OF_LABELS" -gt "0" ]; then
  # show all labels, for debugging purposes
  echo $PR_INFO | jq '.labels'
  # grep for ${INPUTS_LABEL} in the labels list
  LAST_LABEL_INDEX=$(($NUMBER_OF_LABELS-1))
  echo $LAST_LABEL_INDEX
  for label_index in $(seq 0 $LAST_LABEL_INDEX); do
    echo $label_index
    echo $PR_INFO | jq .labels[${label_index}].name
    echo $PR_INFO | jq .labels[${label_index}].name | grep -q "${INPUTS_LABEL}"
    label_yn=$?
    # if label of interest is found in the labels list, set PR_LABELED=1 and break the loop
    if [[ "$label_yn" -eq "0" ]]; then
        echo "Label found."
        PR_LABELED=1
        break
    fi
  done
fi

# Now that we've determined whether the PR is already labeled, let's export that information
echo "PR_LABELED: $PR_LABELED"
echo "::set-output name=no_changes::${PR_LABELED}"
