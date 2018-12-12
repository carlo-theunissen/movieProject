#!/bin/sh
docker stop  application
docker rm -f application
docker image prune -f
docker build -t application .
docker run -d -p 8090:80 --name application application
docker stop  application
docker start -a application