#!/bin/sh

targetPHID=${1}

echo $targetPHID

#----

x5="{\"buildTargetPHID\": \"${targetPHID}\", \"type\": \"fail\", \"unit\":[{\"name\": \"FailingTest\", \"result\": \"fail\"}]}"

echo $x5 | arc call-conduit --conduit-uri=https://phabricator.onutechnology.com/api/ harbormaster.sendmessage

exit 1
