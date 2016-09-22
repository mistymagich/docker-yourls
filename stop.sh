#!/bin/bash -eux

CONTAINERID=`docker ps -a|grep yourls|awk '{print $1}'`

docker stop ${CONTAINERID}
docker rm ${CONTAINERID}
