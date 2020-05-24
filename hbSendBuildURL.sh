#!/bin/sh

targetPHID=${1}
buildbotURI=${2}

#----

myjson="{\"buildTargetPHID\": \"${targetPHID}\", \"artifactKey\": \"buildbot.uri\", \"artifactType\": \"uri\", \"artifactData\":{\"uri\": \"${buildbotURI}\", \"name\":\"Buildbot build lies yonder\", \"ui.external\": true}}"

echo $myjson | arc call-conduit --conduit-uri=https://phabricator.onutechnology.com/api/ harbormaster.createartifact
