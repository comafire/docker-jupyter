#!/bin/sh

pip2 install -r /root/volume/requirements.txt >> ./logs/jupyter.log 2>&1
pip3 install -r /root/volume/requirements.txt >> ./logs/jupyter.log 2>&1

mkdir /root/.jupyter >> ./logs/jupyter.log 2>&1
cp /root/volume/jupyter_notebook_config.py /root/.jupyter/ >> ./logs/jupyter.log 2>&1
jupyter contrib nbextension install --user >> ./logs/jupyter.log 2>&1
jupyter nbextensions_configurator enable --user >> ./logs/jupyter.log 2>&1
jupyter nbextension enable tree-filter/index >> ./logs/jupyter.log 2>&1
jupyter nbextension enable toggle_all_line_numbers/main >> ./logs/jupyter.log 2>&1
jupyter nbextension enable toc2/main >> ./logs/jupyter.log 2>&1
# support only python, r, javascript
#jupyter nbextension enable code_prettify/code_prettify >> ./logs/jupyter.log 2>&1
jupyter nbextension enable codefolding/edit >> ./logs/jupyter.log 2>&1
jupyter notebook --allow-root >> ./logs/jupyter.log 2>&1
#jupyter lab > ./logs/jupyter.log 2>&1
