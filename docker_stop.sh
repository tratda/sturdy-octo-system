#!/bin/bash

conID=$(docker container ls | grep "git_web_server" | cut -d ' ' -f 1)
echo "Stopping container $conID"
docker container stop $conID

echo "Stopped container $conID"

