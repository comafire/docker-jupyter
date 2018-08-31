#!/bin/bash

source ./env.sh

if [ "$JUPYTER_GPU" = "TRUE" ]
then
DOCKER="nvidia-docker"
IMAGE="$JUPYTER_GPU_IMAGE"
TAG="$JUPYTER_GPU_TAG"
else
DOCKER="docker"
IMAGE="$JUPYTER_IMAGE"
TAG="$JUPYTER_TAG"
fi

$DOCKER rm -f $JUPYTER_NAME
