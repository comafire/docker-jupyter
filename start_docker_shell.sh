#!/bin/sh

NAME="jupyter-shell"
IMAGE="comafire/docker-jupyter"
TAG="dev"

docker rm -f $NAME
docker run -i -t --name $NAME $IMAGE:$TAG /bin/bash
