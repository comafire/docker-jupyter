FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
MAINTAINER comafire <comafire@gmail.com>

# Bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

USER root

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
apt-utils \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Lang
ARG locale="ko_KR.UTF-8"
ENV LOCALE ${locale}
RUN echo "LOCALE: $LOCALE"
RUN if [[ $LOCALE = *ko* ]] \
; then \
apt-get update && apt-get install -y --no-install-recommends \
locales language-pack-ko \
; else \
apt-get update && apt-get install -y --no-install-recommends \
locales language-pack-en \
; fi
RUN echo "$LOCALE UTF-8" > /etc/locale.gen && locale-gen
ENV LC_ALL ${LOCALE}
ENV LANG ${LOCALE}
ENV LANGUAGE ${LOCALE}
ENV LC_MESSAGES POSIX

# Common
RUN apt-get update && apt-get install -y --no-install-recommends \
build-essential vim curl wget git git-flow cmake bzip2 sudo unzip net-tools \
libffi-dev libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm \
libfreetype6-dev libxft-dev
RUN apt-get update && apt-get install -y --no-install-recommends \
software-properties-common libjpeg-dev libpng-dev ncurses-dev imagemagick \
libgraphicsmagick1-dev libzmq3-dev gfortran gnuplot gnuplot-x11 libsdl2-dev \
openssh-client htop iputils-ping

# Docker
RUN apt-get update && apt-get install -y --no-install-recommends \
apt-transport-https ca-certificates
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y --no-install-recommends \
docker-ce

# Python3
RUN apt-get update && apt-get install -y --no-install-recommends \
python3 python3-dev python3-pip python3-virtualenv python3-software-properties python3-gdbm
RUN pip3 install --upgrade pip
RUN pip3 install --cache-dir /tmp/pip3 --upgrade setuptools wheel

# Java
RUN apt-get update && apt-get install -y --no-install-recommends \
openjdk-8-jdk maven

# Scala
ENV SCALA_VERSION 2.12.0
ENV SCALA_HOME /usr/local/scala-${SCALA_VERSION}

ENV PATH $PATH:$SCALA_HOME/bin
RUN curl -sL --retry 3 --insecure \
"https://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz" \
| gunzip | tar x -C /usr/local/ \
&& ln -s $SCALA_HOME /usr/local/scala

# Julia
ENV JULIA_VERSION 1.1.1

RUN apt-get update && apt-get install -y build-essential libatomic1 python gfortran perl wget m4 cmake pkg-config
RUN cd /usr/local && git clone git://github.com/JuliaLang/julia.git && cd julia && git checkout v${JULIA_VERSION}
RUN cd /usr/local/julia && make -j 4
RUN sudo ln -s /usr/local/julia/usr/bin/julia /usr/local/bin/julia
RUN /usr/local/julia/usr/bin/julia -v
RUN ls -al /usr/local/bin
RUN julia -v
RUN julia -e 'using Pkg;Pkg.update()'

# R
RUN apt-get update && apt-get --allow-unauthenticated install -y --no-install-recommends \
r-base r-base-dev

# Database
RUN apt-get update && apt-get install -y --no-install-recommends \
libmysqlclient-dev libpq-dev postgresql-client python-mysqldb

# FUSE
RUN apt-get update && apt-get install -y --no-install-recommends \
automake autotools-dev g++ git libcurl4-gnutls-dev libssl-dev libxml2-dev make pkg-config \
fuse libfuse-dev

# FUSE-SSHFS
RUN apt-get update && apt-get install -y --no-install-recommends \
sshfs

# FUSE-S3
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git;cd s3fs-fuse;./autogen.sh;./configure;make;make install

# FUSE-BLOB
RUN wget https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get update && apt-get install -y --no-install-recommends \
blobfuse

# Nginx
RUN apt-get update && apt-get install -y --no-install-recommends \
nginx

# SPARK
ENV SPARK_VERSION 2.4.3
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-hadoop2.7
ENV SPARK_HOME /usr/local/spark-${SPARK_VERSION}
ENV PYSPARK_PYTHON /usr/bin/python3
ENV PYSPARK_DRIVER_PYTHON /usr/bin/python3
ENV PY4J_VERSION 0.10.7

ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -sL --retry 3 \
"http://www-us.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" \
| gunzip | tar x -C /usr/local \
&& mv /usr/local/$SPARK_PACKAGE $SPARK_HOME \
&& ln -s $SPARK_HOME /usr/local/spark \
&& chown -R root:root $SPARK_HOME
ENV PYTHONPATH $SPARK_HOME/python/:$PYTHONPATH
ENV PYTHONPATH $SPARK_HOME/python/lib/py4j-$PY4J_VERSION-src.zip:$PYTHONPATH

RUN pip3 install --cache-dir /tmp/pip3 --timeout 600 py4j==$PY4J_VERSION

# for Airflow (don't use GPL dependency library)
ENV SLUGIFY_USES_TEXT_UNIDECODE yes

# Python3 Deps
RUN pip3 install --cache-dir /tmp/pip3 --timeout 600 docker fabric pytest pycrypto
RUN pip3 install --cache-dir /tmp/pip3 --timeout 600 numpy>=1.11.2
RUN pip3 install --cache-dir /tmp/pip3 --timeout 600 scipy scikit-learn scikit-surprise xgboost statsmodels
RUN pip3 install --cache-dir /tmp/pip3 --timeout 600 pandas pandas_ml pandas-datareader quandl h5py pyarrow imbalanced-learn
RUN pip3 install --cache-dir /tmp/pip3 --timeout 600 matplotlib seaborn
RUN pip3 install --cache-dir /tmp/pip3 --timeout 600 awscli nbformat boto3 xlrd
RUN pip3 install --cache-dir /tmp/pip3 --timeout 600 mysqlclient mysql-connector-python-rf pymysql psycopg2 sqlalchemy
RUN pip3 install --cache-dir /tmp/pip3 --timeout 600 flask flask-restful flask-jwt-extended flask_bcrypt flask-sqlalchemy flask-testing
RUN pip3 install --cache-dir /tmp/pip3 --timeout 600 nose passlib pybase62 uuid0 imageio
RUN pip3 install --cache-dir /tmp/pip3 --timeout 600 ghp-import2 nikola[extras]

# DeepLearning
ARG gpu="FALSE"
ENV GPU ${gpu}
ENV TENSORFLOW_VER 1.14.0
ENV PYTORCH_VER 1.1.0
ENV PYTORCH_VISION_VER 0.3.0
RUN echo "GPU: $GPU"
RUN if [[ $GPU = *TRUE* ]] \
; then \
# For Tensorflow GPU
apt-get update && apt-get install -y --no-install-recommends \
libcupti-dev nvidia-modprobe \
&& pip3 install --cache-dir /tmp/pip3 --timeout 600 tensorflow-gpu==$TENSORFLOW_VER keras \
https://download.pytorch.org/whl/cu100/torch-$PYTORCH_VER-cp35-cp35m-linux_x86_64.whl \
https://download.pytorch.org/whl/cu100/torchvision-$PYTORCH_VISION_VER-cp35-cp35m-linux_x86_64.whl \
; else \
pip3 install --cache-dir /tmp/pip3 --timeout 600 tensorflow==$TENSORFLOW_VER keras \
torch \
torchvision \
; fi

# Airflow
RUN pip3 install --cache-dir /tmp/pip3 --timeout 600 bleach>=2.1.2
RUN pip3 install --cache-dir /tmp/pip3 --timeout 600 apache-airflow apache-airflow[s3,postgres,mysql,crypto,password]

# Jupyter Deps
RUN apt-get update && apt-get install -y --no-install-recommends \
texlive-xetex

# Jupyter
RUN pip3 install -v --no-cache-dir --timeout 600 jupyterlab

# Jupyter Python3 kernel
RUN python3 -m pip install ipykernel
RUN python3 -m ipykernel install --user

# Jupyter Scala
RUN python3 -m pip install spylon-kernel
RUN python3 -m spylon_kernel install --user

# Jupyter Julia Kernel
RUN julia -e 'import Pkg;Pkg.update()' && \
julia -e 'import Pkg;Pkg.add("Gadfly")' && \
julia -e 'import Pkg;Pkg.add("RDatasets")' && \
julia -e 'import Pkg;Pkg.add("IJulia")' && \
# Precompile Julia packages
julia -e 'using IJulia'

# Jupyter R kernel
RUN apt-get update && apt-get install -y --no-install-recommends \
libcurl4-gnutls-dev libxml2-dev libssl-dev
RUN R -e "install.packages(c('curl', 'repr', 'httr'), repos='http://cran.rstudio.com/')"
RUN R -e "install.packages(c('pbdZMQ', 'devtools', 'IRdisplay', 'evaluate', 'crayon', 'uuid', 'digest'), repos='http://cran.rstudio.com/')"
RUN R -e "install.packages(c('SparkR'), repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('IRkernel/IRkernel')"
RUN R -e "IRkernel::installspec()"

# for Airflow
ENV AIRFLOW_HOME /root/volume/var/airflow

# Env
VOLUME /root/volume
WORKDIR /root

# for Spark
EXPOSE 4040 6066 7077 8080
# for Jupyter
EXPOSE 8888 8088
# for Flask
EXPOSE 5000
# for NGINX
EXPOSE 80
