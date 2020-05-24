#!/bin/bash

revision=$1

git clean -f -d -x
git fetch --all --tags --prune
git checkout "phabricator/diff/${revision}" -b $revision
