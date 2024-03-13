#!/bin/bash

set -x
export GIT_COMMIT_MESSAGE="${GIT_COMMIT_MESSAGE:-autocommit}"
export GIT_DIRECTORY="${GIT_DIRECTORY:-$(pwd)}"
export GIT_BRANCH="${GIT_BRANCH:-$GITHUB_HEAD_REF}"

# Testing for either presence of untracked files or presence of modifications in tracked files.
if [[ "$(git ls-files --others --directory --exclude-standard | sed q | wc -l)" -ne 0 || "$(git ls-files --others --directory --exclude-standard | sed q | wc -l)" -ne 0 ]]; then
  echo "Changes detected."
  git -C ${GIT_DIRECTORY} status
  git -C ${GIT_DIRECTORY} config user.name "$(git -C ${GIT_DIRECTORY} --no-pager log --format=format:'%an' -n 1)"
  git -C ${GIT_DIRECTORY} config user.email "$(git -C ${GIT_DIRECTORY} --no-pager log --format=format:'%ae' -n 1)"

  git -C ${GIT_DIRECTORY} remote set-url origin "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
  git -C ${GIT_DIRECTORY} remote -v
  git -C ${GIT_DIRECTORY} add .
  git -C ${GIT_DIRECTORY} status
  git -C ${GIT_DIRECTORY} commit -m "${GIT_COMMIT_MESSAGE}"
  git -C ${GIT_DIRECTORY} status
  git -C ${GIT_DIRECTORY} push origin HEAD:${GIT_BRANCH}
else
  echo "No changes detected."
fi
