#!/bin/bash

docker build -t git_web_server .

docker run -d -p 443:433 -p 22:22 git_web_server
