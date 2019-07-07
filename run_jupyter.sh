#!/bin/sh

SPARKENV_PATH="/root/volume/spark-env.sh"
REQUIREMENTS_PATH="/root/volume/requirements.txt"
JUPYTERLOG_PATH="/root/volume/logs/jupyter.log"

#Spark Env
cp $SPARKENV_PATH /usr/local/spark/conf/spark-env.sh

pip2 install -r $REQUIREMENTS_PATH
pip3 install -r $REQUIREMENTS_PATH

mkdir /root/.jupyter
cp /root/volume/jupyter_notebook_config.py /root/.jupyter/
jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user
jupyter nbextension enable tree-filter/index
jupyter nbextension enable toggle_all_line_numbers/main
jupyter nbextension enable toc2/main
#jupyter nbextension enable code_prettify/code_prettify
jupyter nbextension enable codefolding/edit
#jupyter notebook --allow-root


jupyter lab --allow-root
