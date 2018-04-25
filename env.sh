#!/bin/bash

NAME="jupyter" # Container Name
PORT="8010" # Jupyter Port
VOLUME=$(pwd) # Jupyter Volume Path
PASSWORD="notebooks" # Jupyter Password

BASEURL="jupyter" # Jupyter BaseURL, ex) http://localhost:8010/jupyter
DOCKER="docker" # Docker Command
IMAGE="comafire/docker-jupyter" # Docker Image Name
TAG="latest" # Docker Image Tag

RESTAPIPORT="8020" # Jupyter Kernel Gateway Port
