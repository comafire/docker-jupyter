#!/bin/bash

source ./env.sh

if [ "$JUPYTER_GPU" = "TRUE" ]
then
  docker build --build-arg locale="$LOCALE" --build-arg username="$USERNAME" --build-arg userid="$USERID" --build-arg gpu="$JUPYTER_GPU" --tag $JUPYTER_GPU_IMAGE:$JUPYTER_GPU_TAG .
else
  docker build --build-arg locale="$LOCALE" --build-arg username="$USERNAME" --build-arg userid="$USERID" --tag $JUPYTER_IMAGE:$JUPYTER_TAG .
fi
