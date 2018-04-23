# DataScientist 를 위한 Jupyter Docker  for CPU
데이터과학자를 위한 Jupyter 도커

현재 지원 기능 
* Jupyter
* Jupyter Kernel Gateway
* Python 2, 3
 * Spark
 * Tensorflow, Keras, PyTorch, numpy, pandas, scipy, scikit-learn, etc
* Scala
 * Spark
* R
 * Spark
* Julia
 * Spark
* Go

사전 요구사항
* Docker

## 설치

OS: Ubuntu 16.04 LTS

### Git Clone

```
> git clone https://github.com/comafire/docker-jupyter.git
```

### Docker Install

Docker 는 이미 설치되어 있다고 가정합니다.

Docker 설치가 필요하시면 Docker 공식 설치 문서를 참조하세요.

https://docs.docker.com/engine/installation/linux/ubuntu/

https://docs.docker.com/engine/installation/linux/linux-postinstall/

### Build Docker Image

Docker Image 는 따로 빌드하지 않으셔도 Docker Hub 를 통해 제공됩니다.

직접 빌드를 원하실 경우 ./docker_build.sh 명령을 이용하세요.

Dockerfile 을 제공하므로 커스텀 이미지 빌드도 가능합니다.

### Setup

config.sh 파일을 수정하여 Password 및 Jupyter Port 를 변경할 수 있습니다.

```
NAME="jupyter" # Container Name
PORT="8010" # Jupyter Port
VOLUME=$(pwd) # Jupyter Volume Path
PASSWORD="notebooks" # Jupyter Password

BASEURL="jupyter" # Jupyter BaseURL, ex) http://localhost:8010/jupyter
DOCKER="docker" # Docker Command
IMAGE="comafire/docker-jupyter" # Docker Image Name
TAG="latest" # Docker Image Tag

RESTAPIPORT="8020" # Jupyter Kernel Gateway Port
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

