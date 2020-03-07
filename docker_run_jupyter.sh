#!/bin/bash

source ./env.sh

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

$DOCKER rm -f $JUPYTER_NAME
$DOCKER run -i -t -d --name $JUPYTER_NAME \
--hostname $HOSTNAME \
--privileged --restart=always \
-p $JUPYTER_PORT:8888 -p $JUPYTER_RESTAPIPORT:8088 \
-v $JUPYTER_MNT:/home/$USERNAME/mnt \
-v $JUPYTER_HOME:/home/$USERNAME/docker-jupyter \
-e USERNAME=$USERNAME \
-e JUPYTER_BASEURL=$JUPYTER_BASEURL -e JUPYTER_PASSWORD=$JUPYTER_PASSWORD \
$IMAGE:$TAG /home/$USERNAME/docker-jupyter/run_jupyter.sh


