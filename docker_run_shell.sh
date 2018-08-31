#!/bin/bash

source ./env.sh

NAME="jupyter-shell"

LOGS="./logs"
if [ -d $LOGS ]
then
  rm -rf $LOGS
fi

mkdir $LOGS
touch $LOGS/jupyter.log

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

$DOCKER rm -f $NAME
$DOCKER run -i -t --name $NAME -v $JUPYTER_VOLUME:/root/volume $IMAGE:$TAG /bin/bash
