#!/bin/bash

set -e

#git config --global user.name "$COMMIT_AUTHOR_NAME" && git config --global user.name
#git config --global user.email "$COMMIT_AUTHOR_EMAIL" && git config --global user.email

eval $(printf 'PROJECT_ARTIFACT_ID=${project.artifactId}\n0\n' | mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate | grep '^PROJECT_ARTIFACT_ID')
eval $(printf 'PROJECT_VERSION=${project.version}\n0\n' | mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate | grep '^PROJECT_VERSION' | sed -e 's/-SNAPSHOT//g')

SUBJECT=xpressolab
REPO=m2repo

# Creates the new "package" on bintray
curl -X POST \
  https://api.bintray.com/packages/$SUBJECT/$REPO \
  -H 'authorization: Basic ZmVsaXBlbXNhbnRvczpmZjdlZWM5NmQ2NDVmYzQ0NTExZjk3NjcxZjY1OWI4YTA4NzE1NjQx' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
  "name": "'$PROJECT_ARTIFACT_ID'",
  "desc": "",
  "labels": [""],
  "licenses": ["Apache-2.0"],
  "vcs_url": "https://github.com/'$SUBJECT'/'$PROJECT_ARTIFACT_ID.git'",
  "website_url": "https://github.com/'$SUBJECT'/'$PROJECT_ARTIFACT_ID.git'",
  "issue_tracker_url": "https://github.com/"'$SUBJECT/$PROJECT_ARTIFACT_ID'"/issues",
  "github_repo": "$SUBJECT/$PROJECT_ARTIFACT_ID",
  "github_release_notes_file": "README.md"
}'

# Creates the new version for the new "package" on bintray
curl -X POST \
  https://api.bintray.com/packages/$SUBJECT/m2repo/$PROJECT_ARTIFACT_ID/versions \
  -H 'authorization: Basic ZmVsaXBlbXNhbnRvczpmZjdlZWM5NmQ2NDVmYzQ0NTExZjk3NjcxZjY1OWI4YTA4NzE1NjQx' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
  "name": "'$PROJECT_VERSION'",
  "desc": ""
}'
