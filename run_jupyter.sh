#!/bin/sh

SPARKENV_PATH="/home/$USERNAME/docker-jupyter/spark-env.sh"
REQUIREMENTS_PATH="/home/$USERNAME/docker-jupyter/requirements.txt"
JUPYTERCONF_PATH="/home/$USERNAME/docker-jupyter/jupyter_notebook_config.py"
JUPYTERLOG_PATH="/home/$USERNAME/docker-jupyter/logs/jupyter.log"

#Spark Env
cp $SPARKENV_PATH /usr/local/spark/conf/spark-env.sh

pip3 install -r $REQUIREMENTS_PATH

jupyter lab --config $JUPYTERCONF_PATH
