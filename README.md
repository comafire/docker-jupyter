# DataScientist 를 위한 Jupyter Docker

Data Science 에 자주 사용되는 Jupyter 와 Spark, CPU/GPU DeepLearning 및 주요 Library 를 Docker Image 로 제공합니다.

현재 지원 기능
* Jupyter
  * Jupyter Kernel: Python3, Scala, R, Julia
  * Machine Learning
    * Python3 Lib: tensorflow CPU/GPU, pytorch CPU/GPU, keras, pandas, scikit-learn, .. etc
* Apache Spark

시스템 요구사항

* Ubuntu 18.04 LTS
* Docker
* Nvidia-Docker (for GPU)

## Git Clone

```bash
> git clone https://github.com/comafire/docker-jupyter.git
```

## Install Docker

Docker 공식 설치 문서를 참조하여 설치하시면 됩니다.

https://docs.docker.com/engine/installation/linux/ubuntu/

https://docs.docker.com/engine/installation/linux/linux-postinstall/


## for Nvidia GPU

Nvidia GPU 가 장착된 머신이라면 아래 Nvidia GPU Driver 와 Nvidia-Docker 설치를 통해서 GPU DeepLarning 라이브러리를 사용하실 수 있습니다.

### Install Nvidia GPU Driver

Cuda 및 툴킷 라이브러니는 Nvidia-Docker 를 사용할 것이기에 Driver 만 설치하면 됩니다.

설치 방법은 아래 링크를 참조하세요.

https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-ubuntu-18-04-bionic-beaver-linux


### Install Nvidia-Docker

Docker 상에서 Nvidia GPU 를 이용하기 위해 Nvidia-Docker 를 사용합니다.

설치 방법은 아래 공식 설치 문서를 참조하세요.

https://github.com/NVIDIA/nvidia-docker

## Setup

env.sh.template 파일을 env.sh 로 복사하여 설정 변경이 가능합니다. 

```bash
#!/bin/bash

export HOSTNAME="docker-jupyter" 
export USERNAME=$(id -un) 
export USERID=$(id -u $USERNAME)
export LOCALE="ko_KR.UTF-8"

# Jupyter
export JUPYTER_NAME="jupyter"
export JUPYTER_PORT="8010" # Your Jupyter Port
export JUPYTER_HOME="$(pwd)"
export JUPYTER_MNT="/data" # Your External Mount
export JUPYTER_PASSWORD="notebooks" # Your Jupyter Password
export JUPYTER_BASEURL="jupyter" # Your Jupyter BaseURL, ex) http://localhost:8010/jupyter
export JUPYTER_RESTAPIPORT="8020" # Your Jupyter Kernel Gateway Port
export JUPYTER_IMAGE="comafire/docker-jupyter"
export JUPYTER_TAG="latest"
export JUPYTER_GPU_IMAGE="comafire/docker-jupyter-gpu"
export JUPYTER_GPU_TAG="latest"
export JUPYTER_GPU="FALSE"
```

## Build Docker Image

./docker_build.sh 명령을 통해 env.sh 에서 설정한 이미지를 빌드합니다.

Dockerfile 을 제공하므로 커스텀 이미지 빌드도 가능합니다.

## Run

./docker_run_jupyter.sh 명령으로 Jupyter Docker 이미지를 실행할 수 있습니다.

```bash
> ./docker_run_jupyter.sh
> docker ps
CONTAINER ID        IMAGE                                COMMAND              CREATED             STATUS              PORTS                                            NAMES
c63e1132d207        comafire/docker-jupyter:latest       "./run_jupyter.sh"   2 seconds ago       Up 1 second         0.0.0.0:8020->8088/tcp, 0.0.0.0:8010->8888/tcp   jupyter
```

이제, 설정한 Jupyter URL 인 http://localhost:8010/jupyter 로 접속하여 Jupyter를 사용할 수 있습니다.

## Install Extra Library

### Python

Jupyter 사용중 추가 외부 라이브러리가 필요하시면 Jupyter 상에서 Terminal 창을 띄우신 후에 pip3 명령을 사용하시면 됩니다.

Docker 실행시 자동 설치를 원하시면 requirements.txt 파일에 패키지를 추가하시면 됩니다.

## Option - Vagrant

Linux 에서 Virtual Box Virtual Machine 을 편리하게 관리하기 위한 툴로 Vagrant를 이용합니다.

docker-jupyter 를 로컬 머신상이 아닌 Virtual Machine 상에서 설치 테스트를 하기 위해 사용합니다.

### Install Vagrant

Vagrant를 아래 명령으로 설치 합니다. vagrant 의 virtual box disk 사이즈 설정 플러그인 기능을 사용하기 위해 특정 버전의 vagrant 를 설치합니다.

```bash
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
sudo apt update
sudo apt install virtualbox virtualbox-ext-pack
wget -c https://releases.hashicorp.com/vagrant/2.0.3/vagrant_2.0.3_x86_64.deb -P /tmp
sudo dpkg -i /tmp/vagrant_2.0.3_x86_64.deb
vagrant plugin install vagrant-disksize
```

### Vagrantfile

Virtual Machine 에서 사용할 네트워크/메모리/디스크 설정은 Vagrantfile 파일에서 자신에 맞게 수정하면 됩니다.

docker-jupyter 디렉토리는 Virtual box 내에 /home/vagrant/docker-jupyter 와 마운트되게 됩니다.

```bash
ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure("2") do |config|

  config.vm.define "v01" do |host|
    host.vm.box = "ubuntu/xenial64"
    host.vm.hostname = "v01"
    host.vm.network "public_network", ip: "192.168.0.70"
    #host.vm.network "private_network", ip: "10.0.1.1"
    host.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.cpus = 2
      vb.memory = "4096"
    end
    host.disksize.size = '16GB'
    host.vm.synced_folder "./", "/home/vagrant/docker-jupyter", owner: "vagrant", group: "vagrant"
  end

end
```

### Virtual Machine 생성 및 접속

docker-jupyter 디렉토리 내에서 아래 명령어를 통해 Virtual Box 의 Virtual Machine 을 생성하고 접속하여 사용할수 있습니다.

```
vagrant up
vagrant ssh v01
```
