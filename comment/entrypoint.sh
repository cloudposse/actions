#!/bin/bash

set -x
export GITHUB_COMMENT="${GITHUB_COMMENT:-}"

jq -r ".comment.body" "$GITHUB_EVENT_PATH" | grep -E "${GITHUB_COMMENT}"

if [ $? -ne 0 ]; then
	echo "Comment '${GITHUB_COMMENT}' not matched"
	exit 78
fi

if [[ "$(jq -r ".action" "$GITHUB_EVENT_PATH")" != "created" ]]; then
	echo "This is not a new comment event."
	exit 78
fi

exit 0
