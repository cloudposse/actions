#!/bin/bash

set -x
export GIT_COMMIT_MESSAGE="${COMMIT_MESSAGE:-autocommit}"

git diff --exit-code 

if [ $? -ne 0 ]; then
  echo "Changes detected."
  git config user.name "$(git --no-pager log --format=format:'%an' -n 1)"
  git config user.email "$(git --no-pager log --format=format:'%ae' -n 1)"

  git remote set-url origin "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
  git remote -v
  git add .
  git commit -m "${GIT_COMMIT_MESSAGE}"
  git push origin HEAD:${GITHUB_HEAD_REF}
else
  echo "No changes detected."
fi
