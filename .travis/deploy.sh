#!/bin/bash

set -e

git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"

eval $(printf 'PROJECT_ARTIFACT_ID=${project.artifactId}\n0\n' | mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate | grep '^PROJECT_ARTIFACT_ID')

eval $(printf 'PROJECT_VERSION=${project.version}\n0\n' | mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate | grep '^PROJECT_VERSION' | sed -e 's/-SNAPSHOT//g')

echo "Package and version to deploy ${PROJECT_ARTIFACT_ID}:${PROJECT_VERSION}"

SUBJECT=xpressolab
REPO=m2repo

# Creates the new "package" on bintray
echo "Create new package on ${SUBJECT}/${REPO}"
curl -s POST \
  https://api.bintray.com/packages/$SUBJECT/$REPO \
  -H 'authorization: Basic ZmVsaXBlbXNhbnRvczpmZjdlZWM5NmQ2NDVmYzQ0NTExZjk3NjcxZjY1OWI4YTA4NzE1NjQx' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d @<(cat <<EOF
{
    "name": "$PROJECT_ARTIFACT_ID",
    "desc": "",
    "labels": ["xpressolab"],
    "licenses": ["Apache-2.0"],
    "vcs_url": "https://github.com/$SUBJECT/$PROJECT_ARTIFACT_ID.git",
    "website_url": "https://github.com/$SUBJECT/$PROJECT_ARTIFACT_ID.git",
    "issue_tracker_url": "https://github.com/$SUBJECT/$PROJECT_ARTIFACT_ID/issues",
    "github_repo": "$SUBJECT/$PROJECT_ARTIFACT_ID",
    "github_release_notes_file": "README.md"
}
EOF
)

# Creates the new version for the new "package" on bintray
echo "Create new version on ${SUBJECT}/${REPO}/${PROJECT_ARTIFACT_ID}/${PROJECT_VERSION}"
curl -s POST \
  https://api.bintray.com/packages/$SUBJECT/m2repo/$PROJECT_ARTIFACT_ID/versions \
  -H 'authorization: Basic ZmVsaXBlbXNhbnRvczpmZjdlZWM5NmQ2NDVmYzQ0NTExZjk3NjcxZjY1OWI4YTA4NzE1NjQx' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d @<(cat <<EOF
{
  "name": "$PROJECT_VERSION",
  "desc": ""
}
EOF
)


mvn --settings .travis/settings.xml -B -V -Prelease release:prepare -DskipTests -Darguments="-DskipTests"
mvn --settings .travis/settings.xml -B -V -Prelease release:perform -DskipTests -Darguments="-DskipTests"
