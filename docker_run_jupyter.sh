#!/bin/bash

source ./config.sh

LOGS="./logs"
if [ -d $LOGS ]
then 
  rm -rf $LOGS
fi

mkdir $LOGS 
touch $LOGS/jupyter.log 

$DOCKER rm -f $NAME 
#$DOCKER run -i -t --name $NAME -p $PORT:8888 -v $VOLUME:/root/volume -e JUPYTER_PASSWORD=$PASSWORD $IMAGE:$TAG
$DOCKER run -i -t --name $NAME -d --restart=always -p $PORT:8888 -p $RESTAPIPORT:8088 -v $VOLUME:/root/volume -e JUPYTER_BASEURL=$BASEURL -e JUPYTER_PASSWORD=$PASSWORD $IMAGE:$TAG

