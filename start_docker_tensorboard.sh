#!/bin/bash

NAME="tensorboard"
PORT="7007"
VOLUME=$(pwd)
IMAGE="comafire/docker-jupyter"
TAG="dev"

docker rm -f tensorboard 
docker run -i -t --name tensorboard -d --restart=always -p $PORT:6006 -v $VOLUME:/root/volume $IMAGE:$TAG tensorboard --logdir /root/volume/logs
