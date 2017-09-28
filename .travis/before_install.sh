#!/bin/bash

git config --global user.name "$COMMIT_AUTHOR_NAME"
git config --global user.email "$COMMIT_AUTHOR_EMAIL"

git config --global user.name
git config --global user.email

export COMMIT_MESSAGE=`git log -1 --oneline`