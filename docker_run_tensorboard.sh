#!/bin/bash

NAME="tensorboard"
PORT="7007"
VOLUME=$(pwd)
IMAGE="comafire/docker-jupyter"
TAG="latest"

docker rm -f $NAME
docker run -i -t --name $NAME -d --restart=always -p $PORT:6006 -v $VOLUME:/root/volume $IMAGE:$TAG tensorboard --logdir /root/volume/logs
