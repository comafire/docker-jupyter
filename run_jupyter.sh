#!/bin/sh

pip2 install -r /root/volume/requirements.txt >> ./logs/jupyter.log 2>&1
pip3 install -r /root/volume/requirements.txt >> ./logs/jupyter.log 2>&1 

cp /root/volume/jupyter_notebook_config.py /root/.jupyter/ >> ./logs/jupyter.log 2>&1
jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user
jupyter nbextension enable toc2/main
jupyter notebook --allow-root >> ./logs/jupyter.log 2>&1
#jupyter lab > ./logs/jupyter.log 2>&1
