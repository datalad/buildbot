#!/bin/bash

docker ps --no-trunc | grep datalad | sed -e 's,datalad_.*buildbot:slave-,,g' | awk '{print $1, $2;}' | while read i n; do echo $i >| ids/$n.id; done
