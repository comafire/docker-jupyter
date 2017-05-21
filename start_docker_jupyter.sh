#!/bin/bash

NAME="jupyter"
PORT="7777"
VOLUME=$(pwd)
PASSWORD="notebook"
IMAGE="comafire/docker-jupyter"
TAG="dev"

docker rm -f jupyter
#docker run -i -t --name $NAME -p $PORT:8888 -v $VOLUME:/root/volume -e JUPYTER_PASSWORD=$PASSWORD $IMAGE:$TAG
docker run -i -t --name $NAME -d --restart=always -p $PORT:8888 -v $VOLUME:/root/volume -e JUPYTER_PASSWORD=$PASSWORD $IMAGE:$TAG


