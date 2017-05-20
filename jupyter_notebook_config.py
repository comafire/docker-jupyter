# Configuration file for jupyter-notebook.

import os
from IPython.lib import passwd

c = get_config()
c.NotebookApp.ip = '*'
c.NotebookApp.port = int(os.getenv('JUPYTER_PORT', 8888))
c.NotebookApp.open_browser = False

# sets a password if JUPYTER_PASSWORD is set in the environment
if 'JUPYTER_PASSWORD' in os.environ:

  #c.NotebookApp.token = passwd(os.environ['JUPYTER_PASSWORD']) 
  c.NotebookApp.password = passwd(os.environ['JUPYTER_PASSWORD'])
  del os.environ['JUPYTER_PASSWORD']

print("jupyter config..")
print(c)
