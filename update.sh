#!/bin/bash

docker version &> /dev/null
if [ $? -eq 1 ]; then
  echo "Docker is not running, please launch Docker before."
  exit 1
fi

image_name=steamcmd_$(date +%s)

docker build -t $image_name .
steam_version=$(docker run $image_name cat package/steam_cmd_linux.manifest | grep 'version' | sed -n 's/.*"\(.*\)"$/\1/p')

docker rmi -f $image_name

git tag $steam_version
git push origin $steam_version
