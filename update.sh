#!/bin/bash


docker version &> /dev/null
if [ $? -eq 1 ]; then
  echo "Docker is not running, please launch Docker before."
  exit 1
fi

image_name=steamcmd_build_$(date +%s)

docker build -t $image_name .

steam_version=$(docker run $image_name cat package/steam_cmd_linux.manifest | grep 'version' | sed -n 's/.*"\(.*\)"$/\1/p')
echo "Steam version: $steam_version"

docker rmi -f $image_name

git rev-parse $steam_version >/dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "Tag $steam_version already exists."
  exit 1
fi

git tag $steam_version
git push origin $steam_version
