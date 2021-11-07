# I'm expecting some greps to fail, so we want to continue running whenever we encounter errors.
set +e

# We already know that the pull request has our label of interest when it shouldn't. We'll rectify that.
echo "Removing PR label."
PR_NUMBER=${GITHUB_EVENT_NUMBER}

echo "pr_number: $PR_NUMBER"
echo "github_repository: $GITHUB_REPOSITORY"
echo "label: $LABEL"

RESPONSE=$(curl -s \
  -X DELETE \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  https://api.github.com/repos/${GITHUB_REPOSITORY}/issues/${PR_NUMBER}/labels/${LABEL})
echo "response: $RESPONSE"
