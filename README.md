# DataScientist 를 위한 Jupyter Docker

Data Science 에 자주 사용되는 Jupyter 와 Spark, CPU/GPU DeepLearning 및 주요 Library 를 Docker Image 로 제공합니다.

현재 지원 기능
* Jupyter
  * Jupyter Kernel: Python2/3, Scala, R, Julia, Go
  * Jupyter Kernel Gateway
  * Machine Learning
    * Python2/3 Lib: tensorflow CPU/GPU, pytorch CPU/GPU, keras, pandas, scikit-learn, .. etc
* Apache Spark

사전 요구사항
* Docker
* Nvidia-Docker (for GPU)

## 설치

OS: Ubuntu 16.04 LTS

### Git Clone

```
> git clone https://github.com/comafire/docker-jupyter.git
```

### Install Docker

Docker 는 이미 설치되어 있다고 가정합니다.

Docker 설치가 필요하시면 Docker 공식 설치 문서를 참조하세요.

https://docs.docker.com/engine/installation/linux/ubuntu/

https://docs.docker.com/engine/installation/linux/linux-postinstall/

### for Nvidia GPU

Nvidia GPU 가 장착된 머신이라면 아래 Nvidia GPU Driver 와 Nvidia-Docker 설치를 통해서 GPU DeepLarning 라이브러리를 사용하실 수 있습니다.

#### Install Nvidia GPU Driver

Cuda 및 툴킷 라이브러니는 Nvidia-Docker 를 사용할 것이기에 Driver 만 설치하면 됩니다.

설치 방법은 아래 링크를 참조하세요.

http://tipsonubuntu.com/2017/05/09/install-nvidia-375-66-ubuntu-16-04-14-04-17-04/

#### Install Nvidia-Docker

Docker 상에서 Nvidia GPU 를 이용하기 위해 Nvidia-Docker 를 사용합니다.

설치 방법은 아래 공식 설치 문서를 참조하세요.

https://github.com/NVIDIA/nvidia-docker

### Build Docker Image

CPU용 Docker Image 는 따로 빌드하지 않으셔도 Docker Hub 를 통해 제공됩니다.

GPU용 Docker Image 또는 직접 빌드를 원하실 경우 ./docker_build.sh 명령을 이용하세요.

Dockerfile 을 제공하므로 커스텀 이미지 빌드도 가능합니다.

### Setup

env.sh.template 파일을 env.sh 로 복사하여 설정 변경이 가능합니다.

```
#!/bin/bash

export LOCALE="ko_KR.UTF-8"

# Jupyter
export JUPYTER_NAME="jupyter"
export JUPYTER_PORT="8010" # Your Jupyter Port
export JUPYTER_VOLUME=$(pwd)
export JUPYTER_PASSWORD="notebooks" # Your Jupyter Password
export JUPYTER_BASEURL="jupyter" # Your Jupyter BaseURL, ex) http://localhost:8010/jupyter
export JUPYTER_RESTAPIPORT="8020" # Your Jupyter Kernel Gateway Port
export JUPYTER_IMAGE="comafire/docker-jupyter"
export JUPYTER_TAG="latest"
export JUPYTER_GPU_IMAGE="comafire/docker-jupyter-gpu"
export JUPYTER_GPU_TAG="latest"
export JUPYTER_GPU="FALSE" # if you have Nvidia GPU, set TRUE
```

### Run

./docker_run_jupyter.sh 명령으로 Jupyter Docker 이미지를 실행할 수 있습니다.

```
> ./docker_run_jupyter.sh
> docker ps
CONTAINER ID        IMAGE                                COMMAND              CREATED             STATUS              PORTS                                            NAMES
c63e1132d207        comafire/docker-jupyter:latest       "./run_jupyter.sh"   2 seconds ago       Up 1 second         0.0.0.0:8020->8088/tcp, 0.0.0.0:8010->8888/tcp   jupyter
```

### Install Extra Library

#### Python

Jupyter 사용중 추가 외부 라이브러리가 필요하시면 Jupyter 상에서 Terminal 창을 띄우신 후에 pip2, pip3 명령을 사용하시면 됩니다.

Docker 실행시 자동 설치를 원하시면 requirements.txt 파일에 패키지를 추가하시면 됩니다.
