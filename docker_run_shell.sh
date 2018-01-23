#!/bin/bash

source ./config.sh

NAME="jupyter-shell"

LOGS="./logs"
if [ -d $LOGS ]
then 
  rm -rf $LOGS
fi

mkdir $LOGS 
touch $LOGS/jupyter.log 

$DOCKER rm -f $NAME
$DOCKER run -i -t --name $NAME -v $VOLUME:/root/volume $IMAGE:$TAG /bin/bash

