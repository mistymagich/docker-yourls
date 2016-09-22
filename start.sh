#!/bin/bash -eux

PWD=$(cd $(dirname $0); pwd)

docker run -d \
           -p 10080:80 \
           --name yourls \
           -e "YOURLS_DB_USER=yourls" \
           -e "YOURLS_DB_PASS=yourlspass" \
           -e "YOURLS_DB_NAME=yourls" \
           -e "YOURLS_DB_HOST=$(ip route|grep docker|awk '{print $9}')" \
           -e "YOURLS_SITE=http://example.jp:10080" \
           -e "YOURLS_USERNAME=yourlsadmin" \
           -e "YOURLS_PASSWORD=yourlspass" \
           yourls
