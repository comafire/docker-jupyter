#!/bin/sh
export JUPYTER_PASSWORD="notebook"
jupyter nbextension enable toggle_all_line_numbers/main
jupyter nbextension enable codefolding/main
jupyter nbextension enable help_panel/help_panel
#jupyter nbextension enable tree-filter/index
jupyter notebook > ./logs/jupyter.log 2>&1
#jupyter lab > ./logs/jupyter.log 2>&1
