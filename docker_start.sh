#!/bin/bash

docker build -t git_web_server .

docker run -d -p 443:443 -p 22:22 git_web_server
