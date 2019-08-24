#!/bin/bash

set -x

git config user.name "$(git --no-pager log --format=format:'%an' -n 1)"
git config user.email "$(git --no-pager log --format=format:'%ae' -n 1)"
git remote set-url origin "https://${GITHUB_ACTOR}:${{secrets.GITHUB_TOKEN}}@github.com/${GITHUB_REPOSITORY}.git"
git remote -v
git status
git diff --exit-code || ( git add . && git commit -m "Updated README" && git push origin HEAD:${GITHUB_HEAD_REF} )
