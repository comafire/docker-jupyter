#!/bin/bash

source ./env.sh
IMAGE="comafire/docker-jupyter"
TAG="latest"

docker build --tag $IMAGE:$TAG .
