#!/bin/sh

pip2 install -r /root/volume/requirements.txt >> ./logs/jupyter.log 2>&1
pip3 install -r /root/volume/requirements.txt >> ./logs/jupyter.log 2>&1 

cp /root/volume/jupyter_notebook_config.py /root/.jupyter/ >> ./logs/jupyter.log 2>&1
#jupyter nbextension enable toc2/main >> ./logs/jupyter.log 2>&1
#jupyter nbextension enable toggle_all_line_numbers/main >> ./logs/jupyter.log 2>&1
#jupyter nbextension enable codefolding/main >> ./logs/jupyter.log 2>&1
#jupyter nbextension enable help_panel/help_panel >> ./logs/jupyter.log 2>&1
#jupyter nbextension enable tree-filter/index
jupyter notebook --allow-root >> ./logs/jupyter.log 2>&1
#jupyter lab > ./logs/jupyter.log 2>&1
