#!/bin/bash

set -e

git config --global user.name "$COMMIT_AUTHOR_NAME"
git config --global user.email "$COMMIT_AUTHOR_EMAIL"

mvn --settings .travis/settings.xml -B -V -Prelease release:prepare -DskipTests -Darguments="-DskipTests"
mvn --settings .travis/settings.xml -B -V -Prelease release:perform -DskipTests -Darguments="-DskipTests"
