#!/bin/sh

IMAGE="comafire/docker-jupyter"
TAG="dev"

docker build --tag $IMAGE:$TAG .
