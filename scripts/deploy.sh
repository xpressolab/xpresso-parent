#!/bin/bash

git config --global user.name "$COMMIT_AUTHOR_NAME"
git config --global user.email "$COMMIT_AUTHOR_EMAIL"

mvn -Prelease -DskipTests=true -B -V release:prepare release:perform
