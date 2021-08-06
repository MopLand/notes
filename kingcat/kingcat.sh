#!/bin/sh
docker build -t kingcat . --build-arg CACHEBUST=$(date +%s)
# docker tag kingcat:v1 mopland/kingcat
# docker pull mopland/kingcat
systemctl restart docker
docker run -it -d -p 8888:80 kingcat