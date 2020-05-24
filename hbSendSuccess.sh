#!/bin/sh

targetPHID=${1}

echo $targetPHID

#----

x5="{\"buildTargetPHID\": \"${targetPHID}\", \"type\": \"pass\", \"unit\":[{\"name\": \"PassingTest\", \"result\": \"pass\"}]}"

echo $x5 | arc call-conduit --conduit-uri=https://phabricator.onutechnology.com/api/ harbormaster.sendmessage
